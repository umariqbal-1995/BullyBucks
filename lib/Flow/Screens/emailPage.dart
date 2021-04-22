import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:platform_svg/platform_svg.dart';
import 'dart:math' as math;
import 'package:bully_bucks/email.dart';

import '../../Firebase.dart';
class EmailPage extends StatefulWidget {
  final String email;
  final String school;
  EmailPage({Key key, this.email, this.school}) : super(key: key);

  @override
  _EmailPageState createState() => _EmailPageState();
}
class _EmailPageState extends State<EmailPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(44, 219, 152, 1)
    ));
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(0,10,10,0),
            color: Color.fromRGBO(226, 226, 226, 0.45),
            child: ListView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Stack(
                  children: [
                    makeUnderContainer(),
                    Padding(padding: EdgeInsets.fromLTRB(40,50,40,0),
                     //child: makeUppercard(),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
  TextEditingController tcn1=new TextEditingController();
  Widget makeUppercard(){
      return(Container(
        padding:EdgeInsets.fromLTRB(10,20,10,25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Color.fromRGBO(44, 219, 152, 1),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(10,0,0,0),
          child: Row(
            children: [
              Flexible(flex: 2,child: Image(image: AssetImage('assets/images/send.png',), height: 30,),),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),),
              Flexible(flex: 5,child: TextFormField(
                controller: tcn1,
              decoration: InputDecoration(
                  hintText: "Who to send the email",
                  hintStyle: TextStyle(color:Colors.white,fontSize: 13)
              ),
            ),)
            ],
          ),
        ),
      )
      );
  }
  Widget makeUnderContainer(){
    return(Container(
      child: Column(
        children: [
          makeAppbar("Email"),
          Container(
            padding: EdgeInsets.fromLTRB(20, 70, 20, 0),
            child:   Container(
              padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.white
              ),
              child: multilineField("Type you email here")
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          FlatButton(onPressed: ()async{
            Database db=new Database();
            var list=await db.getAllTeachersOfSchool(widget.school);
            if(tcn2.text!="") {
              list.forEach((element) {
                Email.sendEmail(element.toString().replaceAll(",", "."),
                    "Sent From Bully Bucks", ""
                        "The was sent from " + widget.email + "\n" +
                        tcn2.text);
              });

              Navigator.pop(context);
            }
            else
              {
                Fluttertoast.showToast(msg: "No text entered in email");
              }
          },
              child: Container(
                padding: EdgeInsets.fromLTRB(15,20,15,20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.black
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(10,10,10,10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white
                  ),
                  child: PlatformSvg.asset("assets/images/send.svg",height: 20),
                ),
              ),

          )
        ],
      ),
    )
    );
  }
  Widget makeAppbar(String name){
    return (Row(
      children: [
        Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: GestureDetector(child: PlatformSvg.asset("assets/images/forward.svg",height: 20,),onTap: (){
              Navigator.pop(context);
            },)
        ),
        Expanded(
          child:Text(name,textAlign: TextAlign.center,style:TextStyle(
        fontWeight: FontWeight.bold, fontFamily: "Montserrat",fontSize: 18,)),
        )
      ],
    ));
  }
  TextEditingController tcn2=new TextEditingController();
  Widget multilineField(String hint){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: TextField(
          controller: tcn2,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          minLines: 20,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color:Colors.grey,width: 0.3),
              ),
              hintText: hint,
            hintStyle: TextStyle(color: Colors.grey)
          ),
        ),
      ),
    );
  }
}
