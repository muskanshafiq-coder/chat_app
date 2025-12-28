import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/chat_user.dart';
class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore  firestore => FirebaseFirestore.instance;
  static late ChatUser me;
  static User get user => auth.currentUser!;
  static Future<bool> userExists() async{
    return(await firestore.collection('user').doc(user.uid).get()).exists;
  }

  // 🟢 Check if user exists, otherwise create
  static Future<void> getSelfInfo() async {
     await firestore.collection('users').doc(user.uid).get().then((user)async){};
    if (user.exists) {
      me = ChatUser.fromJson(user.data()!);
      log('My Data: ${user.data()}');
    } else {await createUser().then((value) => getSelfInfo());
      ;
    }
  }

  // 🟢 Create user in Firestore
  static Future<void> createUser() async {
    final time = DataTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      about: 'Feeling Happy',
      image: user.photoURL ?? '',
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      isOnline: true,
      lastActive: DateTime.now().millisecondsSinceEpoch.toString(),
      pushToken: '',
    );
    return await firestore.collection('users').doc(user.uid).set(chatUser.toJson());
  }

  // 🟢 Get self info (returns true if user exists)
  static Future<void> getSelfInfo() async {
    final doc = await firestore.collection('users').doc(user.uid).set(ChatUser.toJson());

  // 🟢 Get all users except the current one
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }
}
static Future<void>updateUserInfo()async{
  await firestore.collection('users').doc(user.uid).update({'name': me.name,'about': me.about});
}
}