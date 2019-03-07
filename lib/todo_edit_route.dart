import 'package:flutter/material.dart';
import 'main.dart';

class TodoEditRoute extends StatefulWidget {

  final Todo myTodo;

  const TodoEditRoute({@required this.myTodo}) : assert (myTodo != null);

  @override
  TodoEditRouteState createState() => TodoEditRouteState();
}

class TodoEditRouteState extends State<TodoEditRoute> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: widget.myTodo.title,
            decoration: InputDecoration(
              hintText: "Enter title",
            ),
          ),
          TextFormField(
            initialValue: widget.myTodo.description,
            decoration: InputDecoration(
              hintText: "Enter Description"
            ),
          )
        ],
      ),
    );
  }

}