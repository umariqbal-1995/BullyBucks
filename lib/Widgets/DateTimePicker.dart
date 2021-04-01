import 'package:flutter/cupertino.dart';

class DatePicker extends StatefulWidget {

  final VoidCallback onComplete;
  final Function onChange;

  DatePicker(this.onComplete, this.onChange, );

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          Container(
            height: 440,
            child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (val){
                  widget.onChange(val);
                }),
            margin: EdgeInsets.zero,
          ),
          CupertinoButton(
            child: Text('OK'),
            onPressed: widget.onComplete,
          )
        ],
      ),
    );
  }
}
