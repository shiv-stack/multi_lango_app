import 'package:dartz/dartz.dart';
import 'package:language_learning_app/core/error/failures.dart';

import 'package:language_learning_app/domain/entities/user.dart';
import 'package:language_learning_app/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call(String email, String password) async {
    try {
      final user = await repository.login(email, password);
      if (user == null) return Left(AuthFailure());
      return Right(user);
    } catch (e) {
      return Left(AuthFailure());
    }
  }
}
