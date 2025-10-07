class User {
  final String id;
  final String email;
  final String name;
  final String? profileImage;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.profileImage,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      profileImage: map['profileImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profileImage': profileImage,
    };
  }
}