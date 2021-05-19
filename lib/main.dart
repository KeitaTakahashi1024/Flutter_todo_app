import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() {
  runApp(MyApp());
}

class Task {
  String name;
  bool isFinish;

  Task(String name, bool isFinish) {
    this.name = name;
    this.isFinish = isFinish;
  }
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> _task = [];
  var iconColor = Colors.grey;

  void changeState(task) {
    int taskIndex = _task.indexOf(task);
    bool isFinish = _task[taskIndex].isFinish;
    if (isFinish == false) {
      setState(() {
        _task[taskIndex].isFinish = true;
      });
    } else {
      setState(() {
        _task[taskIndex].isFinish = false;
      });
    }
  }

  void deleteTask(task) {
    int taskIndex = _task.indexOf(task);
    setState(() {
      _task.removeAt(taskIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        itemCount: _task.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < _task.length) {
            return _taskItem(_task[index]);
          } else {
            return Container(
              height: 0.1,
              color: Colors.blue,
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            height: 1.0,
            color: Colors.blue,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/form").then((result) {
            setState(() {
              _task.add(result);
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _taskItem(Task task) {
    int taskIndex = _task.indexOf(task);
    return Slidable(
      child: ListTile(
        title: Text(
          task.name,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.check_box_outlined,
          ),
          onPressed: () {
            changeState(task);
          },
          color: (_task[taskIndex].isFinish == false)
              ? Colors.grey
              : Colors.orange,
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          icon: Icons.delete,
          color: Colors.red,
          caption: '削除',
          onTap: () => deleteTask(task),
        ),
      ],
      actionPane: SlidableDrawerActionPane(),
    );
  }
}

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
                    hintText: 'なんのタスク？', labelText: 'タスクを入力して下さい'),
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
