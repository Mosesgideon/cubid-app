import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinFieldForm extends StatefulWidget {
  const PinFieldForm(
      {Key? key,
        required this.controller,
        required this.length,
        this.validator,
        this.enabled = true})
      : super(key: key);
  final TextEditingController controller;
  final int length;
  final bool? enabled;
  final String? Function(String?)? validator;

  @override
  State<PinFieldForm> createState() => _PinFieldFormState();
}

class _PinFieldFormState extends State<PinFieldForm> {
  @override
  Widget build(BuildContext context) {
    // double deviceWidth = MediaQuery.of(context).size.width;
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
      ),
      length: widget.length,
      obscureText: true,
      obscuringCharacter: '*',
      enabled: widget.enabled ?? true,

      blinkWhenObscuring: false,
      animationType: AnimationType.fade,
      validator: widget.validator,
      mainAxisAlignment: MainAxisAlignment.center,

      errorTextMargin: const EdgeInsets.all(10),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: widget.length > 4 ? 50 : 60,
        fieldWidth: widget.length > 4 ? 50 : 60,
        // fieldHeight:deviceWidth>=400 ? 60:55,
        // fieldWidth: deviceWidth>=400 ? 60:deviceWidth<=360 ?48:50,
        // fieldWidth: widget.length == 6
        //     ? (deviceWidth * 0.15) - 10
        //     : (deviceWidth * 0.23) - 20,

        borderWidth: 0,
        fieldOuterPadding: const EdgeInsets.all(5),
        disabledColor: Theme.of(context).colorScheme.surface,
        selectedColor: Theme.of(context).colorScheme.surface,
        activeColor: Theme.of(context).colorScheme.surface,
        inactiveFillColor: Theme.of(context).colorScheme.surface,
        inactiveColor: Theme.of(context).colorScheme.surface,
        selectedFillColor: Theme.of(context).colorScheme.surface,
        activeFillColor: Theme.of(context).colorScheme.surface,
      ),
      cursorColor: Theme.of(context).colorScheme.onBackground,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,

      controller: widget.controller,
      keyboardType: TextInputType.number,

      onCompleted: (v) {
        debugPrint("Completed");
      },
      // onTap: () {
      //   print("Pressed");
      // },
      onChanged: (value) {
        debugPrint(value);
        setState(() {});
      },
      beforeTextPaste: (text) {
        debugPrint("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }
}