import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/news_model.dart';
import 'package:my_first_app/post_screen.dart';

import 'auth_flow_screen.dart';
import 'my_google_maps.dart';
import 'user/payment_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          Text(
              user.email != null ? user.email : user.phoneNumber.toLowerCase()),
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

                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            newsModel.imageUrl != null
                                ? Image.network(
                                    newsModel.imageUrl,
                                    height: 150,
                                    width: 150,
                                  )
                                : Container(),
                            Text(newsModel.title),
                            Text(newsModel.description),
                            IconButton(
                                onPressed: () async {
                                  await FirebaseStorage.instance
                                      .refFromURL(newsModel.imageUrl)
                                      .delete();
                                  await FirebaseFirestore.instance
                                      .collection("news")
                                      .doc(newsModel.docID)
                                      .delete();
                                },
                                icon: Icon(Icons.delete, color: Colors.red))
                          ],
                        ),
                      ),
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
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => PaymentScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
