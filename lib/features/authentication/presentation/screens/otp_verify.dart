import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:social_media/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:social_media/features/authentication/presentation/screens/add_image.dart';
import 'package:social_media/features/authentication/presentation/widgets/custombutton_widgets.dart';

import '../../auth_bloc/auth_bloc.dart';
class OtpVerificationScreen extends StatefulWidget {
  final String verificationId;
  final String resendToken;
  final String number;


  const OtpVerificationScreen({
    Key? key,
    required this.verificationId,
    required this.resendToken,
    required this.number,
  }) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  // AuthController authController = Get.put(AuthController());
  final _controller = TextEditingController();
  final AuthBloc authBloc = AuthBloc(AuthRepositoryImpl());
  final AuthBloc resendBloc = AuthBloc(AuthRepositoryImpl());

  bool isLoading = false;
  bool isloading = false;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   authController.phoneAuth(widget.number);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        Text(
                          "Enter 6 digit number sent to ${widget.number} ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Pinput(
                          obscureText: true,
                          controller: _controller,
                          // validator: (val) {},
                          onCompleted: (pin) {
                            _verifyOtp(pin);

                            // authController.otpVerify(pin, context);
                          },
                          length: 6,
                          keyboardType: TextInputType.number,
                          obscuringWidget: Icon(
                            Icons.circle,
                            size: 13,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          textInputAction: TextInputAction.done,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: _listenToResendAuthState,
                  bloc: resendBloc,
                  builder: (context, state) {
                    return TextButton(
                        onPressed: () {},
                        child: isloading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(),
                              )
                            : Text(" Resend",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary,
                                )));
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: _listenToAuthState,
                bloc: authBloc,
                builder: (context, state) {
                  return CustomButton(
                    onPressed: () {},
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(color: Colors.white,))
                        : const Text('Verify'),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _verifyOtp(String pin) {
    authBloc
        .add(VerifyOtpEvent(otp: pin, verificationId: widget.verificationId));
  }

  void _listenToAuthState(BuildContext context, AuthState state) {
    if (state is AuthLoadingState) {
      setState(() {
        isLoading = true;
      });

      log('loading');
    }

    if (state is AuthFailureState) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 1000),
          content: Text("Something went wrong")));

      log('failed');
    }

    if (state is PhoneAuthSuccessState) {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (index) => const ProfilePicAdd()));

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 1000),
          content: Text("SignUp successful")));

      log('success');
    }
  }

  void _listenToResendAuthState(BuildContext context, AuthState state) {
    if (state is AuthLoadingState) {
      setState(() {
        isloading = true;
      });
    }

    if (state is AuthFailureState ||
        state is VerificationFailedState ||
        state is SmsFailedState) {
      setState(() {
        isloading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 1000),
          content: Text("Something went wrong")));

      log('Something went wrong');
    }

    if (state is OtpSentState) {
      setState(() {
        isloading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 1000),
          content: Text("OTP sent")));
    }
  }
}
