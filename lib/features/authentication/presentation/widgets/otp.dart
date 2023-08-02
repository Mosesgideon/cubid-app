// import 'dart:js';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:social_media/features/home_screen/presentation/homeScreen.dart';
//
// Future<dynamic> verifyPhone(
//   String phone,
// ) async {
//   await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: phone,
//       verificationCompleted: verificationCompleted,
//       verificationFailed: verificationFailed,
//       codeSent: codeSent,
//       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
// }
//
// void verificationCompleted(
//   PhoneAuthCredential phoneAuthCredential,
// ) async {
//   await FirebaseAuth.instance
//       .signInWithCredential(phoneAuthCredential)
//       .then((value) async {
//     if (value.user != null) {
//       Navigator.of(context as BuildContext).pushReplacement(
//           CupertinoPageRoute(builder: (index) => const HomeScreen()));
//     }
//   });
// }
//
// void verificationFailed(FirebaseAuthException error) => SnackBar(
//         content: SnackBar(
//           content: Text(error.toString()),
//     ));
//
// void codeAutoRetrievalTimeout(String verificationId) async {}
//
// void codeSent(String verificationId, int? forceResendingToken) {
//   verificationId = verificationId;
// }

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:social_media/features/home_screen/presentation/homeScreen.dart';

class AuthController extends GetxController {
  String uid = '';
  var varId = '';
  int? resentToken;
  dynamic credentials;
  bool AuthChet = false;

  phoneAuth(String phone) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: const Duration(milliseconds: 700),
          verificationCompleted: (PhoneAuthCredential credential) async {
            log('complete');
            credentials = credential;
            await FirebaseAuth.instance.signInWithCredential(credential);
          },
          forceResendingToken: resentToken,
          verificationFailed: (FirebaseAuthException error) {
            log('failed');
            if (error.code == 'Invalid_Number') {
              debugPrint('invalid_phone_number');
            }
          },
          codeSent: (String verificationID, int? resentTokenId) {
            log('code sent');
            varId = verificationID;
            resentToken = resentTokenId;
          },
          codeAutoRetrievalTimeout: (String verificationID) {});
    } on Exception catch (e) {
      print(e.toString());
      log('failed');
      // TODO
    }
  }

  otpVerify(String otpnumber, BuildContext context) async {
    log('called');
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: varId, smsCode: otpnumber);
    Navigator.of(context)
        .pushReplacement(CupertinoPageRoute(builder: (index) => HomeScreen()));
    log('loggedin');
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
