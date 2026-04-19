import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/controllers/operation_controller.dart';
import 'package:veloce_task_frontend/routes/app_routes.dart';

class OperationDetailView extends StatelessWidget {
  final String id;

  OperationDetailView({super.key, required this.id});

  final controller = Get.find<OperationController>();

  @override
  Widget build(BuildContext context) {
    final op = controller.operations.firstWhereOrNull(
      (e) => e.id == id,
    );

    if (op == null) {
      return const Scaffold(
        body: Center(child: Text("Operation not found")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Operation Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await controller.deleteOperation(id);
              Get.back(); // back after delete
            },
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Code: ${op.operationCode ?? "-"}"),
            const SizedBox(height: 8),

            Text("Name: ${op.operationName ?? "-"}"),
            const SizedBox(height: 8),

            Text("Description: ${op.operationDescription ?? "-"}"),
            const SizedBox(height: 8),

            Text("Type: ${op.operationType ?? "-"}"),
            const SizedBox(height: 8),

            Text("Machine: ${op.machineId ?? "-"}"),
            const SizedBox(height: 8),

            Text("Component: ${op.componentId ?? "-"}"),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text("Edit Operation"),
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.operationForm,
                    arguments: id,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}