import 'package:flutter/material.dart';
import 'home_screen.dart'; // ✅ import this

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Welcome to We Chat'),
        centerTitle: true,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
      ),
      body: Stack(
        children: [
          // ✅ Center image
          Center(
            child: Image.asset(
              'assets/images/icon.png',
              width: mq.width * 0.6,
              fit: BoxFit.contain,
            ),
          ),

          // ✅ Bottom Google Sign-In button
          Positioned(
            bottom: mq.height * 0.08,
            width: mq.width,
            child: Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 3,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                ),
                onPressed: () {
                  // 👉 navigate to home screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
                icon: Image.asset(
                  'assets/images/google.png',
                  height: 28,
                ),
                label: const Text(
                  'Sign in with Google',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
