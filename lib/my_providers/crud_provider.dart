import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/news_model.dart';

class FirestoreCRUDProvider extends ChangeNotifier {
  List<NewsModel> _newsModelList = [];

  List<NewsModel> get data => _newsModelList;

  FirestoreCRUDProvider() {
    //dataAll();
  }

  // List<NewsModel> get items {
  //   return [..._newsModelList];
  // }

  dataAll() async {
    try {
      FirebaseFirestore.instance.collection("crud").snapshots().listen((event) {
        print("dataAll: in " + event.size.toString());
        _newsModelList.addAll(
            event.docs.map((e) => NewsModel.fromMap(e.data())).toList());
        print("dataAll: af in " + _newsModelList.length.toString());
        notifyListeners();
      });
    } catch (e) {
      print("dataAll: " + e.toString());
    }

    print("dataAll: " + _newsModelList.length.toString());
    fecthDaata();

    //notifyListeners();
    //fecthDaata();
  }

  newsStream({String id}) async {
    return id == null
        ? FirebaseFirestore.instance
            .collection("crud")
            .where("start", isGreaterThan: "start")
            .where("end", isLessThan: "")
            .snapshots()
        : FirebaseFirestore.instance.collection("crud/$id").doc("").get();
  }

  fecthDaata() {
    FirebaseFirestore.instance.collection("crud").snapshots().listen((event) {
      event.docChanges.forEach((element) {
        if (element.type == DocumentChangeType.added) {
          _newsModelList.add(NewsModel.fromMap(element.doc.data()));
        }
        // if (element.type == DocumentChangeType.removed) {
        //   _newsModelList.remove(NewsModel.fromMap(element.doc.data()));
        // }
        // if (element.type == DocumentChangeType.modified) {
        //   _newsModelList.remove(NewsModel.fromMap(element.doc.data()));
        //   _newsModelList.add(NewsModel.fromMap(element.doc.data()));
        // }
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
        firebaseFirestore.collection("crud").doc("");
    // add

    newsModel.docID = documentReference.id;
    //await documentReference.set(newsModel.toMap());
    await documentReference.set(newsModel.toMap());
    notifyListeners();
  }
}
