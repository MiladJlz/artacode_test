import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class UserCheckAuth implements UseCase<bool?, NoParams> {
  final AuthRepository authRepository;

  UserCheckAuth({required this.authRepository});

  @override
  Future<Either<Failure, bool?>> call(NoParams) async {
    return await authRepository.checkUserAuth();
  }
}
