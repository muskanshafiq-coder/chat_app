
// import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/api/apis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../helper/dialogs.dart';
import '../models/chat_user.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ProfileScreen > {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          shape: const Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          title: const Text(
            'Profile Screen',
            style: TextStyle(color: Colors.black),
          )),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.redAccent,
          onPressed: () async {
            Dialogs.showProgressBar(context);
            await APIs.auth.signOut().then((value) async {
              await GoogleSignIn().signOut().then((value) {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              });
            });
          },
          icon: const Icon(Icons.logout), label: Text(' logout'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 250, vertical: 50),
        child: Column(children: [


          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    width: 250,
                    height: 250,
                    imageUrl: widget.user.image,
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                    const CircleAvatar(child: Icon(CupertinoIcons.person),)
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: MaterialButton(
                  onPressed: () {},
                  shape: CircleBorder(),
                  color: Colors.white,
                  child: Icon(Icons.edit, color: Colors.blue,),
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
          Text(widget.user.email,
            style: TextStyle(color: Colors.black54, fontSize: 20),),

          SizedBox(height: 30,),

          TextFormField(
            initialValue: widget.user.name,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                label: Text('Name'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
          ),
          SizedBox(height: 30,),

          TextFormField(
            initialValue: widget.user.about,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.info_outline),
                label: Text('About'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
          ),
          SizedBox(height: 30,),

          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(),
            onPressed: () {},
            icon: Icon(Icons.edit),
            label: Text('UPDATE'),)
        ],),

      ),
    );
  }

// ---- Logout function (private) ----
// Future<void> _logout(BuildContext context) async {
//   final confirm = await showDialog<bool>(
//     context: context,
//     builder: (_) => AlertDialog(
//       title: const Text('Logout'),
//       content: const Text('Are you sure you want to sign out?'),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context, false),
//           child: const Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () => Navigator.pop(context, true),
//           child: const Text('Logout', style: TextStyle(color: Colors.red)),
//         ),
//       ],
//     ),
//   );
//
//   if (confirm ?? false) {
//     try {
//       await APIs.auth.signOut();
//
//       // Disconnect Google SignIn if needed to avoid automatic re-login:
//       final googleSignIn = GoogleSignIn();
//       if (await googleSignIn.isSignedIn()) {
//         await googleSignIn.disconnect();
//         await googleSignIn.signOut();
//       }
//
//       if (context.mounted) {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (_) => const LoginScreen()),
//               (route) => false,
//         );
//       }
//     } catch (e) {
//       // show error and print to console
//       debugPrint('Logout error: $e');
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Logout failed: $e')),
//         );
//       }
//     }
//   }
// }
}