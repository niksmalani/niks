import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //StreamController<String> colorcontroller = StreamController<String>();
  final ChangeNameBloc changeNameBloc = ChangeNameBloc();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<String>(
            initialData: 'nikunj',
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return Container(
                width: 100,
                height: 100,
                child: Center(child: Text('${snapshot.data}')),
              );
            },
            stream: changeNameBloc._output,
          ),
          FlatButton(
            child: Text('Next'),
            onPressed: () {
              setState(() {
                if (changeNameBloc.i == (changeNameBloc.a).length - 1) {
                  changeNameBloc.i = 0;
                }
                changeNameBloc.chnageName.add(null);
              });
            },
          )
        ],
      ),
    );
  }
}

//chnage name bloc

class ChangeNameBloc implements BlocBase {
  var name;
  var i = 0;
  var a = ['nikunj', 'keval', 'chirag', 'bhavesh', 'nevil', 'savan'];
  StreamController<String> _nameController = StreamController<String>();

  StreamSink<String> get _add => _nameController.sink;
  Stream<String> get _output => _nameController.stream;

  StreamController _buttonController = StreamController();
  StreamSink get chnageName => _buttonController.sink;

  ChangeNameBloc() {
    name = a[0];
    _buttonController.stream.listen(onData);
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.close();
    _buttonController.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }

  void onData(event) {
    name = a[++i];
    _add.add(name);
  }
}
