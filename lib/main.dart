import 'package:flutter/material.dart';
import 'todo_route.dart';

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

  Widget _buildTodo(BuildContext con, int index) {
    return InkWell(
      splashColor: Colors.green,
      onTap: () => _navigateToTodo(context, _todos[index]),
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
      itemBuilder: (BuildContext con, int index) => _buildTodo(con, index),
    );
  }

  void _add() {
    _todos.add(Todo(
        title: "Added new todo",
        description: "test3",
    ));
    setState(() {});
  }

  _navigateToTodo(BuildContext context, Todo todo) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1.0,
              title: Text('Todo'),
            ),
            body: TodoRoute(myTodo: todo),
          );
        }
    ));
  }
}

class Todo {
  const Todo({@required this.title, this.description}) : assert(title != null);

  final String title;
  final String description;
}