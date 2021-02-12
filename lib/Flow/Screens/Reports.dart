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
class ReportPage extends StatefulWidget {
  final String email;

  const ReportPage({Key key, this.email}) : super(key: key);
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  TextEditingController tcn1 =new TextEditingController();
  TextEditingController tcn2 =new TextEditingController();
  TextEditingController tcn3 =new TextEditingController();
  TextEditingController tcn4 =new TextEditingController();
  TextEditingController tcn5 =new TextEditingController();
  int _value1=1;
  int _value2=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(226, 226, 226,1),
        body: SafeArea(
        child: Padding(
         padding: EdgeInsets.all(10),
         child:ListView(
           children: <Widget>[
             makeAppbar(),
            Padding(padding: EdgeInsets.symmetric(vertical: 5),child: TextWidget(text: "Who was the bully?",controller: tcn1,onTap: mySetState,green: true,),),
             Padding(padding: EdgeInsets.symmetric(vertical: 5),child: TextWidget(text: "Who was the victim",controller: tcn2,onTap: mySetState,green: true,),),
             Padding(padding: EdgeInsets.symmetric(vertical: 5),child: dropDown1(),),
             Padding(padding: EdgeInsets.symmetric(vertical: 5),child: dropDown2(),),
             Padding(padding: EdgeInsets.symmetric(vertical: 5),child: TextWidget(text: "Location",controller: tcn3,onTap: mySetState,green: true,),),
             Padding(padding: EdgeInsets.symmetric(vertical: 5),child: TextWidget(text: "Time",controller: tcn4,onTap: mySetState,green: true,),),
             Padding(padding: EdgeInsets.symmetric(vertical: 5),child: multilineField("Description of the incident "),),
             Padding(padding: EdgeInsets.symmetric(vertical: 0),child: Padding(padding: EdgeInsets.symmetric(vertical: 5),child: Button("Submit Report"),)),
           ]
         ),
    )
    )
    );
  }
  Widget Button(String text){
    return(
      Container(
        height: 80,
        child: FlatButton(onPressed: ()=>submit(),child: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 20,),)),
        width: double.infinity,
        decoration: ShapeDecoration(
            color: Color.fromRGBO(44, 219, 152, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )
        ),
      )
    );
  }
  Widget multilineField(String hint){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: TextField(
          controller: tcn5,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          minLines: 4,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: hint
          ),
        ),
      ),
    );

  }
  
  void mySetState(){
    setState(() {

    });
  }
  Widget dropDown1(){
      return DropdownButtonFormField(
        value: _value1,
        items: [
          DropdownMenuItem(child: Text("Type of Bullying"),value: 1,),
          DropdownMenuItem(child: Text("Physical"),value: 2,),
          DropdownMenuItem(child: Text("verbal"),value: 3,),
          DropdownMenuItem(child: Text("Physical"),value: 4,),
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
        DropdownMenuItem(child: Text("Your Role"),value: 1,),
        DropdownMenuItem(child: Text("Witness"),value: 2,),
        DropdownMenuItem(child: Text("Victim"),value: 3,),
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
  Widget makeAppbar(){
    return (Row(
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: PlatformSvg.asset("assets/images/forward.svg",height: 20,),
        ),
        Expanded(
          child:Text("Report",textAlign: TextAlign.center,),
        )

      ],
    ));
  }
  void submit()
  {
      Database db=new Database();
      db.submitReport(widget.email, tcn1.text, tcn2.text, tcn3.text, tcn4.text, tcn5.text, _value1, _value2).then((value){
        if(value==true){
          Fluttertoast.showToast(msg: "Report Added Successfully");
        }
      }).catchError((e){
        Fluttertoast.showToast(msg:e.toString());
      });
  }
}