import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/news_model.dart';

class FirestoreCRUDProvider extends ChangeNotifier {
  List<NewsModel> _newsModelList = [];

  //List<NewsModel> get data => _newsModelList;

  FirestoreCRUDProvider() {
    dataAll();
  }

  List<NewsModel> get items {
    return [..._newsModelList];
  }

  dataAll() {
    FirebaseFirestore.instance.collection("crud").snapshots().listen((event) {
      items.addAll(event.docs.map((e) => NewsModel.fromMap(e.data())).toList());
    });
    notifyListeners();
    fecthDaata();
  }

  fecthDaata() {
    FirebaseFirestore.instance.collection("crud").snapshots().listen((event) {
      event.docChanges.forEach((element) {
        if (element.type == DocumentChangeType.added) {
          items.add(NewsModel.fromMap(element.doc.data()));
        }
        if (element.type == DocumentChangeType.removed) {
          items.remove(NewsModel.fromMap(element.doc.data()));
        }
        if (element.type == DocumentChangeType.modified) {
          items.remove(NewsModel.fromMap(element.doc.data()));
          items.add(NewsModel.fromMap(element.doc.data()));
        }
        notifyListeners();
      });
    });
  }

  addNewRecord(String title, String description) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    //Future<String> name = await getDatFromserver();

    // Map map = Map();
    // map['title'] = title;
    // map['title'] = title;
    NewsModel newsModel = NewsModel();
    newsModel.title = title;
    newsModel.description = description;
    newsModel.uid = FirebaseAuth.instance.currentUser.uid;

    DocumentReference documentReference =
        firebaseFirestore.collection("crud").doc("sasas");
    // add

    newsModel.docID = documentReference.id;
    //await documentReference.set(newsModel.toMap());
    await documentReference.update(newsModel.toMap());
    notifyListeners();
  }
}
