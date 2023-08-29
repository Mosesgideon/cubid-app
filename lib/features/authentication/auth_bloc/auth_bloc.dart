import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:social_media/common/models/app_error.dart';
import 'package:social_media/features/authentication/domain/repository/auth_repository.dart';
part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<VerificationCompleteEvent>((event, emit) =>
        emit(VerificationCompletedState(credential: event.credential)));

    on<OtpSentEvent>((event, emit) => emit(OtpSentState(
        number: event.number.nsn,
        resendToken: event.resendToken,
        verificationId: event.verificationId)));

    on<VerifyOtpFailedEvent>(
            (event, emit) => emit(VerificationFailedState(event.error)));

    on<SendSmsFailedEvent>((event, emit) => emit(SmsFailedState(event.error)));

    on<SendOtpEvent>(_mapSendOtpEventToState);
    on<VerifyOtpEvent>(_mapVerifyOtpEventToState);
  }

  FutureOr<void> _mapSendOtpEventToState(
      SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    try {
      await authRepository.verifyNumber(
          codeSent: (verificationId, resendToken) {
            add(OtpSentEvent(
                verificationId: verificationId,
                resendToken: resendToken.toString(),
                number: event.phoneNumber!));
          },
          phoneNumber: event.phoneNumber?.nsn,
          resendToken: event.resendToken,
          verificationFailed: (authException) {
            add(VerifyOtpFailedEvent(
                error: AppError(
                    errorMessage: authException.code,
                    stackTrace: authException.stackTrace.toString())));
          },
          verificationCompleted: (phoneAuthCredential) {
            add(VerificationCompleteEvent(credential: phoneAuthCredential));
          });
    } on Exception catch (e, stack) {
      emit(AuthFailureState(AppError(
          errorMessage: 'Something went wrong',
          stackTrace: '${e.toString()}${stack.toString()}')));
    }
  }

  FutureOr<void> _mapVerifyOtpEventToState(
      VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      var respose =
      await authRepository.verifyOtp(event.otp, event.verificationId);

      if (respose.error == null) {
        _signinUser(respose.response!);
      } else {
        log(respose.error!.stackTrace);

        emit(VerificationFailedState(respose.error!));
      }
    } on Exception catch (e, stack) {
      emit(VerificationFailedState(AppError(
          errorMessage: 'Something went wrong',
          stackTrace: '${e.toString()}${stack.toString()}')));
    }
  }

  void _signinUser(UserCredential response) {
       try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({'number': response.user?.phoneNumber!});
      emit(PhoneAuthSuccessState(response!.user));
    } on Exception catch (e) {
      emit(AuthFailureState(AppError(
          errorMessage: 'Something went wrong', stackTrace: e.toString())));
    }
  }
}
