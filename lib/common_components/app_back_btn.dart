import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBackButton extends StatelessWidget {
  final Color? color;
  final VoidCallback? onTap;

  const AppBackButton({
    super.key,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap ?? () => Get.back(),
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: color ?? Colors.white,
        size: 20,
      ),
    );
  }
}