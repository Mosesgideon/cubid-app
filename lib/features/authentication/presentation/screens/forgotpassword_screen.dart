import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/features/authentication/presentation/screens/login_screen.dart';
import 'package:social_media/features/authentication/presentation/widgets/custombutton_widgets.dart';
import 'package:social_media/features/authentication/presentation/widgets/textfield_widget.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              Text(
                'Reset Password',
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              OutlinedFormField(
                  hint: 'Email',
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter an email";
                    } else if (!emailController.text.contains("@")) {
                      return "Please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                  preffix: const Icon(
                    Iconsax.message,
                  )),
              const Spacer(),
              CustomButton(
                onPressed: () {
                  // Navigator.of(context).push(CupertinoPageRoute(
                  //   builder: (context) =>
                  //       const PasswordVerificationScreen(),
                  // ));
                  resetPassword();
                },
                borderRadius: BorderRadius.circular(7),
                child: isloading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                    : const Text('Send code'),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);

        setState(() {
          isloading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(milliseconds: 1000),
            content: Text(
                "a password reset email address have been sent, check your inbox")));
        Navigator.of(context).pushReplacement(
            CupertinoPageRoute(builder: (index) => LoginScreen()));
      } on FirebaseAuthException catch (e) {
        setState(() {
          isloading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(milliseconds: 1000),
            content: Text(e.code)));
      }
    }
  }
}

// void resetPassword(BuildContext context) {
//   // Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (index)=>LoginScreen()));
// }
