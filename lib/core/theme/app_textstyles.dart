import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle title(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!;

  static TextStyle subtitle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!;
}