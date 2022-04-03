import 'dart:convert';

class User {
  int? id;
  String? username;
  String? email;

  User({this.id, this.username, this.email});

  @override
  String toString() => 'User(id: $id, username: $username, email: $email)';

  factory User.fromMap(Map<String, dynamic> data) => User(
        id: data['id'] as int?,
        username: data['username'] as String?,
        email: data['email'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'email': email,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());
}
