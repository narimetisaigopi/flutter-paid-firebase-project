import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/news_model.dart';

import 'home_screen.dart';

class CrudScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("crud").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          /**
             * data unapudu
             * data lo error
             * data loading
             */

          if (snapshot.hasData) {
            if (snapshot.data.docs.length == 0) {
              return Center(child: Text("No news now"));
            }
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  NewsModel newsModel =
                      NewsModel.fromMap(snapshot.data.docs[index].data());
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => HomeScreen()));
                    },
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(newsModel.title),
                            Text(newsModel.description),
                            IconButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("crud")
                                      .doc(newsModel.docID)
                                      .delete();
                                },
                                icon: Icon(Icons.delete, color: Colors.red))
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return CircularProgressIndicator();
        });
  }
}
