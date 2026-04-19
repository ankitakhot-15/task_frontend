

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/controllers/operation_controller.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';
import 'package:veloce_task_frontend/core/theme/app_textstyles.dart';
import 'package:veloce_task_frontend/routes/app_routes.dart';

class OperationDetailView extends StatelessWidget {
  final String id;

  OperationDetailView({super.key, required this.id});

  final controller = Get.find<OperationController>();

  @override
  Widget build(BuildContext context) {
    final op = controller.operations.firstWhereOrNull((e) => e.id == id);

    if (op == null) {
      return const Scaffold(body: Center(child: Text("Operation not found")));
    }

    return Scaffold(
      backgroundColor: AppColors.surface,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Operation Details"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () async {
              await controller.deleteOperation(id);

              Get.offAllNamed(AppRoutes.operation);
            },
          ),
        ],
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= CARD =================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _row("Operation Name", op.operationName),
                  _divider(),

                  _row("Code", op.operationCode),
                  _divider(),

                  _row("Description", op.operationDescription),
                  _divider(),

                  _row("Type", op.operationType?.toString()),
                  _divider(),

                  _row("Machine", op.machineName),
                  _divider(),

                  _row("Component", op.componentName),
                ],
              ),
            ),

            const Spacer(),

            // ================= EDIT BUTTON =================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.edit, color: Colors.white),
                label: Text("Edit Operation", style: AppTextStyles.button),
                onPressed: () {
                  // ✔ PASS FULL OBJECT FOR AUTO FILL
                  Get.toNamed(AppRoutes.operationUpdate, arguments: op);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= ROW WIDGET =================
  Widget _row(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text("$label:", style: AppTextStyles.heading(Get.context!)),
          ),
          Expanded(
            child: Text(value ?? "-", style: AppTextStyles.body(Get.context!)),
          ),
        ],
      ),
    );
  }

  // ================= DIVIDER =================
  Widget _divider() {
    return Divider(color: AppColors.grey.withOpacity(0.3), height: 18);
  }
}
