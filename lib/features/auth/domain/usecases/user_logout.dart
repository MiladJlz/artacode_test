import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class UserLogout implements UseCase<bool, NoParams> {
  final AuthRepository authRepository;

  UserLogout({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(NoParams) async {
    return await authRepository.logOut();
  }
}
