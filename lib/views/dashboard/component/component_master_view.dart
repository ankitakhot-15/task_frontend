import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:veloce_task_frontend/controllers/component_controller.dart';
import 'package:veloce_task_frontend/core/utils/custom_loader.dart';

class ComponentMasterView extends StatelessWidget {
  final controller = Get.put(ComponentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Component Master")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const CustomLoader();
        }

        return ListView.builder(
          itemCount: controller.componentList.length,
          itemBuilder: (context, index) {
            final item = controller.componentList[index];

            return ListTile(
              title: Text(item['name'] ?? ''),
              onTap: () {
                // navigate to detail
              },
            );
          },
        );
      }),
    );
  }
}