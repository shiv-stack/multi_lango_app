abstract class Failure {
  final String message;
  const Failure(this.message);
}

class AuthFailure extends Failure {
  const AuthFailure() : super('Authentication failed');
}

class CacheFailure extends Failure {
  const CacheFailure() : super('Cache failure');
}
