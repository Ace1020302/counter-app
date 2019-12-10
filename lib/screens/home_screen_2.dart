import 'package:counter_app/components/session_widget.dart';
import 'package:flutter/material.dart';

import '../counter.dart';
import '../session.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

// Creates a List of sessions which will be clickable and maluable
class HomeScreenState extends State<HomeScreen> {
  List<Counter> counters = [Counter('Player 1', 0), Counter('Player 2', 0)];
  @override
  Widget build(BuildContext context) {
    List<Session> sessions = [Session('Session 1', counters)];

    return Scaffold(
      appBar: null,
      // appBar: AppBar(
      //   title: Text(
      //     'Counter App',
      //     textAlign: TextAlign.center,
      //   ),
      // ),
      body: SessionWidget(sessions[0]),
    );
  }
}
