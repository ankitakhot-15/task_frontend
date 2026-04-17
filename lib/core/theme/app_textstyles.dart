import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Large title (screen title)
  static TextStyle title(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    );
  }

  // Subtitle
  static TextStyle subtitle(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyMedium!.copyWith(color: AppColors.textSecondary);
  }

  // Section heading
  static TextStyle heading(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    );
  }

  // Button text
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Body text
  static TextStyle body(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyLarge!.copyWith(color: AppColors.textPrimary);
  }

  // Small text
  static TextStyle small(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodySmall!.copyWith(color: AppColors.textSecondary);
  }
}
