import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_first_app/models/todo_model.dart';

class TodoAPi {
  Future<List<ToDoModel>> fetchToDoList() async {
    var data = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/todos/"));

    List<ToDoModel> list = (json.decode(data.body) as List)
        .map((e) => ToDoModel.fromMap(e))
        .toList();
    return list;
  }

  Future<List<ToDoModel>> postToList() async {
    var data = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/todos/"));

    List<ToDoModel> list = (json.decode(data.body) as List)
        .map((e) => ToDoModel.fromMap(e))
        .toList();
    return list;
  }
}
