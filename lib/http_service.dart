import 'dart:convert';

import 'package:flut_http/post_model.dart';
import 'package:flut_http/todo_model.dart';
import 'package:http/http.dart';

class HttpService {
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";
  final String todosURL = "https://jsonplaceholder.typicode.com/todos";

  Future<List<Post>> getPosts() async {
    Response res = await get(postsURL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      throw "Can't get posts.";
    }
  }

  Future<void> deletePost(int id) async {
    Response res = await delete("$postsURL/$id");

    if (res.statusCode == 200) {
      print("DELETED");
    } else {
      throw "Can't delete post.";
    }
  }

  Future<List<Todo>> getTodos(int id) async {
    Response res = await get("$todosURL?userId=$id");

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Todo> todos = body
          .map(
            (dynamic item) => Todo.fromJson(item),
          )
          .toList();

      return todos;
    } else {
      throw "Can't get posts.";
    }
  }
}
