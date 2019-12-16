import 'package:flutter/material.dart';
import '../widgets/players.dart';
import '../models/players_data.dart';
import '../widgets/buttons.dart';
import '../widgets/alert_dialog.dart';
import '../models/globals.dart' as globals;

// void askPlayersNameDialog()  {
//   print('asdfasdf');
// }


class PlayersNameScreen extends StatefulWidget {
  @override
  _PlayersNameScreenState createState() => _PlayersNameScreenState();
}

PlayersData _playersObj = PlayersData();
List _players = _playersObj.getPlayers();

class _PlayersNameScreenState extends State<PlayersNameScreen> {

  void removePlayers(index){
    _playersObj.removePlayer(index);

    if(_players.length < 1 ){
      Navigator.pop(context);
    }
    else{
      setState((){});
    }

  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(globals.mainContainerPadding),
            child: Column(
              children: <Widget>[
                for(var i=0; i < _players.length; i++) PlayersName(_players[i]['name'], removePlayers, i ),
                SizedBox(
                  height: 5,
                ),
                MyButtons('Add More Players', askPlayersNameDialog, 'solid'),
                MyButtons('Start New Game', (){}, 'solid', 'green'),
              ],
            ),
            ),
        )
        ),
    );
  }
}