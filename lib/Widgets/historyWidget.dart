import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryWidget extends StatelessWidget {
  final bool expaned;
  final Map<dynamic,dynamic> map;
  const HistoryWidget({Key key, this.expaned, this.map}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(expaned==false){
      return  Container(
        padding: EdgeInsets.fromLTRB(20,10,20,10),
        width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color:Colors.white
          ),
          child: Text(map["currentDate"].toString(), style: TextStyle(fontSize: 25),),
      );
    }
    else{
      return  Container(
        padding: EdgeInsets.fromLTRB(0,10,0,0),
         width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white
          ),
          child: Column(
            children: [
              Text(map["currentDate"].toString(), style: TextStyle(fontSize: 25),),
              Container(
                padding: EdgeInsets.fromLTRB(10,50,10, 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromRGBO(117, 117, 117, 0.20)
                ),
                child: Column(
                  children: [
                    Text(map["id"].toString() +"  You reported "+map["bully"] + " for "+map["type"] + " bullying "+ map["victim"]+ " in the "+ map["location"]+ " at " + map["time"],style: TextStyle(fontSize: 15),),
                    Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color.fromRGBO(44, 219, 152, 1)

                    ),
                      child: Padding(child: Text(map["verify"]==0?"Pending Report":map["verfiy"]==1?"Report Verified":"Fake Report",style: TextStyle(color: Colors.white,fontSize: 30),),padding: EdgeInsets.fromLTRB(0,0,0,0),),
                    )
                  ],
                ),
              )
            ],
          ),
      );
    }
  }
}
