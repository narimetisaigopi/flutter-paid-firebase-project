import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_first_app/api_repos/todo_list_api.dart';
import 'package:my_first_app/models/todo_model.dart';

class MyToDoListController extends ControllerMVC {
  List<ToDoModel> list = [];
  bool isLoadin = false;
  getData() async {
    list = await TodoAPi().fetchToDoList();
    print("getData is done");
    setState(() {});
  }
}
