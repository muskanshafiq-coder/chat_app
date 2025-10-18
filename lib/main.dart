import 'package:chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
  }

  class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       title: "we chat",
      theme: ThemeData(
        primarySwatch: Colors.red,
           ),
      home:  const LoginScreen(),

    );
  }
  }