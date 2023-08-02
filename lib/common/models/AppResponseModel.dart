import 'package:social_media/common/models/app_error.dart';

class AppResponseModel<T> {
  AppError? error;
  T? response;

  AppResponseModel({this.error, required this.response});
}
