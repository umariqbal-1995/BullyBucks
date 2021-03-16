import 'package:bully_bucks/Firebase.dart';
import 'package:bully_bucks/Widgets/historyWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_svg/platform_svg.dart';
import 'dart:math' as math;
import 'dart:ui';
class History extends StatefulWidget {
  final String email;

  const History({Key key, this.email}) : super(key: key);
  @override
  _HistoryState createState() => _HistoryState();
}
class _HistoryState extends State<History> {
  List list;
  @override
  void initState() {
    super.initState();
    Database db=new Database();
    db.getHistory(widget.email).then((value) {
      list=value;
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> listwidget=new List<Widget>();
    //listwidget.add(Text("No History to Show"));
    Widget w=Text("No History to Show");
    if(list!=null){
      int c=0;
      list.forEach((element) {
        Map<dynamic,dynamic> map=Map<dynamic,dynamic>.from(element);
        listwidget.add(Padding(child:GestureDetector(child: HistoryWidget(expaned: map["expand"],map: map,),onTap: (){
          list.forEach((element) {
            element["expand"]=false;
          });
          element["expand"]=true;
          setState(() {

          });
        },),
        padding: EdgeInsets.symmetric(vertical: 20)
        ),
        );
      });
      w = Column(children: listwidget,);
    }
    return Scaffold(
      body: SafeArea(child:Container(
        padding: EdgeInsets.fromLTRB(30,10,30,10),
        color: Color.fromRGBO(226, 226, 226, 0.45),
        child:  ListView(
          children: [
            makeAppbar(),
            w,
          ],
        ),
      )
      ),
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
          child:Text("History",textAlign: TextAlign.center,),
        )
      ],
    ));
  }
}
