// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/players_data.dart';
import '../widgets/players_name_ui.dart';
import '../widgets/buttons.dart';
import '../widgets/alert_dialog_new_player.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../models/globals.dart' as globals;


class PlayersNameScreen extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Builder(
          builder: (context) => getBodyWithFutureBuilder(context),
        )
      );
    }

  Widget getBodyWithFutureBuilder(context){
    final PlayersDataModel playersDataModel = Provider.of<PlayersDataModel>(context);

    return FutureBuilder(
      future: playersDataModel.getPlayersFromSharedPreferences(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var _players = playersDataModel.playersName;
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(globals.mainContainerPadding),
                child: Column(
                  children: <Widget>[
                    for (var i = 0; i < _players.length; i++)
                      PlayersNameUI(_players[i], i),
                      
                    SizedBox( height: 5, ),
                    MyButtons('Add More Players', (){
                      askPlayersNameDialog(context, (){
                          // Navigator.pop(context,);
                          Navigator.of(context).pop();
                        });
                      } , 'solid', 'blue', 8
                    ),
                    Container(
                      child: ( _players.length > 1 ) 
                      ? 
                      MyButtons('Start New Game', () {
                        Navigator.of(context).pushReplacementNamed('/new_game', arguments: {'reset':true});
                        // Navigator.pushReplacementNamed(context, '/new_game');
                      }, 'solid', 'green', 8)
                      :
                      SizedBox(),
                    )
                  ],
                ),
              ),
            )
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );


    
  }

}
