import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth_flow_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
