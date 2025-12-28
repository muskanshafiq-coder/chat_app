import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../api/apis.dart';
import '../main.dart';
import '../models/chat_user.dart';
import '../widgets/chat_user_card.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> _list = [];
    final List<ChatUser> _searchlist = [];
    bool _isSearching = false;


  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>FocusScope.of(context).unfocus(),
      child:WillPopScope(
        onWillPop: () {
          if(_isSearching ){
            setState(() {
              _isSearching = !_isSearching;

            });
          }else{
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: const Icon(CupertinoIcons.home, color: Colors.black),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white, 
            shape: const Border(bottom: BorderSide(color: Colors.grey, width: 1)),
            title: _isSearching? TextField(
              decoration:const InputDecoration(border: InputBorder.none,hintText: 'Name,Email,...'),
              autofocus: true,
              onChanged: (val){
                _searchlist.clear();
                for(var i in _list);
                if(i.name.inLowerCase().contains(val.toLowerCase()) ||
                i.email.inLowerCase().contains(val.toLowerCase())){
                  _searchlist.add(i);
                }
                setState(() {
                  _searchlist;
                });
              },
          
            ):const Text('We Chat', style: TextStyle(color: Colors.black)),
            actions: [
              IconButton(onPressed: (){
                setState(() {
                  _isSearching = !_isSearching;
                });
              }, icon: Icon(_isSearching ?CupertinoIcons.add_circled_solid:Icons.search)),
              IconButton(
                onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfileScreen(user: APIs.me)) );
                  } 
                icon: const Icon(Icons.more_vert, color: Colors.black))
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              onPressed: () async {
                await _logout(context);
              },
              child: const Icon(Icons.logout),
            ),
          ),
        
          body: StreamBuilder(
            stream: APIs.getAllUsers(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(child: CircularProgressIndicator());
        
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
        
                  final data = snapshot.data?.docs;
                  _list =
                      data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
        
                  if (_list.isNotEmpty) {
                    return ListView.builder(
                      itemCount: _isSearching ? _isSearching.length : _list.length,
                      padding: const EdgeInsets.all(8),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChatUserCard(user: _isSearching ? _isSearching[index]: _list[index]);
                      },
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'No Connections Found!',
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }
              }
            },
          ),
        ),
      ),
    );
  }

//   // ---- Logout function ----
//   Future<void> _logout(BuildContext context) async {
//     final confirm = await showDialog<bool>(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Logout'),
//         content: const Text('Are you sure you want to sign out?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context, true),
//             child: const Text('Logout', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );

//     if (confirm ?? false) {
//       try {
//         await APIs.auth.signOut();

//         // Disconnect Google Sign-In to avoid auto-login
//         final googleSignIn = GoogleSignIn();
//         if (await googleSignIn.isSignedIn()) {
//           await googleSignIn.disconnect();
//           await googleSignIn.signOut();
//         }

//         if (context.mounted) {
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (_) => const LoginScreen()),
//             (route) => false,
//           );
//         }
//       } catch (e) {
//         debugPrint('Logout error: $e');
//         if (context.mounted) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text('Logout failed: $e')));
//         }
//       }
//     }
//   }
 }
