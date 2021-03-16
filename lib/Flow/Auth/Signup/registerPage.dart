import 'package:bully_bucks/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bully_bucks/Widgets/buttonRound.dart';
import 'package:bully_bucks/Widgets/Logo.dart';
import 'package:bully_bucks/Widgets/tectWidget.dart';
import 'package:bully_bucks/Firebase.dart';
import 'package:bully_bucks/Flow/Auth/Login/loginPage.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
class StudentRegister extends StatefulWidget {
  StudentRegister({Key key, this.student}) : super(key: key);
  final String student;
  @override
  _StudentRegisterState createState() => _StudentRegisterState();
}
class _StudentRegisterState extends State<StudentRegister> {
  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();
  TextEditingController fnameCont=new TextEditingController();
  TextEditingController lnameCont=new TextEditingController();
  TextEditingController emailCont=new TextEditingController();
  TextEditingController passwordCont=new TextEditingController();
  TextEditingController schoolCont=new TextEditingController();
  TextEditingController phoneCont=new TextEditingController();
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
             TextWidget(text: "First Name",controller: fnameCont,onTap: mySetState,),
              TextWidget(text: "Last name",controller: lnameCont,onTap: mySetState,),
              TextWidget(text: "Email ID",controller: emailCont,onTap: mySetState,),
              TextWidget(text: "Password",controller: passwordCont,onTap: mySetState,pass:true),
              TextWidget(text: "School",controller: schoolCont,onTap: mySetState,),
              TextWidget(text: "Phone",controller: phoneCont,onTap: mySetState,),
              Padding(padding: EdgeInsets.symmetric(vertical: 6)),
              ButtonRound(text:"Submit",onPress: ()
              { Database db = new Database();
              db.hasID(emailCont.text).then((value) {
                if(Valid()==true){
                  if (value == false) {
                    db.addUser(
                        fnameCont.text,
                        lnameCont.text,
                        emailCont.text,
                        passwordCont.text,
                        schoolCont.text,
                        phoneCont.text,
                        widget.student).then((value) {
                      Fluttertoast.showToast(msg: "Congratulations You have Registered Successfully");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()),
                      );
                    }).catchError((e) {
                      Fluttertoast.showToast(msg: e.toString());
                    });
                  } else {
                    Fluttertoast.showToast(msg: "The User already exist");
                  }
                }
              });
              },
              )
            ],
          ),
        )
      )
    );
  }
  bool Valid(){
    if(fnameCont.text==""){
      Fluttertoast.showToast(msg: "First name must be filled");
      return false;
    }
    else if(lnameCont.text==""){
      Fluttertoast.showToast(msg: "Last name must be filled");
      return false;
    }
    else if(schoolCont.text==""){
      Fluttertoast.showToast(msg: "School must be filled");
      return false;
    }
    else if(phoneCont.text==""){
      Fluttertoast.showToast(msg: "Phone must be filled");
      return false;
    }
    else if(emailCont.text==""){
      Fluttertoast.showToast(msg: "Email must be filled");
      return false;
    }
    else if(!(emailCont.text.contains("@") && emailCont.text.contains("."))){
      Fluttertoast.showToast(msg: "Please Enter a valid Email");
      return false;
      }

    else if(passwordCont.text==""){
      if(passwordCont.text.length<6){
        Fluttertoast.showToast(msg: "Password must be more then 6 characters");
        return false;
      }
      Fluttertoast.showToast(msg: "Password must be filled");
      return false;
    }
    return true;
  }
  mySetState(){
    setState(() {

    });
  }
}
