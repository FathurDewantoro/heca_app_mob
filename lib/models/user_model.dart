class UserModel {
  String uid;
  String email;
  String name;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }
}
