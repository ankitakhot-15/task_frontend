import 'package:flutter/material.dart';
import 'app_input_decoration.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboard;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboard = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        validator: (val) =>
            val == null || val.isEmpty ? "$label required" : null,
        decoration: appInputDecoration(label),
      ),
    );
  }
}