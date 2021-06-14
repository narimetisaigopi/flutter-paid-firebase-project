import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  String imageUrl;
  String title;
  String description;
  Timestamp timestamp;
  String uid;

  NewsModel(
      {this.imageUrl, this.title, this.description, this.timestamp, this.uid});

  factory NewsModel.fromMap(Map map) {
    return NewsModel(
      imageUrl: map['imageUrl'],
      title: map['title'],
      description: map['description'],
      timestamp: map['timestamp'],
      uid: map['uid'],
    );
  }

  toMap() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
      'uid': uid,
    };
  }
}
