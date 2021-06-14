import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'auth_flow_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //FirebaseCrashlytics.instance.crash();

  FirebaseMessaging.instance.getToken().then((value) {
    print("My device token : " + value.toString());
  });
  FirebaseMessaging.onMessage.listen((event) {
    //event.data;
  });
  // notifications
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  //FirebaseMessaging.onBackgroundMessage((message) => null).listen((event) {});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root o.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'koho',
          buttonColor: Colors.red,
          primarySwatch: Colors.red,
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.green)),
      home: AuthFlowScreen(),
    );
  }
}
