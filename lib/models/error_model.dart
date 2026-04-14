class AppError implements Exception {
  final String status;
  final int statusCode;
  final String message;
  final dynamic error;
  final List<dynamic>? errors;

  AppError({
    required this.status,
    required this.statusCode,
    required this.message,
    this.error,
    this.errors,
  });
}
