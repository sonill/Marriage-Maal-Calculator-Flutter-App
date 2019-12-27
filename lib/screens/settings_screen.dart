import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/players_data.dart';
import '../widgets/alert_dialog_settings.dart';

class SettingsScreen extends StatelessWidget {

  const SettingsScreen();

  @override
  Widget build(BuildContext context) {
    
    // final _playersDataModel _playersDataModel = Provider.of<_playersDataModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: SettingsBody()
      ),
    
    );
  }

}

// --------------------------------------------------------------------

class SettingsBody extends StatelessWidget {
  const SettingsBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SingleRow(context, 'Seen Points', 'Points gained by winner through players who have seen the joker card.', false, 'seen' ),
        SingleRow(context, 'Unseen Points', 'Pointed gained by winner through players who have not seen the joker card.', false, 'unseen' ),
        SingleRow(context, 'Dubli', 'If ON, Dubli game points will be automatically calculated.', true, 'enable_dubli'),
        SingleRow(context, 'Dubli Points', 'Points gained by winner by playing Dubli.', false, 'dubli' ),
        // SingleRow(context, 'Murder', 'If ON, Points of unseen players will not be counted.', true, 'murder'),
        SizedBox(height: 40),
        Text('Designed & Developed by'),
        SizedBox(height: 5),
        Text('www.sanil.com.np', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
      ],
    );
  }

}


// --------------------------------------------------------------------


class SingleRow extends StatelessWidget {

  final String _title;
  final String _desc;
  final BuildContext context;
  final bool _showCheckBox;
  final String _settingsKey;

  const SingleRow(this.context, this._title, this._desc, this._showCheckBox, this._settingsKey);

  @override
  Widget build(BuildContext context) {
    PlayersDataModel _playersDataModel = Provider.of<PlayersDataModel>(context);
    var _settings = _playersDataModel.getSettings();

    return InkWell(
      onTap: (){
        // _callback();
        if( _showCheckBox ){
          _playersDataModel.updateSettings(_settingsKey, (_settings[0][_settingsKey] == 1) ? 0 : 1 );
          return true;
        }
        else{
          
          String _title;
          int _defaultValue = _settings[0][_settingsKey];

          if( _settingsKey == 'seen'){
            _title = 'Seen Points';
          }
          else if( _settingsKey == 'unseen'){
            _title = 'Un-Seen Points';
          }
          else if( _settingsKey == 'dubli'){
            _title = 'Dubli Points';
          }

          void callbackFunc(data){
            _playersDataModel.updateSettings(_settingsKey, data );
          }
          
          return settingsDialog( context, { 'title' : _title, 'defaultValue' : _defaultValue, 'callback' : callbackFunc  } );
        }
        
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '$_title',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          '$_desc',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  (_showCheckBox) ? CheckBoxWidget(_settingsKey) : SizedBox(height: 0),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              height: 1,
            )
          ],
        )
      ),
    );

  }
}

// --------------------------------------------------------------------


class CheckBoxWidget extends StatelessWidget {
  // final List _settings;
  final String _settingsKey;

  const CheckBoxWidget(this._settingsKey);

  @override
  Widget build(BuildContext context) {

    PlayersDataModel _playersDataModel = Provider.of<PlayersDataModel>(context);

    void updateSwitchState(_settingsKey, value){
      _playersDataModel.updateSettings(_settingsKey, (value) ? 1 : 0 );
    }

    return FutureBuilder(
      future: _playersDataModel.getSettingsFromSharedPreferences(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var _settings = _playersDataModel.getSettings();
          return Switch(
            value: (_settings[0][_settingsKey] == 1) ? true : false, 
            onChanged: (bool value) {
              updateSwitchState(_settingsKey, value);
            },
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