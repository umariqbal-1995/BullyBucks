import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class TextWidget extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final TextEditingController controller;
  final bool pass;
  final bool green;
  const TextWidget({Key key, this.text, this.onTap, this.controller,this.pass, this.green}) : super(key: key);
  @override
  _TextWidget createState() => _TextWidget();
}
class _TextWidget extends State<TextWidget>
{
  FocusNode myFocusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return (TextFormField(
      obscureText: widget.pass==null?false:widget.pass,
      onTap: widget.onTap,
      controller: widget.controller,
      focusNode: myFocusNode,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: widget.green==null?Colors.white:Colors.black)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: widget.green==null?Colors.black:Colors.green)),
          labelText: widget.text,
          labelStyle: TextStyle(
            color: myFocusNode.hasFocus? widget.green==null?Colors.black:Colors.green :widget.green==null? Colors.white:Colors.black,fontFamily: "Montserrat"
          )
      ),
    )
    );
  }
}