import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_first_app/models/news_model.dart';
import 'package:path/path.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();

  File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            file != null
                ? Column(
                    children: [
                      Image.file(
                        file,
                        height: 100,
                        width: 100,
                      ),
                      Text("Image Path >>> ${file.path}")
                    ],
                  )
                : Text("No Image selected"),
            ElevatedButton(
                onPressed: () {
                  pickImage();
                },
                child: Text("Pick Image")),
            SizedBox(height: 20),
            TextField(
              controller: titleTextEditingController,
              decoration: InputDecoration(hintText: "Title"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionTextEditingController,
              decoration: InputDecoration(hintText: "Description"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  uploadImage();
                },
                child: Text("Post"))
          ],
        ),
      ),
    );
  }

  postNews(String imageURL) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    NewsModel newsModel = NewsModel();
    newsModel.title = titleTextEditingController.text;
    newsModel.description = descriptionTextEditingController.text;
    newsModel.uid = FirebaseAuth.instance.currentUser.uid;
    newsModel.imageUrl = imageURL;
    // Map<String, dynamic> map = Map();
    // map['title'] = titleTextEditingController.text;
    // map['description'] = descriptionTextEditingController.text;
    // map['uid'] = FirebaseAuth.instance.currentUser.uid;
    // map['timestamp'] = FieldValue.serverTimestamp();

    DocumentReference documentReference =
        firebaseFirestore.collection("news").doc();
    newsModel.docID = documentReference.id;
    //await documentReference.set(newsModel.toMap());

    await documentReference.set(newsModel.toMap());

    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text("Posted News")));
    // Navigator.pop(context);
    // titleTextEditingController.clear();
    // descriptionTextEditingController.clear();
  }

  pickImage() async {
    //ImagePicker().getImage(source: ImageSource.gallery);
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    print("pickImage ${pickedFile.path}");
    setState(() {
      file = File(pickedFile.path);
    });
  }

  uploadImage() {
    if (file == null) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text("Please select an image")));
      return;
    }
    // String fileName = "user file " + DateTime.now().microsecondsSinceEpoch.toString() + ".jpg";
    FirebaseStorage.instance
        .ref("images")
        .child(basename(file.path))
        .putFile(file)
        .then((e) async {
      String url = await e.ref.getDownloadURL();
      print("Uploading image url " + url.toString());
      postNews(url);
    }).catchError((onError) {
      throw Exception(onError.toString());
    });
  }
}
