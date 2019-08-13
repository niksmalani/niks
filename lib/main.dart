import 'dart:async';

import 'package:flutter/material.dart';

void main(List<String> args) {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Page());
  }
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  final StreamController<int> _streamController = StreamController<int>();
  int _counter = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hello'),
        backgroundColor: Colors.cyan,
      ),
      backgroundColor: Colors.cyanAccent,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "data",
            style: TextStyle(fontSize: 20),
          ),
          StreamBuilder<int>(
            stream: _streamController.stream,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot<int> asyncSnapshot) {
              return Text(
                '${asyncSnapshot.data}',
                style: TextStyle(fontSize: 20),
              );
            },
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _streamController.sink.add(_counter++);
        },
      ),
    );
  }
}
