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
        primarySwatch: Colors.blue,
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
      child: Card(
        child: ListTile(
          title: Text(_todos[index].title),
        ),
      ),
    );
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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TodoRoute(myTodo: todo)));
  }

  _navigateToEditTodo(Todo todo) {
    Navigator.of(context).push(MaterialPageRoute( builder: (context) => TodoEditRoute(myTodo: todo)));
  }
}

class Todo {
  Todo({@required this.title, this.description}) : assert(title != null);

  String title;
  String description;
}
