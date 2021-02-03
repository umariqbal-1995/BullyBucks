import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonRound extends StatelessWidget{
  final String text;
  final VoidCallback onPress;

  const ButtonRound({Key key, this.text, this.onPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return (Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      child: FlatButton(onPressed: onPress,child: Text(text,style: TextStyle(color: Colors.white,fontFamily: "Montserrat"),),),
      //color: Colors.black,
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        )
      ),
    )
    );
  }

}