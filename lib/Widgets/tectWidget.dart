import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class TextWidget extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final TextEditingController controller;
  final bool pass;
  const TextWidget({Key key, this.text, this.onTap, this.controller,this.pass}) : super(key: key);
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
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          labelText: widget.text,
          labelStyle: TextStyle(
            color: myFocusNode.hasFocus ? Colors.black : Colors.white,
          )
      ),
    )
    );
  }
}