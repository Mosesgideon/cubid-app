import 'dart:developer';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/common/models/AppResponseModel.dart';
import 'package:social_media/common/models/app_error.dart';
import 'package:social_media/features/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<void> verifyNumber(
      {int? resendToken,
      String? phoneNumber,
      required void Function(String vId, int? resendToken) codeSent,
      required void Function(FirebaseAuthException exception)
          verificationFailed,
      required void Function(PhoneAuthCredential credential)
          verificationCompleted,
      Duration timeout = const Duration(seconds: 30)}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeout,
        verificationCompleted: (PhoneAuthCredential credential) async {
          log('complete');
          verificationCompleted(credential);
        },
        forceResendingToken: resendToken,
        verificationFailed: (FirebaseAuthException error) {
          log('failed');
          verificationFailed(error);
        },
        codeSent: (String verificationID, int? resentTokenId) {
          log('code sent');
          codeSent(verificationID, resendToken);
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          log('Auto retrieval timeout');
        });
  }

  @override
  Future<AppResponseModel<UserCredential>> verifyOtp(
      String otp, String verificationId) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential);

      return AppResponseModel<UserCredential>(response: userCredential);
    } on Exception catch (e, stack) {
      return AppResponseModel<UserCredential>(
          response: null,
          error: AppError(
              errorMessage: 'Something went wrong',
              stackTrace: '${e.toString()}${stack.toString()}'));
    }
  }

  @override
  Future<void> LoginUser(String email, String password,) async {
    try {
      final response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(const SnackBar(
            duration: Duration(milliseconds: 1000),
            content: Text(
                "There is no user record corresponding to this identifier")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(const SnackBar(
            duration: Duration(milliseconds: 1000),
            content: Text(
                "incorrect password ")));
      }

    }
  }

  @override
  Future<void> RegisterUser(
      String email, String password, String username, String gender,) async {

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email,
          password: password);
    } on Exception catch (e) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar( SnackBar(
          duration: const Duration(milliseconds: 1000),
          content: Text(e.toString())));
    }



  }
}
