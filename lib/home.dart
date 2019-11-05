import 'package:flut_http/http_service.dart';
import 'package:flut_http/posts.dart';
import 'package:flut_http/todos.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HttpService httpService = HttpService();
  int userId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("HTTP"),
        ),
        body: Column(
          children: <Widget>[
            ListTile(
              title: Text("Posts"),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => PostsPage())),
            ),
            ListTile(
              title: Text("Todos"),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (BuildContext context, setState) {
                          return AlertDialog(
                            title: Text("User ID"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                DropdownButtonFormField(
                                    value: userId,
                                    onChanged: (int selected) =>
                                        setState(() => userId = selected),
                                    items: [1, 2, 3, 4, 5, 6]
                                        .map((int i) => DropdownMenuItem(
                                              child: Text("$i"),
                                              value: i,
                                            ))
                                        .toList())
                              ],
                            ),
                            actions: <Widget>[
                              FlatButton(
                                  child: Text("GO"),
                                  onPressed: () {
                                    Navigator.of(context).pop();

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => TodosPage(
                                          userId: userId,
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          );
                        },
                      );
                    });
              },
            ),
          ],
        ));
  }
}
