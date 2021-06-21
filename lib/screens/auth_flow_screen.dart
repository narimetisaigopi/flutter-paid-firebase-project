import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/screens/login_screen.dart';
import 'package:my_first_app/my_providers/count_increment/count_screen.dart';
import 'package:my_first_app/screens/registartion_screen.dart';

import 'home_screen.dart';
import '../screens/mobile_number_screen.dart';
import '../my_providers/cart/my_items_screen.dart';
import 'my_todo_list.dart';
import 'my_todo_list_mvc.dart';

class AuthFlowScreen extends StatefulWidget {
  @override
  _AuthFlowScreenState createState() => _AuthFlowScreenState();
}

class _AuthFlowScreenState extends State<AuthFlowScreen> {
  checkLoginStatus() {
    if (FirebaseAuth.instance.currentUser != null) {
      // user logged in
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (builder) => MyToListMVC()),
          (route) => false);
    } else {
      // user not loggin in
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              child: Text("Login")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => RegistrationScreen()));
              },
              child: Text("Register")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => MobileNumberScreen()));
              },
              child: Text("Mobile Auth"))
        ],
      ),
    );
  }
}
