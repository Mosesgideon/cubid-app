part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PhoneAuthSuccessState extends AuthState {
  final dynamic userData;

  @override
  List<Object> get props => [userData];

  const PhoneAuthSuccessState(this.userData);
}

class AuthSuccessState extends AuthState{

  @override

  List<Object?> get props =>[];

}

class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class OtpSentState extends AuthState {
  final String verificationId;
  final String resendToken;
  final String number;

  const OtpSentState(
      {required this.number,
      required this.resendToken,
      required this.verificationId});

  @override
  List<Object?> get props => [];
}

class CodeAutoRetrievalTimeout extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class VerificationCompletedState extends AuthState {
  final PhoneAuthCredential credential;

  const VerificationCompletedState({required this.credential});

  @override
  List<Object?> get props => [credential];
}

class VerificationFailedState extends AuthState {
  final AppError error;

  const VerificationFailedState(this.error);

  @override
  List<Object?> get props => [error];
}

class SmsFailedState extends AuthState {
  final AppError error;

  const SmsFailedState(this.error);

  @override
  List<Object?> get props => [error];
}

class AuthFailureState extends AuthState {
  final AppError error;

  const AuthFailureState(this.error);

  @override
  List<Object?> get props => [error];
}
