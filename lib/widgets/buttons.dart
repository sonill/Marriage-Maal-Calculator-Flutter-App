import 'package:flutter/material.dart';
import '../models/globals.dart' as globals;
// import '../widgets/alert_dialog.dart';

class MyButtons extends StatefulWidget {
  
  final String buttonLabel;
  final String color;
  final double margin;
  final String buttonType;
  final Function callback;

  MyButtons(this.buttonLabel, this.callback, this.buttonType, [this.color, this.margin]);

  @override
  _MyButtonsState createState() {

    return _MyButtonsState(
      this.buttonLabel, 
      this.callback, 
      this.buttonType,
      (this.color == null) ? 'blue' : this.color, 
      (this.margin == null) ? 8 : this.margin
    );

  } 

}

class _MyButtonsState extends State<MyButtons> {

  final String buttonLabel;
  final String color;
  final double margin;
  final String buttonType;
  final Function callback;

  _MyButtonsState(this.buttonLabel, this.callback,  this.buttonType, this.color, this.margin);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: margin),
      child: MaterialButton(
        elevation: 0,
        textColor: (buttonType == 'solid') 
          ? 
            Colors.white 
          : 
            Colors.black,
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5.0),
          side: BorderSide(
            color: (buttonType == 'solid') 
              ? 
                Colors.transparent
              : 
                Colors.black,
            width: 3,
            style: BorderStyle.solid
          ), 
        ),
        color: (buttonType == 'solid') 
          ? 
            Color(globals.getColor(color))
          : 
            Colors.white,
        // elevation: 5.0,
        child: Text(
          '$buttonLabel',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          callback(context);
        },
      ),
    );
  }
}
