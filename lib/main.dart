import 'package:flutter/material.dart';
// import './screens/welcome.dart';
import './screens/players_name.dart';
// import './screens/new_score_board.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marriage Maal Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        // '/': (context) => WelcomeScreen(),
        '/players': (context) => PlayersNameScreen(),
      },
      home: PlayersNameScreen(),
    );
  }
}
