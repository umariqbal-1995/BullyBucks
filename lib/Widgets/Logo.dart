import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return (
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("bully",style: TextStyle(color: Colors.white,fontFamily: "Montserrat"),),
        Text("Bucks",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "Montserrat"),),
      ],
    )
    );
  }

}