import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import '../api/apis.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Size mq;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if(APIs.auth.currentUser != null ){
        log('\nUser: ${APIs.auth.currentUser}');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()));
            } else{
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()));
        }
        });
      }
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white, // ✅ White background added
      body: Stack(
        children: [
          // ✅ Center icon image
          Positioned(
            top: mq.height * 0.15,
            right: mq.width * 0.25,
            width: mq.width * 0.5,
            child: Image.asset('assets/images/icon.png'),
          ),

          // ✅ Bottom text
          Positioned(
            bottom: mq.height * 0.15,
            width: mq.width,
            child: const Text(
              'Made In Pakistan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
