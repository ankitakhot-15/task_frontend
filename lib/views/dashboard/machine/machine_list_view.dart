import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/controllers/machine_controller.dart';
import 'package:veloce_task_frontend/views/dashboard/machine/machine_detail_view.dart';

class MachineListView extends StatelessWidget {
  final controller = Get.put(MachineController());

   MachineListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Machines")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.machines.length,
          itemBuilder: (context, index) {
            final m = controller.machines[index];

            return ListTile(
              title: Text(m.machineName),
              subtitle: Text(m.model),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Get.to(() => MachineDetailView(machine: m));
              },
            );
          },
        );
      }),
    );
  }
}