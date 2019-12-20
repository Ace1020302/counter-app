import 'package:bordered_text/bordered_text.dart';
import 'package:counter_app/counter.dart';
import 'package:flutter/material.dart';

import '../session.dart';

class SessionScreen extends StatefulWidget {
  Session session;

  SessionScreen(this.session);

  @override
  State<StatefulWidget> createState() {
    return SessionScreenState(session);
  }
}

class SessionScreenState extends State<SessionScreen> {
  Session session;

  SessionScreenState(this.session);

  @override
  Widget build(BuildContext context) {
    List<Counter> counters = session.counters;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red),
        title: BorderedText(
            strokeColor: Colors.red,
            strokeWidth: 2,
            child: Text(session.name, style: TextStyle(color: Colors.white))),
      ),
      body: ListView.builder(
        itemCount: counters.length,
        itemBuilder: (BuildContext context, int index) {
          Counter counter = counters[index];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
                child: Card(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${counter.name} Money: ${counter.score}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                      builder: (BuildContext context) => StatefulBuilder(
                            builder: (BuildContext context,
                                StateSetter setModalState) {
                              return Column(
                                children: <Widget>[
                                  Text(
                                    '${counter.name} Money: ${counter.score}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  customModal(index, counter, setModalState),
                                ],
                              );
                            },
                          ),
                      context: context);
                }),
          );
        },
      ),
    );
  }

  Widget incrementsRow(
      int index, Counter counter, StateSetter setModalState, int value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            heroTag: '-$value index $index',
            mini: true,
            backgroundColor: Color(0xFFCDFFD5),
            child: Icon(Icons.remove, color: Colors.red),
            onPressed: () {
              counter.score -= value;
              setModalState(() {});
              setState(() {});
            },
          ),
          Container(
            width: 80,
            child: Center(
              child: Text(
                '\$$value',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          FloatingActionButton(
            heroTag: '$value index $index',
            backgroundColor: Color(0xFFCDFFD5),
            child: Icon(Icons.add, color: Colors.red),
            mini: true,
            onPressed: () {
              counter.score += value;
              setModalState(() {});
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget customModal(index, counter, setModalState) {
    return Column(children: <Widget>[
      incrementsRow(index, counter, setModalState, 500),
      incrementsRow(index, counter, setModalState, 100),
      incrementsRow(index, counter, setModalState, 50),
      incrementsRow(index, counter, setModalState, 20),
      incrementsRow(index, counter, setModalState, 10),
      incrementsRow(index, counter, setModalState, 5),
      incrementsRow(index, counter, setModalState, 1),
    ]);
  }
}

class ArchivedSessionScreen extends StatefulWidget {
  Session session;

  ArchivedSessionScreen(this.session);

  @override
  State<StatefulWidget> createState() {
    return ArchivedSessionScreenState(session);
  }
}

class ArchivedSessionScreenState extends State<ArchivedSessionScreen> {
  Session session;

  ArchivedSessionScreenState(this.session);

  @override
  Widget build(BuildContext context) {
    List<Counter> counters = session.counters;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red),
        title: BorderedText(
            strokeColor: Colors.red,
            strokeWidth: 2,
            child: Text(session.name, style: TextStyle(color: Colors.white))),
      ),
      body: ListView.builder(
        itemCount: counters.length,
        itemBuilder: (BuildContext context, int index) {
          Counter counter = counters[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Container(
                constraints: BoxConstraints(minHeight: 30),
                child: Text(
                  '${counter.name} Score: ${counter.score}',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
