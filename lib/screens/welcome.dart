import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/buttons.dart';
import '../models/globals.dart' as globals;

final String assetName = 'assets/app_logo.svg';
final Widget svg = SvgPicture.asset(
  assetName,
  semanticsLabel: 'Marriage Maal Calculator'
);

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(globals.mainContainerPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            svg,
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 30),
              child: Text(
                'Marriage Maal Calculator',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            MyButtons('Add Players', (){
              Navigator.pushNamed(context, '/players');
            }, 'solid'),
          ],
        ),
      ),
    );
  }
}