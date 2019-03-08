import 'package:flutter/material.dart';
import 'package:flutter_todo/main.dart';
import 'todo_edit_route.dart';

class TodoRoute extends StatefulWidget {
  final Todo myTodo;

  const TodoRoute({@required this.myTodo}) : assert(myTodo != null);

  @override
  _TodoRouteState createState() => _TodoRouteState();
}

class _TodoRouteState extends State<TodoRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text("Todo"),
      ),
      body: _bodyContainer(),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToEditRoute(widget.myTodo),
          child: Icon(Icons.edit),
        ),
    );
  }
  
  

  Widget _bodyContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text(widget.myTodo.title),
          Text(widget.myTodo.description),
         // FloatingActionButton(onPressed: _navigateToEditRoute(widget.myTodo))
        ],
      ),
    );
}

  _navigateToEditRoute(todo) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => TodoEditRoute(myTodo: todo)));
  }

}
