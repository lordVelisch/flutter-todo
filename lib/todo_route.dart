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
    return _bodyContainer();
  }

  Widget _bodyContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text(widget.myTodo.title),
          Text(widget.myTodo.description),
        ],
      ),
    );
}

}
