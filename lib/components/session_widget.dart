import 'package:counter_app/counter.dart';
import 'package:flutter/material.dart';

import '../session.dart';

class SessionWidget extends StatefulWidget {
  final Session session;

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
        title: Center(child: Text(session.name)),
      ),
      body: ListView.builder(
        itemCount: counters.length,
        itemBuilder: (BuildContext context, int index) {
          Counter counter = counters[index];
          return Card(
              child: Row(
            children: <Widget>[
              Text(counter.name),
              Text('Score ${counter.score}')
            ],
          ));
        },
      ),
    );
  }
}
