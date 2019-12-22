import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/players_data.dart';

TextEditingController _playerNameController = TextEditingController();

Future<void> askPlayersNameDialog(context, Function callback) async {

  final PlayersDataModel playersDataModel = Provider.of<PlayersDataModel>(context);

  return showDialog(
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
              _playerNameController.clear();
            },
          ),
          MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('Submit'),
            elevation: 0,
            onPressed: () {
              String _name = _playerNameController.text.toString().trim();
              if( _name.length > 1 ){
                String _newPlayer = _name;
                // Map _playersData = {'name' : _name, 'maal' : false, 'seen' : false, 'dubli' : false, 'win' : false };
                playersDataModel.addPlayers(_newPlayer);
                _playerNameController.clear();
              }

              callback();
            }
          ),
        ],
      );
    },
  );
}