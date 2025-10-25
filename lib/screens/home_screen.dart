import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.home),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.grey, // line color
            width: 1, // line thickness
          ),
        ),


        title: const Text(
          'We Chat',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),

      // ✅ Fixed Floating Action Button syntax
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () async{
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
          },
           child: const Icon(Icons.add_comment_rounded),
        ),
      ),
    );
  }
}
