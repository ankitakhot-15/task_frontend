import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/controllers/machine_controller.dart';
import 'package:veloce_task_frontend/views/dashboard/machine/machine_detail_view.dart';

class MachineMasterView extends StatelessWidget {
  final controller = Get.put(MachineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Machine Master")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.machineList.length,
          itemBuilder: (context, index) {
            final item = controller.machineList[index];

            return Card(
              child: ListTile(
                title: Text(item['machineName'] ?? ''),
                subtitle: Text(item['serialNumber'] ?? ''),
                trailing: Text(item['model'] ?? ''),

                onTap: () {
                  Get.to(() => MachineDetailView(machineId: item['_id']));
                },
              ),
            );
          },
        );
      }),
    );
  }
}
