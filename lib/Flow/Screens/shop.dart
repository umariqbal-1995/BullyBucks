import 'package:bully_bucks/Flow/Screens/productPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:platform_svg/platform_svg.dart';
import 'dart:math' as math;
import 'package:bully_bucks/Firebase.dart';
import 'dart:developer';
class ShopPage extends StatefulWidget {
  final String email;
  final String school;
  ShopPage({Key key, this.email, this.school}) : super(key: key);
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

  List<Widget> wlist =new List<Widget>();
  @override
  void initState() {
    Database db=new Database();
    db.getProductsOfSchool(widget.school).then((value){
      if(value!=null) {
        value.forEach((element) {
          wlist.add(GestureDetector(child: productWidget(
              element["merchantEmail"], element["image"], element["caption"],
              element["price"].toString(), element["size"], element),));
        });
        setState(() {});
      }
    }).catchError((e){
      log(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(44, 219, 152, 1)
    ));
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(10,05,10,0),
          color: Color.fromRGBO(226, 226, 226,1),
          child: ListView(
            children: [
              makeAppbar(),
              Container(
                padding:EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 40,
                  runSpacing: 40,
                  children: wlist
                ),
              )
            ],
          )
        ),
      ),
    );
  }
  Widget productWidget(String merchantEMail,String path,String cap,String price,int w,Map<dynamic,dynamic> product) {
    log("url "+path);
    List<Widget> wl=new List<Widget>();
    if(w==1){
      wl.add(Text(cap));
      wl.add(Text(price+" Bully Bucks"));
    }
    else
      {
        wl.add(Text(cap.toString()+"     "+price.toString()+"   Bully Bucks"));
      }
      return  GestureDetector(
        child:  Container(
          child:Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.8),spreadRadius: 5,
                      blurRadius: 5,)]
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Image.network(path,width: w==1?120:300,),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            ]+wl,
          ),
        ),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductPage(mEmail: merchantEMail ,path:path,price: price,captionn: cap,email:widget.email,options1: product["options1"],options2: product["options2"],options3: product["options3"],)),
          );
        },
      );
  }
  Widget makeAppbar(){
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: GestureDetector(child: PlatformSvg.asset("assets/images/forward.svg",height: 20,),onTap: (){
                  Navigator.pop(context);
                },)
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*Expanded(
            child:
            )*/
            Text("Shop",textAlign: TextAlign.center,style:TextStyle(
              fontWeight: FontWeight.bold, fontFamily: "Montserrat",fontSize: 18,)
            )

          ],
        )
      ],
    );
  }
}
