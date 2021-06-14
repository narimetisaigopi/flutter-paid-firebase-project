import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/news_model.dart';
import 'package:my_first_app/post_screen.dart';

import 'auth_flow_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          Text(user.email),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (builder) => AuthFlowScreen()),
                    (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("news").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            /**
             * data unapudu
             * data lo error
             * data loading
             */
            if (snapshot.hasData) {
              if (snapshot.data.docs.length == 0) {
                return Center(child: Text("No news"));
              }
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    NewsModel newsModel =
                        NewsModel.fromMap(snapshot.data.docs[index].data());

                    return ListTile(
                      title: Text(newsModel.title),
                      subtitle: Text(newsModel.description),
                    );
                  });
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return CircularProgressIndicator();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => PostScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
