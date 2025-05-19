import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines,
    required this.onChanged,
  });
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hintText;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      maxLines: maxLines,
      onChanged: onChanged,
    );
  }
}
