
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bully_bucks/Widgets/buttonRound.dart';
import 'package:bully_bucks/Widgets/Logo.dart';
import 'package:bully_bucks/Widgets/tectWidget.dart';
class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.student}) : super(key: key);
  final bool student;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(44, 219, 152, 1),
        body:Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Register",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 27,
                        ),
                      ),
                    ],
                  ),
                  TextWidget(text: "Email ID",controller: new TextEditingController(),onTap: mySetState,),
                  TextWidget(text: "Password",controller: new TextEditingController(),onTap: mySetState,pass:true),
                  Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                  ButtonRound(text:"Go",onPress: (){},)
                ],
              ),
            )
        )
    );
  }
  mySetState(){
    setState(() {

    });
  }
}