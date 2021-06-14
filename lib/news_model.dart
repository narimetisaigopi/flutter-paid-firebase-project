import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  String imageUrl;
  String title;
  String description;
  Timestamp timestamp;
  String uid;
  String docID;

  NewsModel(
      {this.imageUrl,
      this.title,
      this.description,
      this.timestamp,
      this.uid,
      this.docID});

  factory NewsModel.fromMap(Map map) {
    return NewsModel(
      imageUrl: map['imageUrl'],
      title: map['title'],
      description: map['description'],
      timestamp: map['timestamp'],
      uid: map['uid'],
      docID: map['docID'],
    );
  }

  toMap() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
      'uid': uid,
      'docID': docID
    };
  }
}
