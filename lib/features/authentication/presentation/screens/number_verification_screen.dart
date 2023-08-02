import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:social_media/features/authentication/bloc/auth_bloc.dart';
import 'package:social_media/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:social_media/features/authentication/presentation/screens/otp_verify.dart';
import 'package:social_media/features/authentication/presentation/widgets/custombutton_widgets.dart';
import 'package:social_media/features/authentication/presentation/widgets/textfield_widget.dart';

class NumberVerifyScreen extends StatefulWidget {
  final String? code;
  const NumberVerifyScreen({Key? key, this.code}) : super(key: key);

  @override
  State<NumberVerifyScreen> createState() => _NumberVerifyScreenState();
}

class _NumberVerifyScreenState extends State<NumberVerifyScreen> {
  final phoneController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final AuthBloc authBloc = AuthBloc(AuthRepositoryImpl());
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Verify mobile number",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedFormField(
                    controller: phoneController,
                    onFieldSubmitted: (String? input) {
                      phoneValidate();
                    },
                    inputType: TextInputType.number,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter phone number";
                      } else if (val.isNotEmpty) {
                        bool mobileValid =
                            RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(val);
                        return mobileValid ? null : "Invalid mobile";
                      } else {
                        return null;
                      }
                    },
                    preffix: CountryCodePicker(
                      backgroundColor: Theme.of(context).cardColor.withOpacity(0.8),
                      barrierColor:Theme.of(context).cardColor.withOpacity(0.8) ,
                      showDropDownButton:true ,
                      showFlag: false,
                      onChanged: print,
                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      initialSelection: 'IT',
                      favorite: ["+39','FR${widget.code}"],
                      textStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                      // optional. Shows only country name and flag
                      showCountryOnly: false,
                      // optional. Shows only country name and flag when popup is closed.
                      showOnlyCountryWhenClosed: false,
                      // optional. aligns the flag and the Text left
                      alignLeft: false,
                    ),
                    hint: "contact",
                    suffix: const Icon(
                      Iconsax.call,
                      size: 20,
                    )),
                const Spacer(),
                BlocConsumer<AuthBloc, AuthState>(
                  bloc: authBloc,
                  listener: _listenToAuthStates,
                  builder: (context, state) {
                    return CustomButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(color: Colors.white,),
                              )
                            : const Text('Request code'),
                        onPressed: () {
                          phoneValidate();
                        });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future phoneValidate() async {
    if (_formkey.currentState!.validate()) {
      _verifyPhoneNumber(phoneController.text);
    }
  }

  void _verifyPhoneNumber(String input) {
    authBloc.add(SendOtpEvent(
        phoneNumber: PhoneNumber(
      isoCode: 'NG',
      nsn: '+234${phoneController.text}',
    )));
  }

  void _listenToAuthStates(BuildContext context, AuthState state) {
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

      log('Something went wrong');
    }

    if (state is OtpSentState) {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (index) => OtpVerificationScreen(
                verificationId: state.verificationId,
                resendToken: state.resendToken,
                number: state.number,
              )));
    }
  }
}
