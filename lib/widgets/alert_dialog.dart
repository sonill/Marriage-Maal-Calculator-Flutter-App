import 'package:flutter/material.dart';

TextEditingController _playerNameController = TextEditingController();

Future<void> askPlayersNameDialog(context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add New Player'),
        content: TextField(
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          controller: _playerNameController,
          decoration: InputDecoration(hintText: 'Name'),
        ),
        actions: <Widget>[
          MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text('Cancel'),
            elevation: 0,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.red,
            textColor: Colors.white,
            child: Text('Submit'),
            elevation: 0,
            onPressed: () {
              // Navigator.of(context).pop();
              // _addPlayer(_playerNameController.text);
              // _playerNameController.clear();
            },
          ),
        ],
      );
    },
  );
}