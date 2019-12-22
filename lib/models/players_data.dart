import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool sharedPreferencesHasLoaded = false;
bool matchScoresInitiated = false;
bool settingsHasLoaded = false;

// ------------------------------------------------------------------------

class PlayersDataModel extends ChangeNotifier{
  List<String> _players = [];
  List<Map> _matchScores = [];
  List<Map> _settings = [{'seen' : 3, 'unseen' : 10, 'enable_dubli' : 1, 'dubli' : 5, 'murder' : 1}];

 // ------------------------------------------------------------------------

  get classLoaded{
    return true;
  }

  getMatchScores(){
    return _matchScores;
  }

  updateMatchScore(List<Map> data){
    _matchScores = data;
  }

  Future<bool> generateNewMatchScores() async {

    if( _matchScores.length  > 0 ) return false;
    
    return await getPlayersFromSharedPreferences().then((bool) async {
      // reset old scores
      _matchScores = [];

      for(int i = 0; i < _players.length; i++){
        _matchScores.add({'name' : _players[i], 'maal' : 0, 'seen' : false, 'dubli' : false, 'win' : false});
      }

      return await getSettingsFromSharedPreferences();

      // return true;

    });
    


  }

 // ------------------------------------------------------------------------

  // players name

  Future<bool> getPlayersFromSharedPreferences() async {

      // update players list

      if( _players.length > 0 ) return true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String playersData = prefs.getString("players");

      if( playersData == null) return true;

      var jsonData = jsonDecode(playersData);

      if( jsonData.length > 0 ){

        _players = [];

        for(var i=0; i < jsonData.length; i++){
          _players.add(jsonData[i]);
        }

      }
      
      sharedPreferencesHasLoaded = true;

      return true;

  }

  Future<bool> addPlayersToSharedPreferences(List data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString('players', jsonEncode(data) );
  }

  get playersName{
    return _players;
  }


  void addPlayers(String data){

    // stop duplicates

    if( !_players.contains(data)){
      _players.add(data);
      addPlayersToSharedPreferences(_players);
      notifyListeners();
    }

  }

  void removePlayers(index){
    _players.removeAt(index);

    addPlayersToSharedPreferences(_players);
    notifyListeners();
  }

  // ------------------------------------------------------------------------

  // global settings

  getSettings(){
    return _settings;
  }

  void updateSettings(String settingsKey, int data){
    _settings[0][settingsKey] = data;
    updateSettingsFromSharedPreferences(settingsKey, data).then( (bool){
      notifyListeners();
    });
  }

  
  Future<bool> getSettingsFromSharedPreferences() async {

    // update players list

    if( !settingsHasLoaded ){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var _settingsData;

      _settings.forEach( (_settingsKey){
        _settingsKey.forEach((key, value){
          _settingsData = prefs.getInt("sanil_mmc_" + key );
          if( _settingsData != null) {
            _settings[0][key] = _settingsData;
          }
        });
      });
      
      settingsHasLoaded = true;
      
    }

    return true;

  }

  Future<bool> updateSettingsFromSharedPreferences(String settingsKey, int data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt('sanil_mmc_' + settingsKey, data );
  }

}