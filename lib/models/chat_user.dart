class ChatUser {
  final String email;
  final String image;
  final bool isOnline;
  final String lastActive;
  final String name;
  final String pushToken;

  ChatUser({
    required this.email,
    required this.image,
    required this.isOnline,
    required this.lastActive,
    required this.name,
    required this.pushToken,
  });

  // Convert Firestore JSON → Dart object
  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      isOnline: json['is_online'] == true || json['is_online'] == 'true',
      lastActive: json['last_active'] ?? '',
      name: json['name'] ?? '',
      pushToken: json['push_token'] ?? '',
    );
  }

  // Convert Dart object → Firestore JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'image': image,
      'is_online': isOnline,
      'last_active': lastActive,
      'name': name,
      'push_token': pushToken,
    };
  }
}
