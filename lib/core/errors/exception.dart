class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic error;

  ServerException({
    required this.message,
    this.statusCode,
    this.error,
  });

  @override
  String toString() {
    return "ServerException: $message | code: $statusCode";
  }
}
class CacheException implements Exception {
  final String message;

  CacheException({
    this.message = "Error in cache memory",
  });

  @override
  String toString() => "CacheException: $message";
}
class OfflineException implements Exception {
  final String message;

  OfflineException({
    this.message = "No internet connection",
  });

  @override
  String toString() => "OfflineException: $message";
}
class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException({
    this.message = "Denied access",
  });

  @override
  String toString() => "UnauthorizedException: $message";
}