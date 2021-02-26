import 'dart:ui';
import 'package:bully_bucks/Firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bully_bucks/Widgets/Logo.dart';
import 'package:bully_bucks/Flow/Auth/Login/loginGender.dart';
import 'package:bully_bucks/Flow/Auth/Signup/registerPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:platform_svg/platform_svg.dart';
import 'package:menu_button/menu_button.dart';
import 'package:bully_bucks/Widgets/tectWidget.dart';
import 'dart:math' as math;
class ProductPage extends StatefulWidget {
  final String path;
  final String price;
  final String captionn;
  final String email;

  const ProductPage({Key key, this.path, this.price, this.captionn, this.email}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _value1=1;
  int _value2=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(10,5,10,0),
          color: Color.fromRGBO(226, 226, 226, 0.45),
          child: Column(
            children: [
              makeAppbar(),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 40, 5, 10),
                child:Container(
                height: 200,
                width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  child: Image.network(widget.path),
              ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0,5,0,0),child: Text(widget.captionn,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
              ),),),
              Padding(padding: EdgeInsets.fromLTRB(0,10,0,0),child: Text(widget.price,style: TextStyle(color: Color.fromRGBO(44, 219, 152, 1),fontSize: 15),), ),
              Padding(padding: EdgeInsets.fromLTRB(0,30,0,0),child:dropDown1() ),
              Padding(padding: EdgeInsets.fromLTRB(0,15,0,0),child: dropDown2(), ),
              Padding(padding: EdgeInsets.symmetric(vertical: 40),
              child: FlatButton(
                child: Container(
                  padding: EdgeInsets.fromLTRB(60, 25, 60, 25),
                  child: Text("Buy",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.black
                  ),
                ),
              ),
              )

            ],
          ),
        ),
      ),
    );
  }
  Widget makeAppbar(){
    return (Row(
      children: [
        Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: GestureDetector(child: PlatformSvg.asset("assets/images/forward.svg",height: 20,),onTap: (){
              Navigator.pop(context);
            },)
        ),
      ],
    ));
  }
  Widget dropDown1(){
    return DropdownButtonFormField(
      value: _value1,
      items: [
        DropdownMenuItem(child: Text("Size",style: TextStyle(fontFamily: "Montserrat"),),value: 1,),
        DropdownMenuItem(child: Text("XS",style: TextStyle(fontFamily: "Montserrat"),),value: 2,),
        DropdownMenuItem(child: Text("L",style:TextStyle(fontFamily: "Montserrat")),value: 3,),
        DropdownMenuItem(child: Text("M",style:TextStyle(fontFamily: "Montserrat")),value: 4,),
        DropdownMenuItem(child: Text("L",style:TextStyle(fontFamily: "Montserrat")),value: 5,),
        DropdownMenuItem(child: Text("XL",style:TextStyle(fontFamily: "Montserrat")),value: 6,),
      ],
      decoration: InputDecoration(border:OutlineInputBorder()
      ),
      onChanged: (int value){
        setState(() {
          _value1=value;
        });
      },
    );
  }
  Widget dropDown2(){
    return DropdownButtonFormField(
      value: _value2,
      items: [
        DropdownMenuItem(child: Text("Color"),value: 1,),
        DropdownMenuItem(child: Text("Black"),value: 2,),
        DropdownMenuItem(child: Text("Blue"),value: 3,),
        DropdownMenuItem(child: Text("Red"),value: 4,),
      ],
      decoration: InputDecoration(border:OutlineInputBorder()
      ),
      onChanged: (int value){
        setState(() {
          _value2=value;
        });
      },
    );
  }
}
