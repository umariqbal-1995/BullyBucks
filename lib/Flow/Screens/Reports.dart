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
import 'package:date_time_picker/date_time_picker.dart';
import 'package:bully_bucks/email.dart';
class ReportPage extends StatefulWidget {
  final String email;
  final String school;
  const ReportPage({Key key, this.email, this.school}) : super(key: key);
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
            DateTimePicker(
              type: DateTimePickerType.dateTimeSeparate,
              use24HourFormat: false,
              dateMask: 'd MMM, yyyy',
              initialValue: "",
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              icon: Icon(Icons.event),
              dateLabelText: 'Date',
              timeLabelText: "Time",
              selectableDayPredicate: (date) {
                // Disable weekend days to select from the calendar
                if (date.weekday == 6 || date.weekday == 7) {
                  return false;
                }

                return true;
              },
              onChanged: (val) => tcn4.text=val,
              validator: (val) {
                tcn4.text=val;
                return null;
              },
              onSaved: (val) => tcn4.text=val,
            ),

             Padding(padding: EdgeInsets.symmetric(vertical: 5),child: multilineField("Description of the incident "),),
             Padding(padding: EdgeInsets.symmetric(vertical: 0),child: Padding(padding: EdgeInsets.symmetric(vertical: 5),child: Button("Submit Report"),)),
           ]
         ),
    )
    )
    );
  }
  void selectTime(){
    _selectTime(context);
    setState(() {

    });
  }
  void  _selectTime(BuildContext context) async {
    DateTimePicker(
      type: DateTimePickerType.dateTimeSeparate,
      dateMask: 'd MMM, yyyy',
      initialValue: DateTime.now().toString(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      icon: Icon(Icons.event),
      dateLabelText: 'Date',
      timeLabelText: "Hour",
      selectableDayPredicate: (date) {
        // Disable weekend days to select from the calendar
        if (date.weekday == 6 || date.weekday == 7) {
          return false;
        }

        return true;
      },
      onChanged: (val) => print(val),
      validator: (val) {
        print(val);
        return null;
      },
      onSaved: (val) => print(val),
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
          DropdownMenuItem(child: Text("Type of Bullying",style: TextStyle(fontFamily: "Montserrat"),),value: 1,),
          DropdownMenuItem(child: Text("Physical",style: TextStyle(fontFamily: "Montserrat"),),value: 2,),
          DropdownMenuItem(child: Text("Verbal",style:TextStyle(fontFamily: "Montserrat")),value: 3,),
          DropdownMenuItem(child: Text("Cyber",style:TextStyle(fontFamily: "Montserrat")),value: 4,),
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
        DropdownMenuItem(child: Text("What was your Role",style: TextStyle(fontFamily: "Montserrat")),value: 1,),
        DropdownMenuItem(child: Text("Witness",style: TextStyle(fontFamily: "Montserrat")),value: 2,),
        DropdownMenuItem(child: Text("Victim",style: TextStyle(fontFamily: "Montserrat")),value: 3,),
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
          child: GestureDetector(child: PlatformSvg.asset("assets/images/forward.svg",height: 20,),onTap: (){
            Navigator.pop(context);
          },)
        ),
        Expanded(
          child:Text("Report",textAlign: TextAlign.center,),
        )

      ],
    ));
  }
  void submit()
  {
   bool valid=true;
   if(tcn1.text==""){
     valid=false;
   }
   if(tcn2.text=="")
     valid=false;
   if(tcn3.text=="")
     valid=false;
   if(tcn4.text=="")
     valid=false;
   if(tcn5.text=="")
     valid=false;
    if(_value1==1)
      valid=false;
    if(_value2==false)
      valid=false;
   if(valid){
     Database db=new Database();
     db.submitReport(widget.email, tcn1.text, tcn2.text, tcn3.text, tcn4.text, tcn5.text, _value1, _value2).then((value){
       if(value==true){
         Fluttertoast.showToast(msg: "Report Added Successfully");
         sendEmail();
         Navigator.pop(context);
       }
     }).catchError((e){
       Fluttertoast.showToast(msg: "Something is Wrong with Database");
     });
   }
   else
     {
       Fluttertoast.showToast(msg: "Please fill all fields before submitting the report");
     }

  }
  void sendEmail()async {
    String type;
    String role;
    if(_value2==2){
      type="Physical";
    }
    if(_value1==3){
      type="Verbal";
    }
    if(_value1==4){
      type="Cyber";
    }
    if(_value2==2){
      role="Witness";
    }
    if(_value2==3){
      role="Victim";
    }
    List<dynamic> list=await new Database().getAllTeachersOfSchool(widget.school);
    list.forEach((element) {
      String e=element.toString().replaceAll(",", ".");
      Email.sendEmail(e, "Bully Bucks New Report", ""
          "The Report has been auto generated on report add from bully bucks app\n"
          "It is reported that "+widget.email+" has reported "+ tcn1.text +" "+type+" bullying "+tcn2.text+""
          " at "+tcn4.text+ " in "+tcn3.text + " where his/her role was "+role +" with description "+tcn5.text);
    });
  }
}