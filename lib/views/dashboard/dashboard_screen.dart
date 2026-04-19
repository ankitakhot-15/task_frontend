import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';
import 'package:veloce_task_frontend/core/theme/app_textstyles.dart';
import 'package:veloce_task_frontend/views/dashboard/component/component_master_view.dart';
import 'package:veloce_task_frontend/views/dashboard/machine/machine_master_view.dart';
import 'package:veloce_task_frontend/views/dashboard/operation/operation_master_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildCard(
              title: "Machine",
              icon: Icons.precision_manufacturing,
              color: AppColors.primary,
              onTap: () => Get.to(() => MachineMasterView()),
            ),
            _buildCard(
              title: "Component",
              icon: Icons.widgets,
              color: AppColors.success,
              onTap: () => Get.to(() => ComponentMasterView()),
            ),
            _buildCard(
              title: "Operation",
              icon: Icons.settings,
              color: AppColors.warning,
              onTap: () => Get.to(() => OperationMasterView()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: AppTextStyles.heading(Get.context!).copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
