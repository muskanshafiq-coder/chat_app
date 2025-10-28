import 'dart:developer';

import 'package:chat_app/api/apis.dart';
import 'package:chat_app/widgets/chat_user_card.dart';
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
            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
          },
           child: const Icon(Icons.add_comment_rounded),
        ),
      ),

      body: StreamBuilder(
        stream:  APIs.firestore.collection('user').snapshots(),
            builder: (context, snapshot) {
          final list = [];

          if (snapshot.hasData) {
            final data = snapshot.data?.docs;
            for (var i in data!) {
              log('Data: ${i.data() }');
              list.add(i.data()['name']);
            }
          }
              ListView.builder(
                  itemCount: list.length ,
                  padding: EdgeInsets.only(top: 0.02),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    // return const ChatUserCard();
                    return Text('Name: ${list[index]} ');
                  });
            },
      ),
    );
  }
}
