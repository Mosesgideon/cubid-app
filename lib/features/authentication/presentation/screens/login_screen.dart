import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/features/authentication/presentation/screens/forgotpassword_screen.dart';
import 'package:social_media/features/authentication/presentation/screens/signup_screen.dart';
import 'package:social_media/features/authentication/presentation/widgets/custombutton_widgets.dart';
import 'package:social_media/features/authentication/presentation/widgets/textfield_widget.dart';
import 'package:social_media/features/home_screen/presentation/homeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isloading = false;
  bool isobscured = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 25,
                                color:
                                Theme
                                    .of(context)
                                    .colorScheme
                                    .onBackground,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          OutlinedFormField(
                              hint: 'Email',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter email";
                                } else if (passwordController!.text
                                    .contains("@")) {
                                  return "Enter a valid email";
                                }
                                return null;
                              },
                              controller: emailController,
                              preffix: const Icon(
                                Iconsax.message,
                              )),
                          const SizedBox(
                            height: 16,
                          ),
                          OutlinedFormField(
                              hint: 'Password',
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter password";
                                }
                                return null;
                              },
                              controller: passwordController,
                              obscure: isobscured,
                              suffix: IconButton(
                                onPressed: () {
                                  isobscured = !isobscured;
                                },
                                icon: Icon(
                                    isobscured ? Iconsax.eye_slash : Iconsax
                                        .eye),
                              ),
                              preffix: const Icon(
                                Iconsax.lock,
                              )),
                          const SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          CupertinoPageRoute(
                                              builder: (index) =>
                                              const ForgetPassword()));
                                    },
                                    child: Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          CupertinoPageRoute(
                                              builder: (index) =>
                                              const SignUp()));
                                    },
                                    child: Text(
                                      'Don’t Have an Account ?',
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .onBackground),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: CustomButton(
                              padding: EdgeInsets.symmetric(vertical: 18),
                              bgColor: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                              child: isloading
                                  ? const SizedBox(
                                height: 20,width: 20,
                                    child: CircularProgressIndicator(
                                color: Colors.white,),
                                  )
                                  : const Text("Sign In"),
                              onPressed: () {
                                loginUser();
                                // Navigator.of(context).push(CupertinoPageRoute(
                                //     builder: (index) => NumberVerifyScreen()));
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  )))),
    );
  }

  Future loginUser() async {
    try {
      if (_formkey.currentState!.validate()) {
        setState(() {
          isloading=true;
        });
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        Navigator.of(context)
            .pushReplacement(CupertinoPageRoute(builder: (index) => const HomeScreen()))
            .onError((error, stackTrace) {
          setState(() {
            isloading = false;
          });
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isloading=false;
      });
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(milliseconds: 1000),
            content: Text(
                "There is no user record corresponding to this identifier")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(milliseconds: 1000),
            content: Text(
                "incorrect password ")));
      }
    }

  }
}
