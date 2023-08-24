import 'package:assign_11/screens/sign_up/interest_list.dart';
import 'package:assign_11/screens/sign_up/verification.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const TwitterApp());
}

class TwitterApp extends StatelessWidget {
  const TwitterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const VerificateScreen(
        email: 'torch@nomadcoders.co',
      ),
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.amber.shade700,
        textTheme: Typography.blackCupertino,
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
          shadowColor: Colors.amber,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: Typography.whiteCupertino,
        primaryColor: Colors.pinkAccent.shade200,
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.black,
        ),
      ),
    );
  }
}
