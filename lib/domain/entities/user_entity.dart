import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.mobile,
    this.role,
  });

  final String id;
  final String name;
  final String email;
  final String? mobile;
  final String? role;

  @override
  List<Object?> get props => [id, name, email, mobile, role];
}
