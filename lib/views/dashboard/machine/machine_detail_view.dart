import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/common_components/app_btn.dart';
import 'package:veloce_task_frontend/common_components/info_card.dart';
import 'package:veloce_task_frontend/common_components/info_row.dart';
import 'package:veloce_task_frontend/common_components/machine_header_card.dart';
import 'package:veloce_task_frontend/controllers/machine_detail_controller.dart';
import 'package:veloce_task_frontend/controllers/machine_controller.dart';
import 'package:veloce_task_frontend/core/utils/custom_loader.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';
import 'package:veloce_task_frontend/views/dashboard/machine/machine_edit_view.dart';

class MachineDetailView extends StatefulWidget {
  final String machineId;

  const MachineDetailView({super.key, required this.machineId});

  @override
  State<MachineDetailView> createState() => _MachineDetailViewState();
}

class _MachineDetailViewState extends State<MachineDetailView> {
  late final MachineDetailController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(MachineDetailController());

    controller.fetchMachineById(widget.machineId);
  }

  @override
  void dispose() {
    Get.delete<MachineDetailController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Machine Detail"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const CustomLoader();
        }

        final machine = controller.machine.value;

        if (machine == null) {
          return const Center(child: Text("No Data Found"));
        }

        final manufacturer = machine['manufacturerId'];
        final location = machine['locationId'];

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              MachineHeaderCard(
                name: machine['machineName'] ?? '-',
                model: machine['model'] ?? '-',
              ),

              const SizedBox(height: 20),

              InfoCard(
                children: [
                  InfoRow(
                    icon: Icons.confirmation_number,
                    label: "Serial",
                    value: machine['serialNumber'] ?? '-',
                  ),
                  InfoRow(
                    icon: Icons.memory,
                    label: "Model",
                    value: machine['model'] ?? '-',
                  ),
                  InfoRow(
                    icon: Icons.calendar_today,
                    label: "Year",
                    value: machine['year']?.toString() ?? '-',
                  ),
                ],
              ),

              const SizedBox(height: 15),

              InfoCard(
                children: [
                  InfoRow(
                    icon: Icons.factory,
                    label: "Manufacturer",
                    value: manufacturer != null
                        ? manufacturer['name']
                        : "Not Assigned",
                  ),
                  InfoRow(
                    icon: Icons.location_on,
                    label: "Location",
                    value: location != null ? location['name'] : "Not Assigned",
                  ),
                ],
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: "Edit",
                      icon: Icons.edit,
                      onPressed: () {
                        Get.to(() => MachineEditView(machine: machine));
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: AppButton(
                      text: "Delete",
                      icon: Icons.delete,
                      color: Colors.red,
                      onPressed: () async {
                        final confirm = await Get.dialog(
                          AlertDialog(
                            title: const Text("Delete Machine"),
                            content: const Text(
                              "Are you sure you want to delete this machine?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(result: false),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () => Get.back(result: true),
                                child: const Text("Delete"),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          final masterController =
                              Get.find<MachineController>();

                          await masterController.deleteMachine(machine['_id']);

                          Get.back(); // close detail page
                        }
                      },
                    ),

                    
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
