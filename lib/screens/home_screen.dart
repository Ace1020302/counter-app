import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  @override
  createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<String> items = <String>[];
  List<String> archivedItems = <String>[];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Counter Sessions'),
          bottom: TabBar(
            tabs: <Widget>[Text('Sessions'), Text('Archieved')],
          ),
        ),
        backgroundColor: Colors.grey[100],
        body: TabBarView(
          children: <Widget>[
            (items.length <= 0 || items == null)
                ? Center(
                    child: Text('Add a Session',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30)),
                  )
                : ListView.separated(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) => Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          items[index],
                          textAlign: TextAlign.center,
                        ),
                      ),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Archive',
                          color: Colors.green,
                          icon: Icons.archive,
                          onTap: () {
                            print('Archived ${items[index]}');
                            setState(() {
                              archivedItems.add(items[index]);
                            });
                          },
                        ),
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red[400],
                          icon: Icons.delete,
                          onTap: () {
                            setState(() {
                              items.removeAt(index);
                            });
                            print('Deleted ${items[index]}');
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
            (archivedItems.length <= 0 || archivedItems == null)
                ? Center(
                    child: Text('No Archived Sessions',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30)),
                  )
                : ListView.separated(
                    itemCount: archivedItems.length,
                    itemBuilder: (BuildContext context, int index) => Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          archivedItems[index],
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
                              archivedItems.removeAt(index);

                              // Catchs error if items list has no more elements
                              if (!(items.length <= 0 || items == null)) {
                                var itemEquivlentIndex =
                                    items.indexOf(archivedItems[index]);
                                items.removeAt(itemEquivlentIndex);
                              }
                            });
                            print('Deleted ${archivedItems[index]}');
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
    if (items == null || items.isEmpty) {
      items.add('Session ${1}');
    } else {
      items.add('Session ${items.length + 1}');
    }
  }
}

class CloseAlertButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.grey,
      textColor: Colors.white,
      child: Text('Ok'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
