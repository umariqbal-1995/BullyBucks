import 'package:bully_bucks/Flow/Screens/reportPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_svg/platform_svg.dart';
import 'dart:developer';
import '../../Firebase.dart';

class TeacherHomeePage extends StatefulWidget {
  @override
  _TeacherHomeePageState createState() => _TeacherHomeePageState();
}

class _TeacherHomeePageState extends State<TeacherHomeePage> {
  List<Widget> wlist;
  List list=null;
  @override
  void initState() {
    super.initState();
    wlist=[Text("Please wait while we load stuff")];
    Database db=new Database();
    db.getVerified().then((value) {
      list=value;
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    if(list!=null){
      wlist.clear();
      list.forEach((element) {
        wlist.add(Container(padding: EdgeInsets.symmetric(vertical: 10),child: GestureDetector(
          child: makeItem(element["fname"].toString()+" "+element["lname"].toString(), element["type"], " 5 min ago"),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReportShowPage(map: element,)),
            );
          },
        ),));
        //log("from init "+ element);
      });
    }
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(0,8,0,15),
          color: Color.fromRGBO(226, 226, 226, 0.45),
          child: ListView(
            children: [
              makeAppbar(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9),
                child: Column(
                  children: wlist,
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
  Widget makeItem(String name,String type,String time){
    return(
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(10,30,15,30),
          decoration: BoxDecoration(
             boxShadow:[BoxShadow(color: Color.fromRGBO(190, 190, 190, 1), //edited
                 spreadRadius: 4,
                 blurRadius: 3 )],
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius:BorderRadius.all(
                  Radius.circular(25)
              )
          ),
          margin: EdgeInsets.only(right: 8,top: 8),
          child:Padding(
            padding: EdgeInsets.fromLTRB(0,0,0,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(flex:2,fit:FlexFit.tight,child:Padding(padding: EdgeInsets.symmetric(horizontal: 3),child: PlatformSvg.asset("assets/images/person.svg",height: 70),),),
                Flexible(flex: 4,fit: FlexFit.tight,child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,style: TextStyle(color: Color.fromRGBO(44, 219, 152, 1),fontSize: 20),),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(type+" Bullying -"+time,style: TextStyle(fontSize: 13),),
                    ),
                  ],
                ), ),
                Flexible(flex: 1,fit: FlexFit.tight,child:Padding(padding: EdgeInsets.all(0),child: PlatformSvg.asset("assets/images/forward.svg",height: 20),) ),

              ],
            ),
          ),
        )
    );
  }
  Widget makeAppbar() {
    return (Row(
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 4),),
        Image(image: AssetImage('assets/images/backBtn.png',), height: 35,),
        Expanded(child: Row(
          children: [
            Text("Bully", style: TextStyle(color: Colors.black),),
            Text("Bucks", style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        ),
        PlatformSvg.asset("assets/images/person.svg",height: 40),
        Padding(padding: EdgeInsets.symmetric(horizontal: 4.0))
      ],
    )
    );
  }
}
