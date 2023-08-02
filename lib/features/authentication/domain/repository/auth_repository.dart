import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/common/models/AppResponseModel.dart';


abstract class AuthRepository {

  Future<void>RegisterUser(String email, String password,String username,String gender);
  Future<void>LoginUser(String email, String password);







  Future<void> verifyNumber(
      {int? resendToken,
      String? phoneNumber,
      required void Function(String, int?) codeSent,
      required void Function(FirebaseAuthException) verificationFailed,
      required void Function(PhoneAuthCredential) verificationCompleted,
      Duration timeout = const Duration(seconds: 30)

      // required void Function(String) codeAutoRetrievalTimeout
      });

  Future<AppResponseModel<UserCredential>> verifyOtp(
      String otp, String verificationId);
}
