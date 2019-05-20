import 'dart:io';

import 'package:flutter/material.dart';
import 'todo_route.dart';
import 'todo_edit_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MainRoute(),
    );
  }
}

class MainRoute extends StatefulWidget {
  _MainRouteState createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  var _todos = <Todo>[
    Todo(title: 'Work on the todo app', description: 'test'),
    Todo(title: 'Show the difference', description: 'test2')
  ];

  var _checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: Icon(Icons.add),
      ),
      body: Container(padding: EdgeInsets.all(10), child: _buildTodoWidgets()),
    );
  }

  Widget _buildTodo(int index) {
    return InkWell(
      splashColor: Colors.green,
      onTap: () => _navigateToTodo(_todos[index]),
      borderRadius: BorderRadius.circular(20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(_todos[index].title),
          trailing: Checkbox(
              value: _todos[index].done,
              onChanged: (value) {
                setState(() {
                  _todos[index].done = value;
                  _onChecked(index);
                });//_onChecked(index);
                //_onChecked(index);
              },
            )
        ),
      ),
    );
  }

  void _onChecked(index) async {
    sleep(const Duration(seconds: 2));
   // setState(() {
      _todos.removeAt(index);
    //});
    //Todo toast
  }

  Widget _buildTodoWidgets() {
    return ListView.builder(
      itemCount: _todos.length,
      itemBuilder: (BuildContext con, int index) => _buildTodo(index),
    );
  }

  void _add() {
    _todos.add(Todo(
      title: "",
      description: "",
    ));
    _navigateToEditTodo(this._todos[_todos.length - 1]);
  }

  _navigateToTodo(Todo todo) {
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Todo"),
          elevation: 1.0,
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () => _onFinished(todo),
                child: Icon(Icons.check),
              ),
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () => _navigateToEditRoute(todo),
              child: Icon(Icons.edit),
            ),
          ],
        ),
        body: TodoRoute(
          myTodo: todo,
        ),
      );
    })); //  TodoRoute(myTodo: todo)));
  }

  _navigateToEditTodo(Todo todo) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => TodoEditRoute(myTodo: todo)));
  }

  _navigateToEditRoute(todo) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => TodoEditRoute(myTodo: todo)));
  }

  _onFinished(Todo todo) {
    _todos.remove(todo);
    Navigator.pop(context);

    //Todo Toast
  }
}

class Todo {
  Todo({@required this.title, this.description}) : assert(title != null);

  String title;
  String description;
  bool done = false;
}
