class PlayersData{
  List<Map> _players = [
    {'name' : 'Player 1', 'maal' : 0, 'seen' : 0, 'dubli' : 0, 'win' : 1 },
    {'name' : 'Player 2', 'maal' : 0, 'seen' : 0, 'dubli' : 0, 'win' : 0 },
    {'name' : 'Player 3', 'maal' : 0, 'seen' : 0, 'dubli' : 0, 'win' : 0 },
    {'name' : 'Player 4', 'maal' : 0, 'seen' : 0, 'dubli' : 0, 'win' : 0 },
    {'name' : 'Player 5', 'maal' : 0, 'seen' : 0, 'dubli' : 0, 'win' : 0 },
  ];

  List getPlayers(){
    return _players;
  }

  void addPlayers(Map data){
    _players.add(data);
  }

  void removePlayer(index){
    _players.removeAt(index);
  }

}