import 'package:flutter/material.dart';

import 'package:todo_flutter_app/screen/home.dart';
import 'package:todo_flutter_app/screen/form.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todo アプリ',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Todo アプリ'),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => new MyHomePage(),
          '/form': (BuildContext context) => new MyFormPage()
        });
  }
}
