import 'dart:developer';
import 'dart:ui';
import 'package:bully_bucks/Firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bully_bucks/Widgets/Logo.dart';
import 'package:bully_bucks/Flow/Auth/Login/loginGender.dart';
import 'package:bully_bucks/Flow/Auth/Signup/registerPage.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:platform_svg/platform_svg.dart';
import 'package:menu_button/menu_button.dart';
import 'package:bully_bucks/Widgets/tectWidget.dart';
import 'dart:math' as math;
import 'package:bully_bucks/email.dart';

class ProductPage extends StatefulWidget {
  final String school;
  final String mEmail;
  final String path;
  final String price;
  final String captionn;
  final String email;
  final String options1;
  final String options2;
  final String options3;
   ProductPage(
      {Key key,
      this.path,
      this.price,
      this.captionn,
      this.email,
      this.options1,
      this.options2,
      this.options3,
      this.school, this.mEmail})
      : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _value1 = 1;
  int _value2 = 1;
  int _value3 = 1;
  String merchantName;
  String email;
  String mEmail;
  String mName = "Merchant Name";
  Map<dynamic, dynamic> map;
  @override
  void initState() {
    super.initState();
    Database db = new Database();

      mEmail = widget.mEmail;
      db.getMerchant(mEmail).then((value) {
        map = value;
        //Fluttertoast.showToast(msg: value.toString());
        mName = map["name"];
        setState((){});
    }).catchError((e) {
      Fluttertoast.showToast(msg: "Something is wrong with Database");
    });
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          color: Color.fromRGBO(226, 226, 226, 0.45),
          child: ListView(
            children: [
              makeAppbar(),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 40, 5, 10),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Image.network(widget.path),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(
                  widget.captionn,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(
                  widget.price + " bully bucks",
                  style: TextStyle(
                      color: Color.fromRGBO(44, 219, 152, 1), fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  mName,
                  style: TextStyle(
                      color: Color.fromRGBO(44, 219, 152, 1), fontSize: 15),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: dropDown1()),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: dropDown2(),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: dropDown3(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: FlatButton(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(60, 25, 60, 25),
                    child: Text(
                      "Buy",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Colors.black),
                  ),
                  onPressed: () {
                    Database db = new Database();
                    db
                        .minusBullyBucks(widget.email, int.parse(widget.price))
                        .then((value) {
                      if (value == 0) {
                        Fluttertoast.showToast(
                            msg: "Your purchase is complete");
                        SendEmail();
                        Database db=new Database();
                        db.addaOrder(widget.email, widget.captionn, int.parse(widget.price), widget.mEmail).then((value) {
                          Fluttertoast.showToast(msg: "Data added to database").catchError((e){
                            Fluttertoast.showToast(msg: e.toString());
                          });
                        });
                      } else
                        Fluttertoast.showToast(
                            msg: "Sorry you do not have sufficient balance for the purchase");
                    }).catchError((e) {
                      Fluttertoast.showToast(
                          msg: "Something is wrong with the Database");
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget makeAppbar() {
    return (Row(
      children: [
        Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: GestureDetector(
              child: PlatformSvg.asset(
                "assets/images/forward.svg",
                height: 20,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )),
      ],
    ));
  }

  Widget dropDown3() {
    List<DropdownMenuItem<int>> items = new List<DropdownMenuItem<int>>();
    int n = 1;
    items.add(
      DropdownMenuItem(
        child: Text(
          "Variant",
          style: TextStyle(fontFamily: "Montserrat"),
        ),
        value: n,
      ),
    );
    var stringList = widget.options3.split(",");
    for (String element in stringList) {
      n = n + 1;
      items.add(DropdownMenuItem(
        child: Text(
          element,
          style: TextStyle(fontFamily: "Montserrat"),
        ),
        value: n,
      ));
    }
    return (stringList.length==1 && stringList[0]=="") ? Container() : DropdownButtonFormField(
      value: _value3,
      items: items,
      decoration: InputDecoration(border: OutlineInputBorder()),
      onChanged: (int value) {
        setState(() {
          _value1 = value;
        });
      },
    );
  }

  Widget dropDown2() {
    List<DropdownMenuItem<int>> items = new List<DropdownMenuItem<int>>();
    int n = 1;
    items.add(
      DropdownMenuItem(
        child: Text(
          "Color",
          style: TextStyle(fontFamily: "Montserrat"),
        ),
        value: n,
      ),
    );

    var stringList = widget.options2.split(",");
    for (String element in stringList) {
      n = n + 1;
      items.add(DropdownMenuItem(
        child: Text(
          element,
          style: TextStyle(fontFamily: "Montserrat"),
        ),
        value: n,
      ));
    }

    return (stringList.length==1 && stringList[0]=="") ? Container() : DropdownButtonFormField(
      value: _value2,
      items: items,
      decoration: InputDecoration(border: OutlineInputBorder()),
      onChanged: (int value) {
        setState(() {
          _value1 = value;
        });
      },
    );
  }

  Widget dropDown1() {
    List<DropdownMenuItem<int>> items = new List<DropdownMenuItem<int>>();
    int n = 1;
    items.add(
      DropdownMenuItem(
        child: Text(
          "Size",
          style: TextStyle(fontFamily: "Montserrat"),
        ),
        value: n,
      ),
    );
    var stringList = widget.options1.split(",");
    for (String element in stringList) {
      n = n + 1;
      items.add(DropdownMenuItem(
        child: Text(
          element,
          style: TextStyle(fontFamily: "Montserrat"),
        ),
        value: n,
      ));
    }
    return (stringList.length==1 && stringList[0]=="") ? Container() : DropdownButtonFormField(
      value: _value1,
      items: items,
      decoration: InputDecoration(border: OutlineInputBorder()),
      onChanged: (int value) {
        setState(() {
          _value1 = value;
        });
      },
    );
  }

  void SendEmail() async {
    String size;
    String color;
    String variant;
    var sizeList = widget.options1.split(",");
    var colorList = widget.options1.split(",");
    var variantList = widget.options1.split(",");
    if (sizeList.length > 1) {
      size = sizeList.elementAt(_value1 - 2);
    } else {
      size = "N/A";
    }
    if (colorList.length > 1) {
      color = colorList.elementAt(_value1 - 2);
    } else {
      color = "N/A";
    }
    if (variantList.length > 1) {
      variant = variantList.elementAt(_value1 - 2);
    } else {
      variant = "N/A";
    }
    String text = "An order has been made from " +
        widget.email +
        ""
            "  for\n "
            "Product Name " +
        widget.captionn +
        "\n"
            "Size " +
        size +
        "\n"
            "Color " +
        color +
        "\n"
            "Variant " +
        variant +
        "\n";
    mEmail=mEmail.replaceAll(",", ".");
    Email.sendEmail(mEmail, "Order Placed From Bully Bucks", text);
    Email.sendEmail("mybullybucks@gmail.com", "Order Placed From Bully Bucks", text);

  }
}
