import 'package:chat_app/models/chat_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static late ChatUser me;

  static get user => auth.currentUser!;

  static Future<void> userExists() async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .get()
        .then((userDoc) async {
      if (userDoc.exists) {
        me = ChatUser.fromJson(userDoc.data()!);
      } else {
        await creatUser().then((value) => getSelfInfo());
      }
    });
  }

  static Future<bool> getSelfInfo() async {
    return (await firestore
        .collection('users')
        .doc(user.uid)
        .get())
        .exists;
  }

  static Future<bool> creatUser() async {
    try {
      final user = auth.currentUser!;
      final userDoc = firestore.collection('users').doc(user.uid);

      // ✅ If already exists, don’t recreate
      if ((await userDoc.get()).exists) {
        print("ℹ️ User already exists — skipping creation.");
        return true;
      }

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

      await userDoc.set(chatUser.toJson());
      print("✅ User created successfully!");
      return true;
    } catch (e) {
      print("🔥 Error creating user: $e");
      return false;
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }
}