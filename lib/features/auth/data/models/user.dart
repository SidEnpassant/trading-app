class User {
  final String email;
  final String name;
  final String token;

  User({required this.email, required this.name, required this.token});

  User copyWith({String? email, String? name, String? token}) {
    return User(
      email: email ?? this.email,
      name: name ?? this.name,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email, 'name': name, 'token': token};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      name: map['name'] as String,
      token: map['token'] as String,
    );
  }

  @override
  String toString() => 'User(email: $email, name: $name, token: $token)';
}
