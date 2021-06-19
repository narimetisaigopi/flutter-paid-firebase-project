import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: Column(
          children: [
            TextField(
              controller: _emailTextEditingController,
              decoration: InputDecoration(hintText: "Email"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: true,
              controller: _passwordTextEditingController,
              decoration: InputDecoration(hintText: "Password"),
            ),
            SizedBox(
              height: 20,
            ),
            loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: Text("Login"))
          ],
        ));
  }

  login() async {
    try {
      setState(() {
        loading = true;
      });
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
              email: _emailTextEditingController.text,
              password: _passwordTextEditingController.text);
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Logged in")));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (builder) => HomeScreen()),
          (route) => false);
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
