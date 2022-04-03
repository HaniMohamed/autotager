import 'dart:convert';

import 'package:autotager/app/data/model/dtos/api/login_response_dto/user.dart';

class LoginResponse {
  User? user;
  String? token;

  LoginResponse({this.user, this.token});

  @override
  String toString() => 'LoginResponse(user: $user, token: $token)';

  factory LoginResponse.fromMap(Map<String, dynamic> data) => LoginResponse(
        user: data['user'] == null
            ? null
            : User.fromMap(data['user'] as Map<String, dynamic>),
        token: data['token'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'user': user?.toMap(),
        'token': token,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginResponse].
  factory LoginResponse.fromJson(String data) {
    return LoginResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
