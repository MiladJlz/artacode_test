import 'package:artacode_test/features/auth/domain/usecases/user_check_auth.dart';
import 'package:artacode_test/features/auth/domain/usecases/user_logout.dart';
import 'package:artacode_test/features/auth/presentation/bloc/user_event.dart';
import 'package:artacode_test/features/auth/presentation/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/user.dart';
import '../../domain/usecases/user_login.dart';
import '../../domain/usecases/user_signup.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final UserLogout _userLogout;
  final UserCheckAuth _userCheckAuth;
  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogin userLogin,
      required UserLogout userLogOut,
      required UserCheckAuth userCheckAuth})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _userLogout = userLogOut,
        _userCheckAuth = userCheckAuth,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthLogout>(_onAuthLogout);
    on<AuthIsUserLoggedIn>(_onCheckUserAuth);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
        UserSignUpParams(email: event.email, password: event.password));
    res.fold((failure) => emit(AuthFailure(message: failure.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));
    res.fold((failure) => emit(AuthFailure(message: failure.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    final res = await _userLogout(true);
    res.fold((failure) => emit(AuthFailure(message: failure.message)),
        (b) => emit(AuthLoggedOut()));
  }

  void _onCheckUserAuth(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _userCheckAuth(true);
    res.fold((failure) => emit(AuthFailure(message: failure.message)), (res) {
      if (res != null || res == true) {
        emit(AuthLoggedIn());
      }
      if (res == null || res == false) {
        emit(AuthLoggedOut());
      }
    });
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) async {
    emit(AuthSuccess(user: user));
  }
}
