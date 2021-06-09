
import 'package:bully_bucks/Flow/Auth/Signup/registerPage.dart';
import 'package:bully_bucks/Flow/Screens/studentHomeScreen.dart';
import 'package:bully_bucks/Flow/Screens/teacherHomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bully_bucks/Widgets/buttonRound.dart';
import 'package:bully_bucks/Widgets/Logo.dart';
import 'package:bully_bucks/Widgets/tectWidget.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bully_bucks/Firebase.dart';
class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.student}) : super(key: key);
  final bool student;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();
  TextEditingController emailCont=new TextEditingController();
  TextEditingController passCont=new TextEditingController();
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
                      Text("Log in",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 27,
                        ),
                      ),
                    ],
                  ),
                  TextWidget(text: "Email ID",controller: emailCont,onTap: mySetState,),
                  TextWidget(text: "Password",controller: passCont,onTap: mySetState,pass:true),
                  Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                  ButtonRound(text:"Go",onPress: (){
                    Database db=new Database();
                    db.signinUser(emailCont.text, passCont.text).then((value) {
                      if(value==1){
                        Fluttertoast.showToast(msg: "Welcome to BullyBucks");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TeacherHomeePage(email: emailCont.text,)));
                        }
                      else if(value==2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => StudentHome(email: emailCont.text,)));
                      }
                      else
                        {
                        Fluttertoast.showToast(msg: "Sign in attempt failed. Please make sure you have entered correct username/password combination.");
                        }
                    }).catchError((e){
                      Fluttertoast.showToast(msg: "Sign in attempt failed. Please make sure you have entered correct username/password combination.");
                      //Fluttertoast.showToast(msg: e.toString());
                    });
                  },),
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