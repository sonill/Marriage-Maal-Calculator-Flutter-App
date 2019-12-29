import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/players_data.dart';

import '../widgets/buttons.dart';
import '../widgets/results_ui.dart';
import '../models/globals.dart' as globals;


class ResultScreen extends StatelessWidget {

  const ResultScreen();

  @override
  Widget build(BuildContext context) {

    final routesData =  ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
      body: resultScreenBody(context, routesData),
    );
  }


  // ---------------------------------------------------------------


  Widget resultScreenBody(context, Map args ){

    List _results = args['data'];
    var _winnerData = args['winner'];

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(globals.mainContainerPadding),
          child: Column(
            children: <Widget>[
              ResultsUI( {'name' : 'Total Maal', 'results' : args['totalMaal'], 'dubli' : args['dubliWin'], 'titleRow' : true, 'settings' : args['settings'] }),
              ResultsUI( _winnerData),

              Column(
                children: <Widget>[
                  for (var i = 0; i < _results.length; i++)
                  ( _winnerData['name'] != _results[i]['name']) ? ResultsUI( _results[i]) : SizedBox(),
                ],
              ),

              SizedBox( height: 5, ),

              MyButtons('Start New Game', () {
                // Navigator.pushReplacementNamed(context, '/new_game');
                Navigator.of(context).pushReplacementNamed('/new_game', arguments: {'reset':true});
              }, 'solid', 'green', 8),

              MyButtons('Manage Players', () {
                Navigator.pushReplacementNamed(context, '/players');
              }, 'bordered', 'blue', 8)
              
            ],
          ),
        ),
      )
    );
  }


}
