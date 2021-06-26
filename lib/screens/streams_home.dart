import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/news_model.dart';

import 'curd_firestore.dart';
import 'home_screen.dart';
import 'news_screen.dart';

class StreamHomes extends StatefulWidget {
  @override
  _StreamHomesState createState() => _StreamHomesState();
}

class _StreamHomesState extends State<StreamHomes> {
  int currentInddex = 0;
  Widget body;
  int count = 0;

  @override
  initState() {
    // default screen
    body = NewsScreen();
    super.initState();
  }

  updateMyWidget() {
    setState(() {
      count++;
      // replaced
      body = Text("text is $count");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Strams"),
      ),
      body: NewsScreen(),
      // body: InkWell(
      //     child: Center(child: body),
      //     onTap: () {
      //       updateMyWidget();
      //     }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (builder) => CurdScreen()));
          },
          child: Icon(Icons.plus_one)),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.black,
          currentIndex: currentInddex,
          onTap: (pos) {
            setState(() {
              currentInddex = pos;
            });

            if (pos == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => HomeScreen()));
            }
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.verified_user), label: "Profile"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
            BottomNavigationBarItem(icon: Icon(Icons.more), label: "More"),
          ]),
    );
  }
}
