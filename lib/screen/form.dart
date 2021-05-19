import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter_app/data/task.dart';

class MyFormPage extends StatefulWidget {
  MyFormPage({Key key}) : super(key: key);

  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  var _textController = TextEditingController(text: '');
  String _errorMessage = 'タスクが入力されていません';
  bool _isInput = false;
  Task _task;

  void setText(text) {
    if (text != '') {
      setState(() {
        _task = Task(text, false);
        _isInput = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("入力画面"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                maxLength: 20,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(
                    hintText: 'なんのタスク？',
                    labelText: 'タスクを入力して下さい'
                ),
                onChanged: (value) {
                  setText(value);
                },
                controller: _textController,
                autofocus: true,
              ),
            ),
            (_isInput != false)
                ? ElevatedButton(
                onPressed: () {
                  if (_isInput != false) {
                    Navigator.of(context).pop(_task);
                  }
                },
                child: Text(
                    'タスクを登録する'
                )
            )
                : Text(
              '',
            )
          ],
        ),
      ),
    );
  }
}