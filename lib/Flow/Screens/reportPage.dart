import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:platform_svg/platform_svg.dart';
import 'dart:math' as math;

import '../../Firebase.dart';
class ReportShowPage extends StatefulWidget {
  final Map<dynamic,dynamic> map;

  const ReportShowPage({Key key, this.map}) : super(key: key);
  @override
  _ReportShowPageState createState() => _ReportShowPageState();
}
class _ReportShowPageState extends State<ReportShowPage> {

  @override
  Widget build(BuildContext context) {
    log("map "+widget.map.toString());
    String valid="";
    if(widget.map["verify"]==1)
      valid="Valid Report";
    else if(widget.map["verify"]==2)
      valid="Fake Report";
    else
      valid="Pending Approval";
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          color: Color.fromRGBO(226, 226, 226, 0.45),
          child: ListView(
            children: [
              makeAppbar(widget.map["fname"]),
              makeForm(1,"Bully",widget.map["bully"]),
              makeForm(0,"Victim",widget.map["victim"]),
              makeForm(0,"Type of Bullying",widget.map["type"]),
              makeForm(0,"Role",widget.map["role"]),
              makeForm(0,"Location",widget.map["location"]),
              makeForm(3,"Time",widget.map["time"]),
              Container(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Button("Valid Report", 1, () {
                  Database db=new Database();
                  db.verifyReport(widget.map["email"], widget.map["id"], 1).then((value) {
                    Fluttertoast.showToast(msg: "Report Marked as valid");
                    db.addBullyBucks(widget.map["email"], 20);
                    Fluttertoast.showToast(msg: "Bully Bucks Added");
                  });
                }),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Button("Fake Report", 2, () {
                  Database db=new Database();
                  db.verifyReport(widget.map["email"], widget.map["id"], 2);
                  Fluttertoast.showToast(msg: "Marked as invalid");

                }),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget makeForm(int i,String key,String value){
    return (
    Container(
      padding: i==1?EdgeInsets.fromLTRB(0,30,0,1):EdgeInsets.symmetric(vertical: 2),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color:Colors.black,width: 0.1),
              borderRadius: i==1?BorderRadius.vertical(top: Radius.circular(30)):i==3?BorderRadius.vertical(bottom: Radius.circular(30)):null
            ),
            child: Row(
              children: [
                Flexible(flex: 4,fit: FlexFit.tight,child: Text(key,style: TextStyle(fontWeight: FontWeight.bold),)),
                Flexible(flex: 1,fit: FlexFit.loose,child: Text(value)),
              ],
            ),
          )
        ],
      ),
      )
    );
  }
  Widget Button(String text,int color,VoidCallback call ){
    return(
        Container(
          height: 80,
          child: FlatButton(onPressed: (){call();},child: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 20,),)),
          width: double.infinity,
          decoration: ShapeDecoration(
              color: color==1?Color.fromRGBO(44, 219, 152, 1):color==2?Colors.redAccent:Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              )
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
          child:Text(name+"'s Report",textAlign: TextAlign.center,),
        )
      ],
    ));
  }
}
