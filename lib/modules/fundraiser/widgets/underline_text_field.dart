import 'package:flutter/material.dart';

class UnderlineTextField extends StatelessWidget {
  /// Hint text shown when the field is empty.
  final String hintText;

  /// Optional trailing text (e.g. “PKR”).
  final String? suffixText;

  /// If true, the field is read-only (e.g. your category selector).
  final bool readOnly;

  /// Called when the field is tapped (useful for opening a dropdown).
  final VoidCallback? onTap;

  /// Controller for reading / writing the field’s value.
  final TextEditingController? controller;

  const UnderlineTextField({
    super.key,
    this.hintText = '',
    this.suffixText,
    this.readOnly = false,
    this.onTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: TextInputType.number,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.grey[500],
        ),
        // the grey underline when unfocused
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        // the green underline when focused
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        // your “PKR” suffix (or anything you like)
        suffixText: suffixText,
        suffixStyle: const TextStyle(
          color: Colors.green,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
