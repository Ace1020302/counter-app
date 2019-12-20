import 'package:bordered_text/bordered_text.dart';
import 'package:counter_app/screens/session_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../counter.dart';
import '../session.dart';

List<Session> sessions = [];

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
          title: BorderedText(
            strokeColor: Colors.red,
            strokeWidth: 2,
            child: Text('Counter app',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: Colors.white)),
          ),
          bottom: TabBar(tabs: <Widget>[
            BorderedText(
                strokeColor: Colors.red,
                strokeWidth: 2,
                child: Text('Sessions',
                    style: TextStyle(fontSize: 19, color: Colors.white))),
            BorderedText(
                strokeColor: Colors.red,
                strokeWidth: 2,
                child: Text('Archived',
                    style: TextStyle(fontSize: 19, color: Colors.white)))
          ]),
        ),
        //SessionScreen(sessions[0])
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
                        title: Text(
                          sessions[index].name,
                          textAlign: TextAlign.center,
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SessionScreen(
                              sessions[index],
                            ),
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: 'Rename',
                          color: Colors.blue,
                          icon: Icons.mode_edit,
                          onTap: () {
                            customDialog(context, index, sessions[index].name);

                            print('Renamed ${archivedSessions[index]}');
                          },
                        ),
                      ],
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
                            builder: (context) => ArchivedSessionScreen(
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
                      actions: <Widget>[
                        IconSlideAction(
                          caption: 'Rename',
                          color: Colors.blue,
                          icon: Icons.mode_edit,
                          onTap: () {
                            customDialog(
                                context, index, archivedSessions[index].name,
                                archived: true);

                            print('Renamed ${archivedSessions[index]}');
                          },
                        ),
                      ],
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
          backgroundColor: Color(0xFFCDFFD5),
          child: Icon(Icons.add, color: Colors.red),
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
      sessions.add(Session('Session ${1}', [
        Counter('Player 1'),
        Counter('Player 2'),
        Counter('Player 3'),
        Counter('Player 4'),
        Counter('Player 5'),
        Counter('Player 6'),
        Counter('Player 7'),
        Counter('Player 8')
      ]));
    } else {
      sessions.add(Session('Session ${sessions.length + 1}', [
        Counter('Player 1'),
        Counter('Player 2'),
        Counter('Player 3'),
        Counter('Player 4'),
        Counter('Player 5'),
        Counter('Player 6'),
        Counter('Player 7'),
        Counter('Player 8')
      ]));
    }
  }

  void customDialog(BuildContext context, int index, String name,
      {bool archived = false}) {
    String newName;
    showDialog(
      child: Dialog(
        child: Container(
          height: 170,
          child: Form(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Name Session:',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    onChanged: (String input) => (newName = input),
                  ),
                ),
                RaisedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (archived == true) {
                      setState(() {
                        archivedSessions[index].name =
                            (newName != null || newName.trim() == '')
                                ? newName.trim()
                                : name;
                      });
                    } else {
                      setState(() {
                        sessions[index].name =
                            (newName != null || newName.trim() == '')
                                ? newName.trim()
                                : name;
                      });
                    }

                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        ),
      ),
      context: context,
    );
  }
}
