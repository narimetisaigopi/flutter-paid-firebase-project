import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/news_model.dart';
import 'package:my_first_app/my_providers/crud_provider.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  FirestoreCRUDProvider firestoreCRUDProvider;
  @override
  void initState() {
    firestoreCRUDProvider =
        Provider.of<FirestoreCRUDProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: firestoreCRUDProvider.items.length,
        itemBuilder: (context, index) {
          NewsModel newsModel = firestoreCRUDProvider.items[index];
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => HomeScreen()));
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
}
