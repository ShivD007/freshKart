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

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.labelText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.isEnabled = true,
    this.onChanged, // Initialize onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      enabled: isEnabled,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
