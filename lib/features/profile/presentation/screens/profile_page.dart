import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:social_media/app_constants/theme/app_colors.dart';
import 'package:social_media/app_utils/app_utils.dart';
import 'package:social_media/features/authentication/auth_bloc/auth_bloc.dart';
import 'package:social_media/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:social_media/features/authentication/presentation/screens/login_screen.dart';
import 'package:social_media/features/authentication/presentation/widgets/custombutton_widgets.dart';
import 'package:social_media/features/authentication/presentation/widgets/textfield_widget.dart';
import 'package:social_media/features/profile/presentation/widgets/bottomsheet.dart';
import 'package:social_media/features/profile/presentation/widgets/profile_picture_update.dart';
import 'package:social_media/features/profile/presentation/screens/edit_profile.dart';
import 'package:social_media/features/profile/presentation/widgets/profile_items.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isloading = false;
  bool noImage = false;
  final _formkey = GlobalKey<FormState>();
  final AuthBloc authBloc = AuthBloc(AuthRepositoryImpl());

  // AuthService authService=AuthService;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log( MediaQuery.viewInsetsOf(context).bottom.toString());
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text("oops,something went srong"));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child:
                                    Stack(clipBehavior: Clip.none, children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                    borderRadius: BorderRadius.circular(60)),
                                height: 120,
                                width: 120,
                                child: snapshot.data!.docs[index] != null
                                    ? ClipOval(
                                        child: Image.network(
                                            snapshot.data!.docs[index]
                                                .get("image"),
                                            fit: BoxFit.cover),
                                      )
                                    : const Icon(
                                        Iconsax.profile_add,
                                        size: 30,
                                      ),
                              ),
                              Positioned(
                                bottom: -8,
                                child: CircleAvatar(
                                    backgroundColor: darkGrey,
                                    child: IconButton(
                                      icon: const Icon(
                                        Iconsax.edit,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                builder: (index) =>
                                                    const ProfilePic()));
                                      },
                                    )),
                              )
                            ])),
                            const SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data!.docs[index].get("username"),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    snapshot.data!.docs[index].get("email"),
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            Center(
                              child: CustomButton(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                isExpanded: false,
                                child: const Text(
                                  "Edit profile",
                                  style: TextStyle(fontSize: 10),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (index) => const EditProfile()));
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ProfileItems(
                              text: snapshot.data!.docs[index].get("name"),
                              iconData: Iconsax.profile_add,
                              icons: SizedBox(),
                              voidCallback: () {},
                            ),
                            ProfileItems(
                              text: snapshot.data!.docs[index].get("email"),
                              iconData: Iconsax.message,
                              icons: SizedBox(),
                              voidCallback: () {},
                            ),
                            ProfileItems(
                              text: snapshot.data!.docs[index].get('number'),
                              iconData: Iconsax.call_add,
                              icons: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  child: const Icon(
                                    Iconsax.edit_2,
                                    color: Colors.white,
                                  )),
                              voidCallback: () {
                                AppUtils.showCustomModalBottomSheet(
                                    context,
                                    bgColor: Colors.transparent,
                                    Material(
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                topLeft: Radius.circular(20))),
                                        child: Form(
                                          key: _formkey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("Enter new number",
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground,
                                                  )),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:EdgeInsets.only(bottom:  MediaQuery.viewInsetsOf(context).bottom),
                                                child: OutlinedFormField(
                                                  controller: _controller,
                                                  hint: 'number',
                                                  preffix:
                                                  const Icon(Iconsax.call_add),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              BlocConsumer<AuthBloc, AuthState>(
                                                bloc: authBloc,
                                                listener: (context, state) {
                                                  if (authBloc
                                                      is AuthLoadingState) {
                                                    log("loading");
                                                    setState(() {
                                                      isloading = true;
                                                    });
                                                  } else if (authBloc
                                                          is AuthFailureState ||
                                                      state
                                                          is VerificationFailedState ||
                                                      state is SmsFailedState) {
                                                    log("error");
                                                    setState(() {
                                                      isloading = false;
                                                    });
                                                  }
                                                  if (state is OtpSentState) {
                                                    setState(() {
                                                      isloading = false;
                                                    });
                                                    Navigator.pop(context);
                                                    AppUtils
                                                        .showCustomModalBottomSheet(

                                                            context,
                                                            Bottomsheet(

                                                              verificationId: state
                                                                  .verificationId,
                                                              resendToken: state
                                                                  .resendToken,
                                                              number:
                                                                  state.number,
                                                            ));
                                                  }
                                                },
                                                builder: (context, state) {
                                                  return CustomButton(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 20),
                                                      child: isloading
                                                          ? const SizedBox(
                                                              height: 20,
                                                              width: 20,
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : const Text(
                                                              "Get Code"),
                                                      onPressed: () {
                                                        phoneValidate();
                                                      });
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                            ),
                            ProfileItems(
                              text:
                                  '${snapshot.data!.docs[index].get("gender")}(gender)',
                              iconData: Iconsax.code_circle,
                              icons: SizedBox(),
                              voidCallback: () {},
                            ),
                            ProfileItems(
                              text: 'country',
                              iconData: Iconsax.location,
                              icons: SizedBox(),
                              voidCallback: () {},
                            ),
                            ProfileItems(
                              text: 'logout',
                              iconData: Iconsax.logout,
                              color: Colors.red,
                              icons: SizedBox(),
                              voidCallback: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => AlertDialog(
                                          backgroundColor:
                                              Theme.of(context).cardColor,
                                          actions: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Do you wish to logout',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onBackground),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'No',
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .onBackground),
                                                            )),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              FirebaseAuth
                                                                  .instance
                                                                  .signOut()
                                                                  .whenComplete(() => ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(SnackBar(
                                                                          backgroundColor: Theme.of(context).colorScheme.onBackground,
                                                                          content: const Text(
                                                                            'sign out successful',
                                                                            style:
                                                                                TextStyle(color: Colors.green),
                                                                          ))));
                                                              Navigator.pushReplacement(
                                                                  context,
                                                                  CupertinoPageRoute(
                                                                      builder:
                                                                          (index) =>
                                                                              const LoginScreen()));
                                                            },
                                                            child: const Text(
                                                              'Yes',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ))
                                                      ])
                                                ],
                                              ),
                                            )
                                          ],
                                        ));
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "more activity",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                                  )),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }));
  }

  Future phoneValidate() async {
    if (_formkey.currentState!.validate()) {
      _verifyPhoneNumber(_controller.text);
    }
  }

  void _verifyPhoneNumber(String input) {
    authBloc.add(SendOtpEvent(
        phoneNumber: PhoneNumber(
      isoCode: 'NG',
      nsn: '+234${_controller.text}',
    )));
  }
}
