import 'package:flutter/material.dart';
import 'package:my_first_app/my_providers/crud_provider.dart';
import 'package:provider/provider.dart';

class CurdScreen extends StatefulWidget {
  @override
  _CurdScreenState createState() => _CurdScreenState();
}

class _CurdScreenState extends State<CurdScreen> {
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();

  FirestoreCRUDProvider firestoreCRUDProvider;

  @override
  initState() {
    super.initState();
    firestoreCRUDProvider =
        Provider.of<FirestoreCRUDProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
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
                onPressed: () async {
                  await postNews();
                },
                child: Text("Post"))
          ],
        ),
      ),
    );
  }

  postNews() async {
    await firestoreCRUDProvider.addNewRecord(
        titleTextEditingController.text, descriptionTextEditingController.text);
    Navigator.pop(context);
  }
}
