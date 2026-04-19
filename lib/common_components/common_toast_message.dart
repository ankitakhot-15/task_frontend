import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';

class AppToast {
  static void success(String message) {
    _showToast(
      message,
      background: AppColors.success,
      icon: Icons.check_circle,
    );
  }

  static void error(String message) {
    _showToast(
      message,
      background: AppColors.error,
      icon: Icons.error,
    );
  }

  static void warning(String message) {
    _showToast(
      message,
      background: AppColors.warning,
      icon: Icons.warning_amber_rounded,
    );
  }

 static void info(String title, String message) {
  _showToast(
    "$title: $message",
    background: AppColors.primary,
    icon: Icons.info,
  );
}

  static void _showToast(
    String message, {
    required Color background,
    required IconData icon,
  }) {
    // close previous toast (avoid stacking)
    Get.closeAllSnackbars();

    Get.snackbar(
      "",
      "",
      snackPosition: SnackPosition.TOP,
      backgroundColor: background,
      colorText: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
      isDismissible: true,
      icon: Icon(icon, color: Colors.white),

      // remove default title/message UI
      titleText: const SizedBox.shrink(),

      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),

      forwardAnimationCurve: Curves.easeOut,
      animationDuration: const Duration(milliseconds: 250),
    );
  }
}