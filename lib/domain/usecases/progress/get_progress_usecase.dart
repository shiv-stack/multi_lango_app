import 'package:dartz/dartz.dart';
import 'package:language_learning_app/core/error/failures.dart';
import 'package:language_learning_app/domain/entities/progress.dart';
import 'package:language_learning_app/domain/repositories/progress_repository.dart';

class GetProgressUseCase {
  final ProgressRepository repository;

  GetProgressUseCase(this.repository);

  Future<Either<Failure, List<Progress>>> call() async {
    try {
      final progress = await repository.getProgress();
      return Right(progress);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
