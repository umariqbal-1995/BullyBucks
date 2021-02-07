import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:bully_bucks/Widgets/Logo.dart';
import 'package:bully_bucks/Flow/Auth/Login/loginGender.dart';
import 'package:bully_bucks/Flow/Auth/Signup/registerPage.dart';
import 'package:platform_svg/platform_svg.dart';
import 'package:menu_button/menu_button.dart';
class StudentHome extends StatefulWidget {
  StudentHome({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _StudentHomeState createState() => _StudentHomeState();
}
class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 226, 226,1),
      body: SafeArea(
        child: Column(
          children: [
            makeAppbar(),
            Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 100, 35, 20),
                      child: makeUnderCard(),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black,
                      ),
                      child: Padding(padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Image.asset('assets/images/report.png',),
                            Text("Report",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12),)

                          ],
                        )
                      )

                    )
                  ],
                ),
                Padding(padding: EdgeInsets.fromLTRB(40, 40, 40, 20),
                  child: balanceCard(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget makeUnderCard(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white70,
      ),
      child: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 60),),
          Padding(padding: EdgeInsets.all(10), child:makeinCardItem("assets/images/history.svg", "History", "What so ever is history"),),
          Padding(padding: EdgeInsets.all(10), child:makeinCardItem("assets/images/history.svg", "History", "What so ever is history"),),
          Padding(padding: EdgeInsets.all(10), child:makeinCardItem("assets/images/history.svg", "History", "What so ever is history"),),
        ],
      ),
    );
  }
  Widget makeinCardItem(String imgPath,String title,String description){
    return (
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2),
              borderRadius: BorderRadius.circular(10.0),
            ),
          child: Row(
            children: [
                Flexible(
                  fit: FlexFit.tight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color.fromRGBO(44, 219, 152, 1),
                  ),
                  child: PlatformSvg.asset(imgPath,height: 30),
                ),
                  flex: 1,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(10, 0, 0,0),
                          child:Text(title,style: TextStyle(fontWeight: FontWeight.bold),) ,
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(10, 0, 0,0),
                          child:Text(description,style: TextStyle(fontSize: 11),) ,
                        ),
                      ],
                    ),
              flex: 6,
              ),
              Flexible(
                child:  PlatformSvg.asset("assets/images/forward.svg",height: 15,alignment: Alignment.centerRight),
                      flex: 1,
                fit: FlexFit.tight,
                    )
            ],
          ),
        )
    );
  }
  Widget balanceCard(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child:Container(
        margin: const EdgeInsets.only(bottom: 6.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topRight,
                colors: [Color.fromRGBO(44, 219, 152, 1),Color.fromRGBO(22, 88, 63, 1)]
            ),
        ),
        child:Padding(padding: EdgeInsets.fromLTRB(30, 15, 25, 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("b",style:TextStyle(color: Colors.white)),
                      Text("b",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                    ],
                  ),
                  Text("Balance",style:TextStyle(color: Colors.white)),
                  Text("50",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                  Text("Bully Bucks",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                ],
              ),
        )
      ),
    );
  }
  Widget makeAppbar() {
    return (Row(
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 4),),
        Image(image: AssetImage('assets/images/backBtn.png',), height: 35,),
        Expanded(child: Row(
          children: [
            Text("Bully", style: TextStyle(color: Colors.black),),
            Text("Bucks", style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        ),
        PlatformSvg.asset("assets/images/person.svg",height: 40),
        Padding(padding: EdgeInsets.symmetric(horizontal: 4.0))
      ],
    )
    );
  }
}