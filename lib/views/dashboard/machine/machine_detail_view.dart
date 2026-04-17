import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/controllers/machine_detail_controller.dart';

class MachineDetailView extends StatelessWidget {
  final String machineId;

  MachineDetailView({super.key, required this.machineId});

  final controller = Get.put(MachineDetailController());

  @override
  Widget build(BuildContext context) {
    controller.fetchMachineById(machineId); // 🔥 API call

    return Scaffold(
      appBar: AppBar(title: const Text("Machine Detail")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final machine = controller.machine.value;

        if (machine == null) {
          return const Center(child: Text("No Data Found"));
        }

        final manufacturer = machine['manufacturerId'];
        final location = machine['locationId'];

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Machine: ${machine['machineName']}"),
              Text("Serial: ${machine['serialNumber']}"),
              Text("Model: ${machine['model']}"),
              Text("Year: ${machine['year']}"),

              const SizedBox(height: 10),

              Text(
                "Manufacturer: ${manufacturer != null ? manufacturer['name'] : 'Not Assigned'}",
              ),

              Text(
                "Location: ${location != null ? location['name'] : 'Not Assigned'}",
              ),
            ],
          ),
        );
      }),
    );
  }
}