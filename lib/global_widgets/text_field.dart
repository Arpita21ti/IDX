import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;

  // Constructor with required fields and optional parameters
  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
    );
  }
}
