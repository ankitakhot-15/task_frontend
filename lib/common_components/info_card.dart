import 'package:flutter/material.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';

class InfoCard extends StatelessWidget {
  final List<Widget> children;

  const InfoCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}