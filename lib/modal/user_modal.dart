class UserModel {
  String? name, email, image, phone, token;
  bool isRead;
  bool online;
  int? lastSeen;

  UserModel({
    required this.name,
    required this.email,
    required this.image,
    required this.phone,
    required this.token,
    this.isRead = false,
    this.online = false,
    this.lastSeen,
  });

  UserModel copyWith({
    String? name,
    email,
    image,
    phone,
    token,
    bool? isRead,
    bool? online,
    int? lastSeen,
  }) =>
      UserModel(
        name: name ?? this.name,
        email: email ?? this.email,
        image: image ?? this.image,
        phone: phone ?? this.phone,
        token: token ?? this.token,
        isRead: isRead ?? this.isRead,
        online: online ?? this.online,
        lastSeen: lastSeen ?? this.lastSeen,
      );

  factory UserModel.fromMap(Map m1) {
    return UserModel(
      name: m1['name'],
      email: m1['email'],
      image: m1['image'],
      phone: m1['phone'],
      token: m1['token'],
      isRead: m1['isRead'] ?? false,
      online: m1['online'] ?? false,
      lastSeen: m1['lastSeen'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'phone': phone,
      'token': token,
      'isRead': isRead,
      'online': online,
      'lastSeen': lastSeen,
    };
  }
}
