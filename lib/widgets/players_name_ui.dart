import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/players_data.dart';

class PlayersNameUI extends StatelessWidget {
  final String label;
  final int index;

  const PlayersNameUI(this.label, this.index);

  @override
  Widget build(BuildContext context) {

    final PlayersDataModel playersDataModel = Provider.of<PlayersDataModel>(context);
    
    return Container(
      height: 60.0,
      margin: new EdgeInsets.only(bottom: 10.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
            blurRadius: 5.0, 
            spreadRadius: 0.0,
            offset: Offset(
              2.0, // horizontal
              3.0, // vertical
            ),
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(left: 15),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                '$label',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
            RotationTransition(
              turns: AlwaysStoppedAnimation(45 / 360),
              child: IconButton(
                icon: Icon(Icons.add), 
                onPressed: () => playersDataModel.removePlayers(index),
              ),
            )
          ],
        ),
      ),
    );
  }
}
