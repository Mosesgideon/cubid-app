class AppError {
  String errorMessage;
  int? statusCode;
  String stackTrace;

  AppError({required this.errorMessage, this.statusCode, required this.stackTrace});
}
