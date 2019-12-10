import 'package:counter_app/components/session_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../counter.dart';
import '../session.dart';

List<Session> sessions = [
  Session('Session 1', [Counter('Player 1'), Counter('Player 2')]),
  Session('Session 2', [Counter('Player 1'), Counter('Player 2')]),
  Session('Session 3', [Counter('Player 1'), Counter('Player 2')]),
  Session('Session 4', [Counter('Player 1'), Counter('Player 2')])
];

List<Session> archivedSessions = [];

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Counter App',
            textAlign: TextAlign.center,
          ),
          bottom: TabBar(tabs: <Widget>[Text('Sessions'), Text('Archieved')]),
        ),
        //SessionWidget(sessions[0])
        body: TabBarView(
          children: <Widget>[
            (sessions.length <= 0 || sessions == null)
                ? Center(
                    child: Text('Add a Session',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30)),
                  )
                : ListView.separated(
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
                            setState(() {
                              archivedSessions.add(sessions[index]);
                              sessions.removeAt(index);
                            });
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
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      color: Colors.grey[800],
                      thickness: 1,
                      height: 0,
                    ),
                  ),
            (archivedSessions.length <= 0 || archivedSessions == null)
                ? Center(
                    child: Text('No Archived Sessions',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30)),
                  )
                : ListView.separated(
                    itemCount: archivedSessions.length,
                    itemBuilder: (BuildContext context, int index) => Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: ListTile(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArchivedSessionWidget(
                              archivedSessions[index],
                            ),
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          archivedSessions[index].name,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red[400],
                          icon: Icons.delete,
                          onTap: () {
                            setState(() {
                              archivedSessions.removeAt(index);
                            });
                            print('Deleted ${archivedSessions[index]}');
                          },
                        ),
                      ],
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      color: Colors.grey[800],
                      thickness: 1,
                      height: 0,
                    ),
                  ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              addItem();
            });
          },
        ),
      ),
    );
  }

  void addItem() {
    if (sessions == null || sessions.isEmpty) {
      sessions.add(
          Session('Session ${1}', [Counter('Player 1'), Counter('Player 2')]));
    } else {
      sessions.add(Session('Session ${sessions.length + 1}',
          [Counter('Player 1'), Counter('Player 2')]));
    }
  }
}
