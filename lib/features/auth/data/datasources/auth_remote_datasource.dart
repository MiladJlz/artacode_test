import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/exceptions.dart';
import '../model/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword(
      {required String email, required String password});

  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});
  @override
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await dio.post("https://reqres.in/api/login",
          data: {"email": "byron.fields@reqres.in", "password": password});
      final user = UserModel.fromJson(response.data as Map<String, dynamic>);
      return user;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await dio.post("https://reqres.in/api/register",
          data: {"email": "byron.fields@reqres.in", "password": password});

      final user = UserModel.fromJson(response.data as Map<String, dynamic>);
      return user;
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException(e.toString());
    }
  }
}
