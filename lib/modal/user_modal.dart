class UserModel {
  String? name, email, image, phone, token;

  UserModel({
    required this.name,
    required this.email,
    required this.image,
    required this.token,
  });

  factory UserModel.fromMap(Map m1) {
    return UserModel(
      name: m1['name'],
      email: m1['email'],
      image: m1['image'],
      token: m1['token'],
    );
  }

  Map<String, String?> toMap(UserModel user) {
    return {
      'name': user.name,
      'email': user.email,
      'image': user.image,
      'token': user.token,
    };
  }
}
