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
                child: Column(
                  children: <Widget>[
                    Text(
                      '${counter.name} Score: ${counter.score}',
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FloatingActionButton(
                          heroTag: 'btn1 index ${index}',
                          mini: true,
                          onPressed: () => setState(() {
                            counter.score--;
                          }),
                          child: Icon(Icons.remove),
                        ),
                        FloatingActionButton(
                          heroTag: 'btn2 index ${index}',
                          mini: true,
                          onPressed: () {
                            setState(() {
                              counter.score++;
                            });
                          },
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
