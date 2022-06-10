import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:students_quiz/create%20new%20quiz%20layout.dart';
import 'package:students_quiz/create%20new%20quiz%20name%20and%20warning.dart';
import 'package:students_quiz/login%20layout.dart';
import 'package:students_quiz/quiz%20question%20item%20layout.dart';
import 'package:students_quiz/result%20layout.dart';

import 'Utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
final navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: _scaffoldKey,
      theme: ThemeData(
          //Define the default brightness and colors.
          primaryColor: Colors.cyan,

          //default font family
          fontFamily: "Lato",

          //define the default "TextTheme". Use this to specify the default
          //text styling for headlines,titles, bodies of text, and  more.
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
            bodyText2: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Hind',
                fontWeight: FontWeight.bold),
          ),
      ),
      home: const Scaffold(
        body: Layout(),
      ),
    );
  }
}

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginLayout();
  }
}
