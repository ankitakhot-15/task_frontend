import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/controllers/machine_detail_controller.dart';

class MachineDetailView extends StatelessWidget {
  final Map machine;

  MachineDetailView({super.key, required this.machine});

  final controller = Get.put(MachineDetailController());

  @override
  Widget build(BuildContext context) {
    final manufacturer = machine['manufacturerId'];

    // Pre-select existing value
    controller.selectedManufacturer.value = manufacturer != null
        ? manufacturer['_id']
        : null;

    return Scaffold(
      appBar: AppBar(title: const Text("Machine Detail")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Machine Name: ${machine['machineName']}"),

            const SizedBox(height: 20),

            Obx(
              () => DropdownButtonFormField<String>(
                value: controller.selectedManufacturer.value,

                items: controller.manufacturers.map((m) {
                  return DropdownMenuItem<String>(
                    value: m['_id'], // ✅ FIXED
                    child: Text(m['name']),
                  );
                }).toList(),

                onChanged: (value) {
                  controller.selectedManufacturer.value = value;
                },

                decoration: const InputDecoration(
                  labelText: "Select Manufacturer",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
