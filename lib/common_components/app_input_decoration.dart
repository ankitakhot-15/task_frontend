import 'package:flutter/material.dart';

InputDecoration appInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    filled: true,
    fillColor: Colors.grey.shade100,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  );
}