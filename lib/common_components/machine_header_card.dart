import 'package:flutter/material.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';

class MachineHeaderCard extends StatelessWidget {
  final String name;
  final String model;

  const MachineHeaderCard({
    super.key,
    required this.name,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.settings, color: Colors.white, size: 40),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            model,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}