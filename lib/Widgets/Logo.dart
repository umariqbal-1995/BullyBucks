import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return (
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Bully",style: TextStyle(color: Colors.white),),
        Text("Bucks",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ],
    )
    );
  }

}