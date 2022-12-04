import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'auth/firebase_options.dart';

import 'globals/colors.dart';

import 'auth/auth_gate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Futura",
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            fontFamily: "Helvetica",
            color: textColor,
          ),
          headline2: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: "Helvetica",
            color: textColor.withOpacity(0.75),
          ),
          subtitle1: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
          subtitle2: TextStyle(
            fontSize: 18,
            color: textColor,
            decoration: TextDecoration.underline
          )
        ),
      ),
      // home: BarkBook(),
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}