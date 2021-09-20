import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scrum_poker/theme/theme.dart';
import 'package:scrum_poker/widgets/functional/navigation/navigation_router.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(ScrumPoker());
}

class ScrumPoker extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          accentColor: Colors.yellow[600], primaryColor: Colors.blue[800]),
      title: 'Scrum Poker',
      home: NavigationRouter(),
    );
  }
}
