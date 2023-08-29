part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SendOtpEvent extends AuthEvent {
  final int? resendToken;
  final PhoneNumber? phoneNumber;


  const SendOtpEvent(
      {this.resendToken,
        this.phoneNumber,});

  @override
  List<Object?> get props => [resendToken, phoneNumber];
}

class SendSmsFailedEvent extends AuthEvent {
  final AppError error;

  const SendSmsFailedEvent({required this.error});

  @override
  List<Object> get props => [
    error,
  ];
}

class OtpSentEvent extends AuthEvent {
  final String verificationId;
  final String resendToken;
  final PhoneNumber number;

  const OtpSentEvent({
    required this.verificationId,
    required this.resendToken,
    required this.number,
  });

  @override
  List<Object> get props => [verificationId, resendToken];
}

class VerifyOtpFailedEvent extends AuthEvent {
  final AppError error;

  const VerifyOtpFailedEvent({required this.error});

  @override
  List<Object> get props => [
    error,
  ];
}

class VerificationCompleteEvent extends AuthEvent {
  final PhoneAuthCredential credential;

  const VerificationCompleteEvent({required this.credential});

  @override
  List<Object> get props => [
    credential,
  ];
}

class VerifyOtpEvent extends AuthEvent {
  final String otp;
  final String verificationId;


  const VerifyOtpEvent({required this.otp, required this.verificationId});



  @override
  List<Object> get props => [otp, verificationId];
}
