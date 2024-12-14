import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';

abstract interface class AuthLocalDatasource {
  bool? getStatusLogIn();

  Future<bool> setStatusLogIn(bool b);
}

class AuthLocalDataSourceImpl implements AuthLocalDatasource {
  final SharedPreferences pref;

  AuthLocalDataSourceImpl({required this.pref});
  @override
  bool? getStatusLogIn() {
    try {
      final status = pref.getBool("isLogged");

      return status;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> setStatusLogIn(bool b) async {
    try {
      final status = await pref.setBool("isLogged", b);
      return status;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
