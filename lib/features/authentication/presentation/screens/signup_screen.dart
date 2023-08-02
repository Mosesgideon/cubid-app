import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media/features/authentication/presentation/screens/login_screen.dart';
import 'package:social_media/features/authentication/presentation/screens/number_verification_screen.dart';
import 'package:social_media/features/authentication/presentation/widgets/custombutton_widgets.dart';
import 'package:social_media/features/authentication/presentation/widgets/textfield_widget.dart';
import 'package:social_media/features/home_screen/presentation/homeScreen.dart';
import 'package:social_media/features/video_tab/presentations/widgets/myuploads.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final namecontroller = TextEditingController();
  final gendercontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final comfirmpasswordcontroller = TextEditingController();
  final usernamepasswordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isobscured = false;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Expanded(
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                          const SizedBox(
                            height: 30,
                          ),

                          OutlinedFormField(
                            controller: namecontroller,
                            hint: 'name',
                            validator: (val) {
                              if (val!.isEmpty) return 'Please enter name';

                              return null;
                            },
                            preffix: const Icon(Iconsax.profile_add),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          OutlinedFormField(
                            controller: usernamepasswordcontroller,
                            hint: 'username',
                            validator: (val) {
                              if (val!.isEmpty) return 'Please enter username';
                              return null;
                            },
                            preffix: const Icon(Iconsax.profile_add),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          OutlinedFormField(
                            controller: gendercontroller,
                            hint: 'gender',
                            validator: (val) {
                              if (val!.isEmpty) return 'Please enter gender';
                              return null;
                            },
                            preffix: const Icon(Iconsax.profile_add),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          OutlinedFormField(
                              controller: emailcontroller,
                              hint: 'Email',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter email";
                                } else if (!emailcontroller.text
                                    .contains("@")) {
                                  return "Please enter valid email";
                                }
                                return null;
                              },
                              preffix: const Icon(
                                Iconsax.message,
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          OutlinedFormField(
                            controller: passwordcontroller,
                            hint: 'password',
                            obscure: isobscured,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  isobscured = !isobscured;
                                });
                              },
                              icon: Icon(
                                  isobscured ? Iconsax.eye_slash : Iconsax.eye),
                            ),
                            preffix: const Icon(Iconsax.lock),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          OutlinedFormField(
                            controller: comfirmpasswordcontroller,
                            hint: 'confirm Password',
                            validator: (val) {
                              if (val!.isEmpty)
                                return 'Please comfirm password';
                              if (val != passwordcontroller.text)
                                return 'Password missmatch';
                              return null;
                            },
                            obscure: isobscured,
                            suffix: IconButton(
                              onPressed: () {
                                isobscured = !isobscured;
                              },
                              icon: Icon(
                                  isobscured ? Iconsax.eye_slash : Iconsax.eye),
                            ),
                            preffix: const Icon(Iconsax.lock),
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      CupertinoPageRoute(
                                          builder: (index) =>
                                              const LoginScreen()));
                                },
                                child: Text(
                                  "already have an account?",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                )),
                          ),

                          const SizedBox(
                            height: 30,
                          ),

                          Center(
                            child: CustomButton(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              bgColor: Theme.of(context).colorScheme.primary,
                              child: isloading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text("SignUp"),
                              onPressed: () {
                                userSignUp();

                              },
                            ),
                          ),
                          // _OrSignIn()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future userSignUp() async {
    if (_formkey.currentState!.validate()) {
      // print(namecontroller);
      // print(passwordcontroller);
      // print(emailcontroller);
      // print(comfirmpasswordcontroller);
      try {
        if (passwordcontroller.text == comfirmpasswordcontroller.text) {
          setState(() {
            isloading = true;
          });
          final userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailcontroller.text.trim(),
                  password: passwordcontroller.text.trim());

          if (userCredential.user != null) {
            await registerUser(userCredential.user!);
          }

          setState(() {
            isloading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 1000),
              content: Text("SignUp Successful")));
          Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: (index) => NumberVerifyScreen()));
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isloading = false;
        });
        if (e.code == "email-already-in-use") {
          log(e.code);
          setState(() {
            isloading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 1000),
              content: Text(
                  " The email address is already in use by another account.")));
        } else if (e.code == "weak-too-password") {
          log(e.code);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 1000),
              content: Text("password too weak")));
        }
      } on FirebaseException catch (e) {
        log(e.toString());
        setState(() {
          isloading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(milliseconds: 1000),
            content: Text(
              e.code.toString(),
            )));
      }
    }
  }

  registerUser(User user) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Call the user's CollectionReference to add a new user
    return users.doc(user.uid).set({
      'id':user.uid,
      'name': namecontroller.text, // John Doe
      'gender': gendercontroller.text,
      'username': usernamepasswordcontroller.text, // Stokes and Sons
      'email': emailcontroller.text,
    });

    // .then((value) => ScaffoldMessenger.of(context)
    // .showSnackBar(const SnackBar(content: Text("signUp successful"))))
    // .catchError((error) => ScaffoldMessenger.of(context)
    // .showSnackBar(SnackBar(content: Text(error.toString()))));
  }
}
