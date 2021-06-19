import 'package:my_first_app/models/todo_model.dart';
import 'package:my_first_app/repo/repository.dart';
import 'package:rxdart/subjects.dart';

class ToDoBloc {
  final repo = Repository();

  final _toDoFecther = PublishSubject<List<ToDoModel>>();

  Stream<List<ToDoModel>> get todoStream => _toDoFecther.stream;

  // Stream<List<ToDoModel>>  todoStream(){
  //  return _toDoFecther.stream;

  // }

  fetchMyToDoList() async {
    List<ToDoModel> list = await repo.getToDoList();
    _toDoFecther.sink.add(list);
  }

  close() {
    _toDoFecther.close();
  }
}

final todoBloc = ToDoBloc();
