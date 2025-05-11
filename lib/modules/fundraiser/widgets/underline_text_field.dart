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

  final TextInputType? inputType;

  final void Function(String val) onChange;

  const UnderlineTextField({
    super.key,
    this.hintText = '',
    this.suffixText,
    this.readOnly = false,
    this.onTap,
    this.inputType,
    this.controller,
    required this.onChange,
    //
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: inputType ?? TextInputType.text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      onChanged: (e) => onChange(e),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey[500]),
        // the grey underline when unfocused
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!)),
        // the green underline when focused
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        // your “PKR” suffix (or anything you like)
        suffixText: suffixText,
        suffixStyle: const TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class MultilineTextArea extends StatelessWidget {
  /// Controller to read/write the text
  final TextEditingController controller;

  /// Placeholder when empty
  final String hintText;

  /// Label shown above the field
  final String label;

  /// Called when user taps the expand icon
  final VoidCallback? onExpand;

  final void Function(String val) onChange;

  const MultilineTextArea({
    super.key,
    required this.controller,
    this.hintText = '',
    this.label = '',
    this.onExpand,
    required this.onChange,
    //
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.grey.shade400;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) Text(label, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        Container(
          height: 160,
          decoration: BoxDecoration(border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(8)),
          child: Stack(
            children: [
              // the actual input
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  expands: true,
                  onChanged: (e) => onChange(e),
                  decoration: InputDecoration(hintText: hintText, hintStyle: TextStyle(color: Colors.grey.shade500), border: InputBorder.none),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              // expand icon
              if (onExpand != null)
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: GestureDetector(onTap: onExpand, child: Icon(Icons.open_in_full, size: 18, color: Colors.grey.shade600)),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
