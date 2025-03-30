import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isEnabled;
  final Function(String)? onChanged; // New onChanged callback
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.labelText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.isEnabled = true,
    this.onChanged,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      enabled: isEnabled,
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          suffixIcon: suffixIcon),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
