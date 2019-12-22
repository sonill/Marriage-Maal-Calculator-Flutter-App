import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../models/players_data.dart';

TextEditingController _textFieldController = TextEditingController();

Future<void> settingsDialog(BuildContext context, Map args) async {

  String _title = args['title'];
  int _defaultValue = args['defaultValue'];
  Function _callback = args['callback'];

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('$_title'),
        content: TextField(
          autofocus: true,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          textCapitalization: TextCapitalization.words,
          controller: _textFieldController,
          decoration: InputDecoration(hintText: '$_defaultValue'),
          style: TextStyle(
            fontSize: 30
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('Submit'),
            elevation: 0,
            onPressed: () {
              String _textFieldValue = _textFieldController.text;

              if( _textFieldValue.length > 0 ){
                // _playersDataModel.updateSettings(_settingsKey, int.parse(_textFieldValue) );

                _callback( int.parse(_textFieldValue) );
                _textFieldController.clear();
                
              }

              Navigator.pop(context);
            }
          ),
        ],
      );
    },
  );

}