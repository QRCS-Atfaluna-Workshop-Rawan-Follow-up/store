import 'package:fpdart/fpdart.dart';
import '../errors/exception.dart';
import '../errors/failure.dart';
class NetworkCallHandler {
  /// دالة عامة تستقبل أي Future وتقوم بهندلته
  static TaskEither<Failure, T> call<T>(Future<T> Function() action) {
    return TaskEither<Failure, T>.tryCatch(
          () async => await action(),
          (error, stackTrace) {
        // هنا تتم عملية الـ Mapping من Exception إلى Failure
        if (error is ServerException) {
          return ServerFailure(error.message);
        } else if (error is CacheException) {
          return ServerFailure(error.message); // أو تعريف CacheFailure
        } else {
          return const NetworkFailure("An unexpected network error occurred");
        }
      },
    );
  }
}