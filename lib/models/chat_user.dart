class ChatUser {
  final String image;
  final String about;
  final String name;
  final String createdAt;
  final bool isOnline;
  final String id;
  final String lastActive;
  final String pushToken;
  final String email;

  ChatUser({
    required this.image,
    required this.about,
    required this.name,
    required this.createdAt,
    required this.isOnline,
    required this.id,
    required this.lastActive,
    required this.pushToken,
    required this.email,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      image: json['image'] ?? '',
      about: json['about'] ?? '',
      name: json['name'] ?? '',
      createdAt: json['created_at'] ?? '',
      isOnline: json['is_online'] ?? false,
      id: json['id'] ?? '',
      lastActive: json['last_active'] ?? '',
      pushToken: json['push_token'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'about': about,
      'name': name,
      'created_at': createdAt,
      'is_online': isOnline,
      'id': id,
      'last_active': lastActive,
      'push_token': pushToken,
      'email': email,
    };
  }
}
