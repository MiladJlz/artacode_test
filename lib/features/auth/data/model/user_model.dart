import '../../domain/model/user.dart';

class UserModel extends User {
  UserModel({required super.token});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(token: map['token'] ?? '');
  }
}
