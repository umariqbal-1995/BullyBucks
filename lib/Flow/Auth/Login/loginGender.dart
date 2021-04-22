import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bully_bucks/Widgets/buttonRound.dart';
import 'package:bully_bucks/Widgets/Logo.dart';
import 'package:flutter/services.dart';
class LoginGender extends StatefulWidget {
  var  mySystemTheme= SystemUiOverlayStyle.light
      .copyWith(systemNavigationBarColor: Color.fromRGBO(44, 219, 152, 1));
  LoginGender({Key key, this.student}) : super(key: key);
  final bool student;
  @override
  _LoginGenderState createState() => _LoginGenderState();
}
class _LoginGenderState extends State<LoginGender> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(widget.mySystemTheme);
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
              ButtonRound(text:"Student",onPress: (){},),
              ButtonRound(text: "Teacher",onPress: (){},),
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
