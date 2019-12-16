import 'package:flutter/material.dart';
import '../widgets/buttons.dart';
import '../models/globals.dart' as globals;

class ScoreBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(globals.mainContainerPadding),
          child: Column(
            children: <Widget>[
              scoreBoard(),
              MyButtons('View Results', () {}, 'solid'),
              MyButtons('Manage Players', () {}, 'bordered'),
            ],
          ),
        ),
      )),
    );
  }

  Widget scoreBoard() {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          defaultColumnWidth: FixedColumnWidth(150.0),
          border: TableBorder(
            horizontalInside: BorderSide(
              color: Colors.black,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            verticalInside: BorderSide(
              color: Colors.black,
              style: BorderStyle.solid,
              width: 1.0,
            ),
          ),
          children: [
            _buildTableRow("Inducesmile.com, Google.com, Flutter.dev"),
            _buildTableRow("Inducesmile.com, Google.com, Flutter.dev"),
            _buildTableRow("Inducesmile.com, Google.com, Flutter.dev"),
            _buildTableRow("Inducesmile.com, Google.com, Flutter.dev"),
          ],
        ),
      ),
    );
  }

  _buildTableRow(String listOfNames) {
    return TableRow(
      children: listOfNames.split(',').map((name) {
        return Container(
          // alignment: Alignment.center,
          child: Text(name,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              )),
          // padding: EdgeInsets.all(8.0),
        );
      }).toList(),
    );
  }
}
