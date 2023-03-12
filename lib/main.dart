import 'package:flutter/material.dart';
import 'package:pocket_guard/pages/auth_screens/login_screen.dart';
import 'package:pocket_guard/utilities/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: kScaffoldBackground,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black, // set the desired color here
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
