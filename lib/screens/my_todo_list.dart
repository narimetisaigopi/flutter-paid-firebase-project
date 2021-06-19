import 'package:flutter/material.dart';
import 'package:my_first_app/blocs/to_do_bloc.dart';
import 'package:my_first_app/models/todo_model.dart';

class MyToListScreen extends StatefulWidget {
  @override
  _MyToListScreenState createState() => _MyToListScreenState();
}

class _MyToListScreenState extends State<MyToListScreen> {
  @override
  void initState() {
    super.initState();
    todoBloc.fetchMyToDoList();
  }

  @override
  void dispose() {
    todoBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bloc ToDo List"),
      ),
      body: StreamBuilder<List<ToDoModel>>(
        stream: todoBloc.todoStream,
        builder: (context, AsyncSnapshot<List<ToDoModel>> snapshot) {
          if (snapshot.hasError) {
            return Text("something went wrong: " + snapshot.error.toString());
          }
          if (snapshot.hasData) {
            if (snapshot.data == null || snapshot.data.length == 0) {
              return Text("No todo list");
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        tileColor: snapshot.data[index].completed
                            ? Colors.green
                            : Colors.red[100],
                        leading: Text(snapshot.data[index].userId.toString()),
                        title: Text(snapshot.data[index].title)),
                  );
                });
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
