import "package:dio/dio.dart";
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/connection_checker.dart';
import 'features/auth/data/datasources/auth_local_datasource.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/user_check_auth.dart';
import 'features/auth/domain/usecases/user_login.dart';
import 'features/auth/domain/usecases/user_logout.dart';
import 'features/auth/domain/usecases/user_signup.dart';
import 'features/auth/presentation/bloc/user_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final shPref = await SharedPreferences.getInstance();
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory(() => Dio());
  serviceLocator.registerFactory(() => shPref);
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator()));
  _initAuth();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(dio: serviceLocator()))
    ..registerFactory<AuthLocalDatasource>(
        () => AuthLocalDataSourceImpl(pref: serviceLocator()))
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        serviceLocator(), serviceLocator(), serviceLocator()))
    ..registerFactory(() => UserSignUp(authRepository: serviceLocator()))
    ..registerFactory(() => UserLogin(authRepository: serviceLocator()))
    ..registerFactory(() => UserLogout(authRepository: serviceLocator()))
    ..registerFactory(() => UserCheckAuth(authRepository: serviceLocator()))
    ..registerLazySingleton(() => AuthBloc(
          userSignUp: serviceLocator(),
          userLogin: serviceLocator(),
          userCheckAuth: serviceLocator(),
          userLogOut: serviceLocator(),
        ));
}
