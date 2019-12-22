import 'package:flutter/material.dart';
// import './screens/welcome.dart';
import './screens/players_name.dart';
import './screens/score_board_screen.dart';
import './screens/settings_screen.dart';
import './screens/result_screen.dart';

import 'package:provider/provider.dart';

import 'models/players_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlayersDataModel>.value(
      value: PlayersDataModel(),
      child: MaterialApp(
        title: 'Marriage Maal Calculator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff447EED),
        ),
        initialRoute: '/',
        routes: {
          // '/': (context) => WelcomeScreen(),
          '/players': (context) => PlayersNameScreen(),
          '/new_game': (context) => ScoreBoardScreen(),
          '/settings': (context) => SettingsScreen(),
          '/results': (context) => ResultScreen(),
        },
        home: ScoreBoardScreen(),
      ),
    );
  }
}
