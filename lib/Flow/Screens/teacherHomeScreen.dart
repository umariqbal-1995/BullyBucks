import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bully_bucks/Flow/Screens/reportPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbar_text_color/flutter_statusbar_text_color.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:platform_svg/platform_svg.dart';
import 'dart:developer';
import '../../Firebase.dart';
import "package:bully_bucks/main.dart";

class TeacherHomeePage extends StatefulWidget {
  final String email;
  TeacherHomeePage({Key key, this.email}) : super(key: key);
  @override
  _TeacherHomeePageState createState() => _TeacherHomeePageState();
}

class _TeacherHomeePageState extends State<TeacherHomeePage> {
  List<Widget> unverifiedlist = new List<Widget>();
  List<Widget> verifiedlist = new List<Widget>();
  List list = null;
  Map<dynamic, dynamic> map;
  List<Widget> verifiedListlist = new List<Widget>();
  List<Widget> nlist = new List<Widget>();
  @override
  void initState() {
    super.initState();
    try {
      if(Platform.isAndroid)
      {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Color.fromRGBO(226, 226, 226, 1), // Color for Android
            statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
        ));
      }
      else {
        FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(226, 226, 226, 1));
        FlutterStatusbarTextColor.setTextColor(
            FlutterStatusbarTextColor.dark);
      }
    } catch (_) {
      Fluttertoast.showToast(msg: "Error occured while changing status bar color");
    }
    Database db1 = new Database();
    db1.getUser(widget.email).then((value) {
      map = value;
      nlist.add(Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Montserrat",
            ),
          ),
          AutoSizeText(
            map["email"],
            style: TextStyle(fontFamily: "Montserrat"),
          ),
          Text(
            "First Name",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Montserrat",
            ),
          ),
          Text(
            map["fname"],
            style: TextStyle(fontFamily: "Montserrat"),
          ),
          Text(
            "Last Name",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
          ),
          Text(
            map["lname"],
            style: TextStyle(fontFamily: "Montserrat"),
          ),
          Text(
            "Phone",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
          ),
          Text(
            map["phone"],
            style: TextStyle(fontFamily: "Montserrat"),
          ),
        ],
      )));
      Database db = new Database();
      db.getReportsOSchool(map["school"]).then((value) {
        list = value;
        log("list " + list.toString());
        setState(() {});
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: "Something is Wrong with Database");
    });

    unverifiedlist = [Text("Please wait while We Load the Screen")];

    //Person profile code starts here
  }

  void onReturnBack() {
    unverifiedlist = [Text("Please wait while We Load the Screen")];
    Database db = new Database();
    db.getReportsOSchool(map["school"]).then((value) {
      list = value;
      log("list " + list.toString());
      setState(() {});
    }).catchError((e) {
      Fluttertoast.showToast(msg: "Something is Wrong with Database");
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    if (list != null) {
      unverifiedlist.clear();
      verifiedlist.clear();
      unverifiedlist.add(Text(
        "Pending Reports",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: "Montserrat"),
      ));
      verifiedlist.add(Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
      ));
      verifiedlist.add(Text("Marked Reports",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: "Montserrat")));
      list.forEach((element) {
        var startTime =
            DateTime.fromMillisecondsSinceEpoch(element["currentTime"]);
        var currentTime = DateTime.now();
        var diff = currentTime.difference(startTime);
        var min = diff.inMinutes;
        var hour = diff.inHours;
        var day = diff.inDays;
        String diffTime = "";

        if (hour <= 0 && day <= 0) {
          diffTime = min.toString() + " minutes ago";
        }
        if (hour > 0 && day <= 0) {
          diffTime = hour.toString() + " hours ago";
        }
        if (day > 0) {
          if (day > 1)
            diffTime = day.toString() + " days ago";
          else
            diffTime = day.toString() + " day ago";
        }
        if (element["verify"] == 0) {
          unverifiedlist.add(Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
              child: makeItem(
                  element["fname"].toString() +
                      " " +
                      element["lname"].toString(),
                  element["type"],
                  diffTime),
              onTap: () {
                // log(element["id"]);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReportShowPage(
                            teacherName: map["fname"] + " " + map["lname"],
                            map: element,
                          )),
                ).then((value) => onReturnBack());
              },
            ),
          ));
        } else {
          verifiedlist.add(Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
              child: makeItem(
                  element["fname"].toString() +
                      " " +
                      element["lname"].toString(),
                  element["type"],
                  diffTime),
              onTap: () {
                // log(element["id"]);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReportShowPage(
                            teacherName: map["fname"] + " " + map["lname"],
                            map: element,
                          )),
                );
              },
            ),
          ));
        }
      });
      if (unverifiedlist.length == 1) {
        unverifiedlist.clear();
        unverifiedlist.add(Text(
          "No Pending Reports",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: "Montserrat"),
        ));
      }
      if (verifiedlist.length == 2) {
        verifiedlist.clear();
        verifiedlist.add(Text(
          "No Marked Reports",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: "Montserrat"),
        ));
      }
    }
    List<Widget> wlist = unverifiedlist + verifiedlist;
    return WillPopScope(child: Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 15),
          color: Color.fromRGBO(226, 226, 226, 0.45),
          child: ListView(children: [
            makeAppbar(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 9),
              child: Column(
                children: wlist,
              ),
            )
          ]),
        ),
      ),
    ), onWillPop: ()async{
      try {
        if(Platform.isAndroid)
        {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Color.fromRGBO(44, 219, 152, 1),
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ));
        }
        else {
          FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(44, 219, 152, 1));
          FlutterStatusbarTextColor.setTextColor(
              FlutterStatusbarTextColor.light);
        }
      } catch (_) {
        Fluttertoast.showToast(msg: "Error occured while changing status bar color");
      }
      Navigator.pop(context);
      return true;
    });
  }

  Widget makeItem(String name, String type, String time) {
    return (Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(10, 30, 15, 30),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(190, 190, 190, 1), //edited
                spreadRadius: 4,
                blurRadius: 3)
          ],
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      margin: EdgeInsets.only(right: 8, top: 8),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3),
                child:
                    PlatformSvg.asset("assets/images/person.svg", height: 70),
              ),
            ),
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: Color.fromRGBO(44, 219, 152, 1), fontSize: 20),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      type.capitalize() + " Bullying | " + time,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: PlatformSvg.asset("assets/images/forward.svg",
                      height: 20),
                )),
          ],
        ),
      ),
    ));
  }

  Widget makeAppbar() {
    return (Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
        ),
        GestureDetector(
          child: Image(
            image: AssetImage(
              'assets/images/backBtn.png',
            ),
            height: 35,
          ),
          onTap: () {
            try {
              if(Platform.isAndroid)
              {
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                  statusBarColor: Color.fromRGBO(44, 219, 152, 1),
                  statusBarBrightness: Brightness.light,
                  statusBarIconBrightness: Brightness.light,
                ));
              }
              else {
                FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(44, 219, 152, 1));
                FlutterStatusbarTextColor.setTextColor(
                    FlutterStatusbarTextColor.light);
              }
            } catch (_) {
              Fluttertoast.showToast(msg: "Error occured while changing status bar color");
            }
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                "Bully",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "Bucks",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        GestureDetector(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  map == null ? "N" : map["fname"].toString()[0].toUpperCase(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                      color: Colors.white),
                ),
                Text(
                  map == null ? "A" : map["lname"].toString()[0].toUpperCase(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                      color: Colors.white),
                )
              ],
            ),
            decoration: new BoxDecoration(
              color: Color.fromRGBO(22, 88, 63, 1),
              shape: BoxShape.circle,
            ),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return new AlertDialog(
                      elevation: 10,
                      title: Text(
                        "Profile Details",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      content: Container(
                        width: 100,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        child: Wrap(
                          children: nlist,
                        ),
                      ));
                });
          },
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 4.0))
      ],
    ));
  }
}
