import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../api/apis.dart';
import '../helper/dialogs.dart';
import '../main.dart';
import '../models/chat_user.dart';
// import 'auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          shape: const Border(bottom: BorderSide(color: Colors.grey, width: 1)),
          title: const Text(
            'Profile Screen',
            style: TextStyle(color: Colors.black),
          ),
        ),

        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            onPressed: () async {
              Dialogs.showProgressBar(context);

              await APIs.auth.signOut();
              await GoogleSignIn().signOut();

              Navigator.pop(context); // close progress dialog
              Navigator.pop(context); // close profile screen

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
          ),
        ),

        body: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 250, vertical: 50),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 3),

                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(300),
                        child: CachedNetworkImage(
                        width: 250,
                        height: 250,
                         fit: BoxFit.fill,
                           imageUrl: widget.user.image,
                          errorWidget: (context, url, error) =>
                             const CircleAvatar(
                                child: Icon(CupertinoIcons.person),
                               ),
                         ),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: MaterialButton(
                          onPressed: () {
                            _showBottomSheet();
                          },
                          shape: const CircleBorder(),
                          color: Colors.white,
                          child: const Icon(Icons.edit, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Text(
                    widget.user.email,
                    style: const TextStyle(color: Colors.black54, fontSize: 20),
                  ),

                  const SizedBox(height: 30),
                  TextFormField(
                    initialValue: widget.user.about,
                    onSaved: (val) => APIs.me.name = val ?? '';
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.info_outline),
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  TextFormField(
                    initialValue: widget.user.about,
                    onSaved: (val) => APIs.me.about = val ?? '',
                    validator: (val) => val != null && val.isNotEmpty
                    ? null
                    : 'Required Feild',
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.info_outline),
                      labelText: 'About',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'eg.Feeling Happy'
                      lable: const Test('About');
                    ),
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState.save();
                        APIs.updateUserInfo().then(value){
                       Dialogs.showSnackbar(context, 'profile update succcessfully')
                        };
                      }
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('UPDATE'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _showBottomSheet(){
    showModalBottomSheet(context: context,
    shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only()),
     builder: (_){
   return ListView();
  });
     
   }

  }


