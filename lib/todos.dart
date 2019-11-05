import 'package:flut_http/http_service.dart';
import 'package:flut_http/todo_model.dart';
import 'package:flutter/material.dart';

class TodosPage extends StatelessWidget {
  final int userId;
  final HttpService httpService = HttpService();

  TodosPage({@required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Todos for user: $userId"),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: httpService.getTodos(userId),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
                if (snapshot.hasData) {
                  List<Todo> todos = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      child: Column(
                          children: todos
                              .map((Todo todo) => CheckboxListTile(
                                    title: Text(todo.title),
                                    onChanged: (bool value) {},
                                    value: todo.completed,
                                  ))
                              .toList()),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }
}
