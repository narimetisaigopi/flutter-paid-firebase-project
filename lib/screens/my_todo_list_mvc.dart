import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_first_app/controllers/my_todo_list_controller.dart';

class MyToListMVC extends StatefulWidget {
  @override
  _MyToListMVCState createState() => _MyToListMVCState();
}

class _MyToListMVCState extends StateMVC<MyToListMVC> {
  MyToDoListController _myToDoListController;

  _MyToListMVCState() : super(MyToDoListController()) {
    this._myToDoListController = controller;
  }

  @override
  void initState() {
    _myToDoListController.getData();
    super.initState();
  }

  bool portrait = true;

  // portrait ? 2 : 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MVC")),
      body: Row(
        children: [
          Text(MediaQuery.of(context).orientation.index ==
                  Orientation.portrait.index
              ? "portrait ${MediaQuery.of(context).orientation.index}"
              : "landscape ${MediaQuery.of(context).orientation.index}"),
          // MediaQuery.of(context).orientation.index == Orientation.portrait.index
          //     ? Expanded(child: myWidget())
          //     : myWidget(),
          Container(
            color: Colors.yellow,
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height,
            child: Text(
              "Width/height: ${MediaQuery.of(context).size.width} -- ${MediaQuery.of(context).size.height}",
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
      // body: _myToDoListController.list.length == 0
      //     ? Center(child: Text("No Data"))
      //     : ListView.builder(
      //         itemCount: _myToDoListController.list.length,
      //         itemBuilder: (context, index) {
      //           return Card(
      //             child: ListTile(
      //                 tileColor: _myToDoListController.list[index].completed
      //                     ? Colors.green
      //                     : Colors.red[100],
      //                 leading:
      //                     Text(_myToDoListController.list[index].id.toString()),
      //                 title: Text(_myToDoListController.list[index].title)),
      //           );
      //         }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _myToDoListController.getData();
          },
          child: Icon(Icons.download)),
    );
  }

  Widget myWidget() {
    return Container(
      color: Colors.green,
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height,
      child: Text(
        "Width/height: ${MediaQuery.of(context).size.width} -- ${MediaQuery.of(context).size.height}",
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
