import 'package:flutter/material.dart';
import 'package:timetackerapp/app/sign_in/sign_in_page.dart';

// This is the starting point of the execution of an application
void main() => runApp(MyApp());

//MyApp is the root widget of the Flutter Application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      title: 'Time Tracker',
      theme: ThemeData
      (
        primarySwatch: Colors.indigo
      ),
      home: SignInPage(),
    );
  }
}
