import 'package:counter_app/components/session_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../counter.dart';
import '../session.dart';

List<Session> sessions = [
  Session('Session 1', [Counter('Player 1', 0), Counter('Player 2', 0)]),
  Session('Session 2', [Counter('Player 1', 0), Counter('Player 2', 0)]),
  Session('Session 3', [Counter('Player 1', 0), Counter('Player 2', 0)]),
  Session('Session 4', [Counter('Player 1', 0), Counter('Player 2', 0)])
];

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

// Creates a List of sessions which will be clickable and maluable
class HomeScreenState extends State<HomeScreen> {
  // List<Counter> counters = [Counter('Player 1', 0), Counter('Player 2', 0)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Counter App',
          textAlign: TextAlign.center,
        ),
      ),
      //SessionWidget(sessions[0])
      body: ListView.builder(
        itemCount: sessions.length,
        itemBuilder: (BuildContext context, int index) => Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: ListTile(
            title: Text(sessions[index].name),
            onLongPress: () {
              print('${sessions[index].name}');
            },
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SessionWidget(
                  sessions[index],
                ),
              ),
            ),
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Archive',
              color: Colors.green,
              icon: Icons.archive,
              onTap: () {
                print('Archived ${sessions[index].name}');
              },
            ),
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red[400],
              icon: Icons.delete,
              onTap: () {
                setState(() {
                  sessions.removeAt(index);
                });
                print('Deleted ${sessions[index].name}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
