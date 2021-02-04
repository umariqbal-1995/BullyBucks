
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bully_bucks/Widgets/buttonRound.dart';
import 'package:bully_bucks/Widgets/Logo.dart';
import 'package:bully_bucks/Widgets/tectWidget.dart';
class StudentRegister extends StatefulWidget {
  StudentRegister({Key key, this.student}) : super(key: key);
  final bool student;

  @override
  _StudentRegisterState createState() => _StudentRegisterState();
}

class _StudentRegisterState extends State<StudentRegister> {
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
             TextWidget(text: "First Name",controller: new TextEditingController(),onTap: mySetState,),
              TextWidget(text: "Last name",controller: new TextEditingController(),onTap: mySetState,),
              TextWidget(text: "Email ID",controller: new TextEditingController(),onTap: mySetState,),
              TextWidget(text: "Password",controller: new TextEditingController(),onTap: mySetState,pass:true),
              TextWidget(text: "School",controller: new TextEditingController(),onTap: mySetState,),
              TextWidget(text: "Phone",controller: new TextEditingController(),onTap: mySetState,),
              Padding(padding: EdgeInsets.symmetric(vertical: 6)),
              ButtonRound(text:"Submit",onPress: (){},)
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
