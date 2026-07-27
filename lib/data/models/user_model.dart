import '../../domain/entities/user_entity.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.mobile,
    this.role,
    this.accessToken,
    this.refreshToken,
  });

  final String id;
  final String name;
  final String email;
  final String? mobile;
  final String? role;
  final String? accessToken;
  final String? refreshToken;

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      mobile: mobile,
      role: role,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      mobile: json['mobile'] as String?,
      role: json['role'] as String?,
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );
  }
}
