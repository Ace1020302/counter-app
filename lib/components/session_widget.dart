import 'package:counter_app/counter.dart';
import 'package:flutter/material.dart';

import '../session.dart';

class SessionWidget extends StatefulWidget {
  Session session;

  SessionWidget(this.session);

  @override
  State<StatefulWidget> createState() {
    return SessionWidgetState(session);
  }
}

class SessionWidgetState extends State<SessionWidget> {
  Session session;

  SessionWidgetState(this.session);

  @override
  Widget build(BuildContext context) {
    List<Counter> counters = session.counters;
    return Scaffold(
      appBar: AppBar(
        title: Text(session.name),
      ),
      body: ListView.builder(
        itemCount: counters.length,
        itemBuilder: (BuildContext context, int index) {
          Counter counter = counters[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${counter.name} Money: ${counter.score}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    //Bottom sheet, Modal Widget for changing.
                    incrementsRow(index, counter, 1),
                    incrementsRow(index, counter, 5),
                    incrementsRow(index, counter, 10),
                    incrementsRow(index, counter, 20),
                    incrementsRow(index, counter, 50),
                    incrementsRow(index, counter, 100),
                    incrementsRow(index, counter, 500),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  incrementsRow(int index, Counter counter, int value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            heroTag: '-$value index $index',
            mini: true,
            onPressed: () => setState(() {
              counter.score -= value;
            }),
            child: Icon(Icons.remove),
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
            mini: true,
            onPressed: () {
              setState(() {
                counter.score += value;
              });
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class ArchivedSessionWidget extends StatefulWidget {
  Session session;

  ArchivedSessionWidget(this.session);

  @override
  State<StatefulWidget> createState() {
    return ArchivedSessionWidgetState(session);
  }
}

class ArchivedSessionWidgetState extends State<ArchivedSessionWidget> {
  Session session;

  ArchivedSessionWidgetState(this.session);

  @override
  Widget build(BuildContext context) {
    List<Counter> counters = session.counters;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(session.name)),
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
