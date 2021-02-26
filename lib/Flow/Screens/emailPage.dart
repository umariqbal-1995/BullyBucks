import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:platform_svg/platform_svg.dart';
import 'dart:math' as math;
class EmailPage extends StatefulWidget {
  final String email;

  const EmailPage({Key key, this.email}) : super(key: key);
  @override
  _EmailPageState createState() => _EmailPageState();
}
class _EmailPageState extends State<EmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            color: Color.fromRGBO(226, 226, 226, 0.45),
            child: ListView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Stack(
                  children: [
                    makeUnderContainer(),
                    Padding(padding: EdgeInsets.fromLTRB(40,50,40,0),
                    child: makeUppercard(),)
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
  Widget makeUppercard(){
      return(Container(
        padding:EdgeInsets.fromLTRB(10,20,10,25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Color.fromRGBO(44, 219, 152, 1),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(10,0,0,0),
          child: Row(
            children: [
              Flexible(flex: 2,child: PlatformSvg.asset("assets/images/email.svg",height: 30),),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),),
              Flexible(flex: 5,child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Who to send the email",
                  hintStyle: TextStyle(color:Colors.white,fontSize: 13)
              ),
            ),)
            ],
          ),
        ),
      )
      );
  }
  Widget makeUnderContainer(){
    return(Container(
      child: Column(
        children: [
          makeAppbar("Email"),
          Container(
            padding: EdgeInsets.fromLTRB(20, 70, 20, 0),
            child:   Container(
              padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.white
              ),
              child: multilineField("Type you email here")
            ),
          )
        ],
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
          child:Text(name,textAlign: TextAlign.center,),
        )
      ],
    ));
  }

  Widget multilineField(String hint){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: TextField(
         // controller: tcn5,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          minLines: 20,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color:Colors.grey,width: 0.3),
              ),
              hintText: hint,
            hintStyle: TextStyle(color: Colors.grey)
          ),
        ),
      ),
    );
  }

}
