import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../models/players_data.dart';
import '../models/globals.dart' as globals;

class ResultsUI extends StatelessWidget {
  final Map args;

  const ResultsUI(this.args);

  @override
  Widget build(BuildContext context) {

    final String name = args['name'];
    final int result = args['result'];

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
                "$name",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Text(
                '$result',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(globals.getColor('blue')),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
