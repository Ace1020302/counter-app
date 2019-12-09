import 'package:flutter/material.dart';

import '../session.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

// Creates a List of sessions which will be clickable and maluable
class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<Session> sessions = [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Counter App',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
