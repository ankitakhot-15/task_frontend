import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/controllers/component_controller.dart';
import 'package:veloce_task_frontend/core/utils/custom_loader.dart';
import 'package:veloce_task_frontend/data/models/component_model.dart';

class ComponentMasterView extends StatelessWidget {
  ComponentMasterView({super.key});

  final ComponentController controller = Get.put(ComponentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Component Master")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const CustomLoader();
        }

        if (controller.components.isEmpty) {
          return const Center(child: Text("No Components Found"));
        }

        return ListView.builder(
          itemCount: controller.components.length,
          itemBuilder: (context, index) {
            final Component item = controller.components[index];

            return Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              child: ListTile(
                title: Text(item.componentName ?? '-'),
                subtitle: Text(
                  "Part No: ${item.partNo ?? '-'} | ECN: ${item.ecn ?? '-'}",
                ),
                trailing: Text(
                  item.customer?.name ?? 'No Customer',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Get.to(() => ComponentDetailView(component: item));
                },
              ),
            );
          },
        );
      }),
    );
  }
}