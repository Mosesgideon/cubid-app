import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:social_media/features/authentication/bloc/auth_bloc.dart';
import 'package:social_media/features/authentication/data/repository/auth_repository_impl.dart';

import '../../../authentication/presentation/widgets/custombutton_widgets.dart';

class Bottomsheet extends StatefulWidget {
  final String verificationId;
  final String resendToken;
  final String number;

  const Bottomsheet({
    Key? key,
    required this.verificationId,
    required this.resendToken,
    required this.number,
  }) : super(key: key);

  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  final _controller = TextEditingController();
  final AuthBloc authBloc = AuthBloc(AuthRepositoryImpl());
  final AuthBloc resendBloc = AuthBloc(AuthRepositoryImpl());

  bool isLoading = false;

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
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 1000),
          content: Text("phone number changed")));

      log('success');
    }
  }

  void _listenToResendAuthState(BuildContext context, AuthState state) {
    if (state is AuthLoadingState) {
      setState(() {
        isLoading = true;
      });
    }

    if (state is AuthFailureState ||
        state is VerificationFailedState ||
        state is SmsFailedState) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 1000),
          content: Text("Something went wrong")));

      log('Something went wrong');
    }

    if (state is OtpSentState) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 1000), content: Text("OTP sent")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 5,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text("An OTP will be sent to ",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              )),
          const SizedBox(
            height: 30,
          ),
          Pinput(
            obscureText: true,
            // controller: _controller,
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
          ),
          const SizedBox(
            height: 40,
          ),
          BlocConsumer<AuthBloc, AuthState>(
            listener: _listenToAuthState,
            builder: (context, state) {
              return CustomButton(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : const Text("Verify"),
                  onPressed: () {});
            },
          )
        ],
      ),
    );
  }
}
