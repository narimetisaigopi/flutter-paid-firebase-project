import 'package:my_first_app/api_repos/todo_list_api.dart';
import 'package:my_first_app/models/todo_model.dart';

class Repository {
  TodoAPi todoAPi = new TodoAPi();

  Future<List<ToDoModel>> getToDoList() => todoAPi.fetchToDoList();

  postToDoList() => todoAPi.postToList();
}
