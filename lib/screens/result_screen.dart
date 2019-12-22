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

    final routesData =  ModalRoute.of(context).settings.arguments as Map<String,List>;

    // final PlayersDataModel playersDataModel = Provider.of<PlayersDataModel>(context);
    // final List _settings = playersDataModel.


    // print('routes');
    print(routesData['data']);

    return Scaffold(
      body: resultScreenBody(context, routesData['data']),
    );
  }


  // ---------------------------------------------------------------


  Widget resultScreenBody(context, List results ){

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(globals.mainContainerPadding),
          child: Column(
            children: <Widget>[
              for (var i = 0; i < results.length; i++)
                ResultsUI(results[i]),
                
              SizedBox( height: 5, ),

              MyButtons('Start New Game', () {
                Navigator.pushReplacementNamed(context, '/new_game');
              }, 'solid', 'green', 8),

              MyButtons('Manage Players', () {
                // Navigator.pushReplacementNamed(context, '/new_game');
              }, 'bordered', 'blue', 8)
              
            ],
          ),
        ),
      )
    );
  }
}
