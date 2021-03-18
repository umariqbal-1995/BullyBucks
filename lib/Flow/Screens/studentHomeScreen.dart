import 'dart:developer';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bully_bucks/Firebase.dart';
import 'package:bully_bucks/Flow/Screens/Reports.dart';
import 'package:bully_bucks/Flow/Screens/emailPage.dart';
import 'package:bully_bucks/Flow/Screens/history.dart';
import 'package:bully_bucks/Flow/Screens/shop.dart';
import 'package:flutter/material.dart';
import 'package:bully_bucks/Widgets/Logo.dart';
import 'package:bully_bucks/Flow/Auth/Login/loginGender.dart';
import 'package:bully_bucks/Flow/Auth/Signup/registerPage.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:platform_svg/platform_svg.dart';
import 'package:menu_button/menu_button.dart';
class StudentHome extends StatefulWidget {

  StudentHome({Key key, this.title, this.email}) : super(key: key);
  final String email;
  final String title;
  @override
  _StudentHomeState createState() => _StudentHomeState();
}
class _StudentHomeState extends State<StudentHome> {
  Map<dynamic,dynamic> map;
  List<Widget> list=new List<Widget>();
  int bal=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Database db=new Database();
    db.getbullyBucks(widget.email).then((value) {
      bal=value;
      setState(() {

      });
    }).catchError((e){
      Fluttertoast.showToast(msg: "Something is Wrong with Database");
    });
    db.getUser(widget.email).then((value) {
      map=value;
      list.add(Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Text("Email",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Montserrat"),),
                  AutoSizeText(map["email"],style: TextStyle(fontFamily: "Montserrat")),
                  Text("First Name",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Montserrat"),),
                    Text(map["fname"],style: TextStyle(fontFamily: "Montserrat")),
                    Text("Last Name",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Montserrat"),),
                    Text(map["lname"],style: TextStyle(fontFamily: "Montserrat")),
                    Text("Bucks",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Montserrat"),),
                    Text( map["bucks"].toString(),style: TextStyle(fontFamily: "Montserrat")),
                    Text("Phone",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Montserrat"),),
                    Text(map["phone"],style: TextStyle(fontFamily: "Montserrat"),),
      ],
              )
          ),
      );
    setState(() {});
    }).catchError((e){
      Fluttertoast.showToast(msg: "Something is Wrong with Database");
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return (Scaffold(
      backgroundColor: Color.fromRGBO(226, 226, 226,1),
      body: SafeArea(

        child: ListView(
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
                        child: FlatButton(
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ReportPage(email: widget.email,)));
                            },
                            child: Padding(padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/report.png',),
                                    Text("Report",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12),),
                                  ],)
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
    ));
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
          Padding(padding: EdgeInsets.all(10), child:GestureDetector(child: makeinCardItem("assets/images/history.svg", "History", "Checking all your Reports"),onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => History(email: widget.email,)));
          },),),
          Padding(padding: EdgeInsets.all(10), child:GestureDetector(child: makeinCardItem("assets/images/cart.svg", "Shop", "Redeem You Bully bucks"),onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShopPage(email: widget.email,school: map["school"],)));
          },),),
          Padding(padding: EdgeInsets.all(10), child:GestureDetector(child: makeinCardItem("assets/images/message.svg", "Email", "Talk to your counsellor about any bullying related issues"),onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmailPage(email: widget.email,)));
          },),),
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
                  //fit: FlexFit.tight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color.fromRGBO(44, 219, 152, 1),
                  ),
                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 4),child: PlatformSvg.asset(imgPath,height: 30),)
                ),
                  flex: 1,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(10, 0, 0,0),
                          child:Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Montserrat"),) ,
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(10, 0, 0,0),
                          child:Text(description,style: TextStyle(fontSize: 11,fontFamily: "Montserrat"),) ,
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
                      Text("b",style:TextStyle(color: Colors.white,fontFamily: "Montserrat")),
                      Text("b",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontFamily: "Montserrat"),),
                    ],
                  ),
                  Text("Balance",style:TextStyle(color: Colors.white,fontFamily: "Montserrat")),
                  Text(bal.toString(),style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "Montserrat"),),
                  Text("Bully Bucks",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "Montserrat"))
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
        GestureDetector(child:Image(image: AssetImage('assets/images/backBtn.png',), height: 35,),onTap: (){
          Navigator.pop(context);
        },),
        Expanded(child: Row(
          children: [
            Text("Bully", style: TextStyle(color: Colors.black,fontFamily: "Montserrat"),),
            Text("Bucks", style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold,fontFamily: "Montserrat"),),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        ),
        GestureDetector(child: PlatformSvg.asset("assets/images/person.svg",height: 40),onTap: (){
          showDialog(context: context,
              child: new AlertDialog(
                  elevation: 10,
            title:  Text("Profile Detail",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Montserrat"),),
            content:       Container(
              width: double.infinity,
              height:240,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: list,
                ),
              )
            ),
          );
        },),
        Padding(padding: EdgeInsets.symmetric(horizontal: 4.0))
      ],
    )
    );
  }
}