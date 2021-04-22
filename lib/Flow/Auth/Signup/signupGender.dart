
import 'package:bully_bucks/Flow/Auth/Signup/registerPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bully_bucks/Widgets/buttonRound.dart';
import 'package:bully_bucks/Widgets/Logo.dart';
import 'package:flutter/services.dart';
class SignupGender extends StatefulWidget {
  SignupGender({Key key, this.student}) : super(key: key);
  final bool student;
  String gender="student";
  @override
  _SignupGenderState createState() => _SignupGenderState();
}
class _SignupGenderState extends State<SignupGender> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(44, 219, 152, 1)
    ));
    return Scaffold(
      backgroundColor: Color.fromRGBO(44, 219, 152, 1),
      body:Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              children: [Padding(padding: EdgeInsets.fromLTRB(0, 150, 0, 0)),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("I am a...",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                  color: Colors.white,
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
              ButtonRound(text:"Student",onPress: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentRegister(student: "student",)));
              },),
              ButtonRound(text: "Teacher",onPress: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentRegister(student: "teacher",)));
              },),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Logo(),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 40))
            ],
          )
        ],
      ),
    );
  }
}
