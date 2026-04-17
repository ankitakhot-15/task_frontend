import 'package:flutter/material.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 10),

          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}