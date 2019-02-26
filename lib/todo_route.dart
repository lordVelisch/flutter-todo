import 'package:flutter/material.dart';
import 'package:flutter_todo/main.dart';

class TodoRoute extends StatefulWidget {
  final Todo myTodo;

  const TodoRoute({@required this.myTodo}) : assert(myTodo != null);

  @override
  _TodoRouteState createState() => _TodoRouteState();
}

class _TodoRouteState extends State<TodoRoute> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
