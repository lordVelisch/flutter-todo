import 'package:flutter/material.dart';
import 'main.dart';
import 'todo_route.dart';

class TodoEditRoute extends StatefulWidget {

  Todo myTodo;

  TodoEditRoute({@required this.myTodo}) : assert (myTodo != null);

  @override
  TodoEditRouteState createState() => TodoEditRouteState();
}

class TodoEditRouteState extends State<TodoEditRoute> {


  var titleController;
  var descriptionController;


  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    titleController = new TextEditingController(text: widget.myTodo.title);
    descriptionController = new TextEditingController(text: widget.myTodo.description);
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(widget.myTodo.title),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _saveTodo(widget.myTodo),
          child: Icon(Icons.save),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextFormField(
             // initialValue: widget.myTodo.title,
              decoration: InputDecoration(
                hintText: "Enter title",
              ),
              controller: titleController,
            ),
            TextFormField(
              //initialValue: widget.myTodo.description,
              decoration: InputDecoration(
                hintText: "Enter Description"
              ),
              controller: descriptionController,
            )
          ],
        ),
      ),
    );
  }

  _saveTodo(Todo todo) {
    todo.title = titleController.text;
    todo.description = descriptionController.text;
    Navigator.of(context).pop();
  }

}