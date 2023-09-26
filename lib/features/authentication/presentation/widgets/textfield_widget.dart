import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media/app_constants/theme/app_colors.dart';

class FilledTextField extends StatefulWidget {
  final String hint;
  final Widget? suffix;
  final Widget? preffix;
  final int? maxLine;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final bool? enabled;
  final String? Function(String?)? onFieldSubmitted;
  final bool? obscured;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final String? Function(String?)? validator;

  final String? Function(String?)? onChanged;

  const FilledTextField(
      {Key? key,
      required this.hint,
      this.suffix,
      this.validator,
      this.preffix,
      this.maxLine,
      this.inputType,
      this.controller,
      this.onChanged,
      this.enabled,
      this.contentPadding,
      this.textInputAction,
      this.obscured = false,
      this.fillColor,
      required this.onFieldSubmitted})
      : super(key: key);

  @override
  State<FilledTextField> createState() => _FilledTextFieldState();
}

class _FilledTextFieldState extends State<FilledTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: widget.validator,
        controller: widget.controller,
        maxLines: widget.maxLine ?? 1,
        keyboardType: widget.inputType,
        cursorColor: Theme.of(context).colorScheme.onBackground,
        onChanged: widget.onChanged,
        obscureText: widget.obscured!,

        textInputAction: widget.textInputAction,
        style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground, fontSize: 13),
        decoration: InputDecoration(
            fillColor:
                widget.fillColor ?? Theme.of(context).colorScheme.surface,
            hintText: widget.hint,
            suffixIcon: widget.suffix,
            prefixIcon: widget.preffix,
            prefixIconColor: Colors.grey,
            suffixIconColor: Theme.of(context).colorScheme.primary,
            enabled: widget.enabled!,
            contentPadding: widget.contentPadding ?? const EdgeInsets.all(18),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
      ),
    );
  }
}

class OutlinedFormField extends StatefulWidget {
  const OutlinedFormField(
      {Key? key,
      required this.hint,
      this.suffix,
      this.validator,
      this.preffix,
      this.maxLine,
      this.inputType,
      this.obscure,
      this.controller,
      this.onChange,
      this.onFieldSubmitted,
      this.enabled,
      this.inputFormatters,  this.initialValue})
      : super(key: key);
  final String hint;
  final bool? obscure;
  final String? initialValue;
  final Widget? suffix;
  final Widget? preffix;
  final int? maxLine;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final Function(String d)? onChange;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<OutlinedFormField> createState() => _OutlinedFormFieldState();
}

class _OutlinedFormFieldState extends State<OutlinedFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(

        controller: widget.controller,
        validator: widget.validator,
        maxLines: widget.maxLine ?? 1,
        initialValue: widget.initialValue,
        onChanged: widget.onChange,
        keyboardType: widget.inputType,
        onFieldSubmitted: widget.onFieldSubmitted,
        inputFormatters: widget.inputFormatters,
        obscureText: widget.obscure == null ? false : widget.obscure!,
        style:  TextStyle(color: Theme.of(context).colorScheme.onBackground),
        decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
                gapPadding: 2,
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            fillColor: textcolor.withOpacity(0.2),
            hintText: widget.hint,
            suffixIcon: widget.suffix,
            prefixIcon: widget.preffix,
            iconColor: Colors.grey,
            enabled: widget.enabled ?? true,
            prefixIconColor: Colors.grey,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            suffixIconColor: Theme.of(context).colorScheme.primary,
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
      ),
    );
  }
}
