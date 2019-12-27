import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../models/players_data.dart';
import '../widgets/buttons.dart';
import '../widgets/alert_dialog_new_player.dart';
import '../models/globals.dart' as globals;

final String assetName = 'assets/app_logo.svg';
final Widget svg = SvgPicture.asset( assetName, semanticsLabel: 'Marriage Maal Calculator');

class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBodyWithFutureBuilder(context),
    );
  }

  Widget _showWelcomeScreen( context, playersData ){

    MyButtons _button;

    if ( playersData.length > 0 ){
      _button = MyButtons(
        'Continue',
        (){
          Navigator.pushReplacementNamed(context, '/players');
        } ,  'solid', 'blue', 8
      );
    }
    else{
      _button = MyButtons(
        'Add Players',
        (){
          askPlayersNameDialog(context, (){
            Navigator.pushReplacementNamed(context, '/players');
          });
        }, 'solid', 'blue', 8
      );
    }

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(globals.mainContainerPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          svg,
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              'Marriage Maal Calculator',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          _button,
          SizedBox(height: 40),
          Text('www.sanil.com.np'),
        ],
      ),
    );

  }


  Widget getBodyWithFutureBuilder(context){
    final PlayersDataModel playersDataModel = Provider.of<PlayersDataModel>(context);
    return FutureBuilder(
      future: playersDataModel.getPlayersFromSharedPreferences(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _showWelcomeScreen(context, playersDataModel.playersName);
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