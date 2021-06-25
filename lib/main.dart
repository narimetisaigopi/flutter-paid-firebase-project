import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/my_providers/crud_provider.dart';
import 'package:provider/provider.dart';

import 'screens/auth_flow_screen.dart';
import 'my_providers/count_increment/count_provider.dart';
import 'my_providers/cart/my_cart_provider.dart';
import 'screens/streams_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseMessaging.instance.getToken().then((value) {
  //   print("My device token : " + value.toString());
  // });
  // FirebaseMessaging.onMessage.listen((event) {
  //   //event.data;
  // });
  // notifications
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  //FirebaseMessaging.onBackgroundMessage((message) => null).listen((event) {});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root o.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CountProvider()),
        ChangeNotifierProvider(create: (context) => MyCartProvider()),
        ChangeNotifierProvider(create: (_) => FirestoreCRUDProvider())
      ],
      child: MaterialApp(
        title: 'My App Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'koho',
            buttonColor: Colors.red,
            primarySwatch: Colors.red,
            floatingActionButtonTheme:
                FloatingActionButtonThemeData(backgroundColor: Colors.green)),
        home: StreamHomes(),
      ),
    );
  }
}
