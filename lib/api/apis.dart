import 'package:chat_app/models/chat_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static late ChatUser me;

  static User get user => auth.currentUser!;

  // 🟢 Check if user exists, otherwise create
  static Future<void> userExists() async {
    final userDoc = await firestore.collection('users').doc(user.uid).get();

    if (userDoc.exists) {
      me = ChatUser.fromJson(userDoc.data()!);
    } else {
      await createUser();
      await getSelfInfo();
    }
  }

  // 🟢 Get self info (returns true if user exists)
  static Future<bool> getSelfInfo() async {
    final doc = await firestore.collection('users').doc(user.uid).get();
    if (doc.exists) {
      me = ChatUser.fromJson(doc.data()!);
      return true;
    }
    return false;
  }

  // 🟢 Create user in Firestore
  static Future<void> createUser() async {
    final user = auth.currentUser!;
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

    await firestore.collection('users').doc(user.uid).set(chatUser.toJson());
  }

  // 🟢 Get all users except the current one
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }
}
