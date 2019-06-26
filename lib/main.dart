import 'dart:async';

import 'package:flutter/material.dart';
import 'todo_route.dart';
import 'todo_edit_route.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

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

  var _done = <Todo>[];

  final channel = IOWebSocketChannel.connect('ws://10.0.2.2:3000');
  
  @override
  void initState() {
    channel.stream.listen((message) {
      channel.sink.add("received");
      channel.sink.close(status.goingAway);
      if (message != null) {
        print(message);
      }
    });
    super.initState();
  }

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
      body: Stack(children: <Widget>[
        Container(padding: EdgeInsets.all(10), child: _buildTodoWidgets()),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 100),
          child: Align(
            child: _buildDoneWidgets(),
            alignment: FractionalOffset.bottomCenter,
          ),
        )
      ]),
    );
  }

  Widget _buildTodo(int index, List<Todo> list) {
    return InkWell(
      splashColor: Colors.green,
      onTap: () => _navigateToTodo(list[index]),
      borderRadius: BorderRadius.circular(20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
            title: list[index].done == true
                ? Text(
                    list[index].title,
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  )
                : Text(list[index].title),
            trailing: Checkbox(
              value: list[index].done,
              onChanged: (value) {
                setState(() {
                  list[index].done = value;
                  _onChecked(index, value);
                }); //_onChecked(index);
                //_onChecked(index);
              },
            )),
      ),
    );
  }

  void _onChecked(index, value) async {
    if (value == true) {
      _done.add(_todos[index]);
      _todos.removeAt(index);
    } else {
      _todos.add(_done[index]);
      _done.removeAt(index);
    }
    //Todo: toast
  }

  Widget _buildTodoWidgets() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: _todos.length,
      itemBuilder: (BuildContext con, int index) => _buildTodo(index, _todos),
    );
  }

  Widget _buildDoneWidgets() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: _done.length,
      itemBuilder: (BuildContext build, int index) => _buildTodo(index, _done),
      reverse: true,
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
              child: todo.done == false
                  ? FloatingActionButton(
                      heroTag: null,
                      onPressed: () => _onFinished(todo),
                      child: Icon(Icons.check),
                    )
                  : SizedBox.shrink(),
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
    _done.add(todo);
    _todos.remove(todo);
    Navigator.pop(context);

    //Todo Toast
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}

class Todo {
  Todo({@required this.title, this.description}) : assert(title != null);

  String title;
  String description;
  bool done = false;
}
