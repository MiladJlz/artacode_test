import 'package:artacode_test/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/connection_checker.dart';
import '../../domain/model/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDatasource localDatasource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl(
      this.remoteDataSource, this.connectionChecker, this.localDatasource);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure("خطا در ارتباط"));
      }
      final res = await remoteDataSource.loginWithEmailPassword(
          email: email, password: password);
      localDatasource.setStatusLogIn(true);
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String email, required String password}) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure("خطا در ارتباط"));
      }
      final res = await remoteDataSource.signUpWithEmailPassword(
          email: email, password: password);
      localDatasource.setStatusLogIn(true);
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> logOut() async {
    try {
      final res = await localDatasource.setStatusLogIn(false);

      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool?>> checkUserAuth() async {
    try {
      final res = localDatasource.getStatusLogIn();
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
