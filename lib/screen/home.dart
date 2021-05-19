import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:todo_flutter_app/data/task.dart';

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