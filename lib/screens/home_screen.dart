import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/news_model.dart';
import 'package:my_first_app/my_providers/crud_provider.dart';
import 'package:my_first_app/screens/post_screen.dart';
import 'package:provider/provider.dart';

import 'auth_flow_screen.dart';
import 'my_google_maps.dart';
import 'payment_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirestoreCRUDProvider firestoreCRUDProvider;
  User user;
  @override
  void initState() {
    firestoreCRUDProvider =
        Provider.of<FirestoreCRUDProvider>(context, listen: false);
    user = FirebaseAuth.instance.currentUser;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
      // QuerySnapshot
      body: StreamBuilder<DocumentSnapshot>(
          stream: firestoreCRUDProvider.newsStream(id: "Xt2x1KV7XTIzRRqzLnUP"),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            /**
             * data unapudu
             * data lo error
             * data loading
             */
            if (snapshot.hasData) {
              NewsModel newsModel = NewsModel.fromMap(snapshot.data.data());

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

              // if (snapshot.data.docs.length == 0) {
              //   return Center(child: Text("No news now"));
              // }
              // return ListView.builder(
              //     itemCount: snapshot.data.docs.length,
              //     itemBuilder: (context, index) {
              //       NewsModel newsModel =
              //           NewsModel.fromMap(snapshot.data.docs[index].data());

              //       return Card(
              //         child: Container(
              //           padding: EdgeInsets.all(8),
              //           child: Column(
              //             children: [
              //               newsModel.imageUrl != null
              //                   ? Image.network(
              //                       newsModel.imageUrl,
              //                       height: 150,
              //                       width: 150,
              //                     )
              //                   : Container(),
              //               Text(newsModel.title),
              //               Text(newsModel.description),
              //               IconButton(
              //                   onPressed: () async {
              //                     await FirebaseStorage.instance
              //                         .refFromURL(newsModel.imageUrl)
              //                         .delete();
              //                     await FirebaseFirestore.instance
              //                         .collection("news")
              //                         .doc(newsModel.docID)
              //                         .delete();
              //                   },
              //                   icon: Icon(Icons.delete, color: Colors.red))
              //             ],
              //           ),
              //         ),
              //       );
              //     });
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

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    firestoreCRUDProvider.dispose();
    super.dispose();
  }
}
