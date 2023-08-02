import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/features/authentication/presentation/widgets/custombutton_widgets.dart';
import 'package:social_media/features/home_screen/presentation/homeScreen.dart';

class VerifyEmailScreen extends StatefulWidget {
  // final String email;

  const VerifyEmailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isverified = false;
  bool resendverified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isverified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isverified) {
      sendEmailVerification();
    }
  }

  @override
  void dispose() {
    super.dispose();

    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isverified
        ? const HomeScreen()
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              centerTitle: true,
              title: Text(
                'Verify Email',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const SizedBox(height: 40,),
                  const Text('Verification email have been sent'),
                  const SizedBox(height: 20,),
                  CustomButton(
                    isExpanded: false,
                      child:  const Row(
                        children: [Icon(Icons.email_outlined),
                          SizedBox(width: 10,),
                          Text('Resend Email'),
                        ],
                      ),
                      onPressed: () {
                        sendEmailVerification();
                      })
                ],
              ),
            ),
          );
  }

  void sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
      timer = Timer(Duration(seconds: 2), () => checkEmail());
      setState(() => resendverified = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => resendverified = true);
    } on Exception catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 1000),
          content: Text(e.toString())));
    }
  }

  checkEmail() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isverified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isverified) {
      timer!.cancel();
    }
  }
}
