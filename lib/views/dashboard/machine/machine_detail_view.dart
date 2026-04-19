import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:veloce_task_frontend/common_components/app_btn.dart';
import 'package:veloce_task_frontend/common_components/info_row.dart';
import 'package:veloce_task_frontend/controllers/machine_controller.dart';
import 'package:veloce_task_frontend/controllers/machine_detail_controller.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';
import 'package:veloce_task_frontend/core/theme/app_textstyles.dart';
import 'package:veloce_task_frontend/core/utils/app_routes.dart';
import 'package:veloce_task_frontend/core/utils/custom_loader.dart';
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
      backgroundColor: AppColors.surface,

      appBar: AppBar(
        title: const Text("Machine Detail"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const CustomLoader();
        }

        final machine = controller.machine.value;

        if (machine == null) {
          return Center(
            child: Text(
              "No Data Found",
              style: AppTextStyles.subtitle(context),
            ),
          );
        }

        final manufacturer = machine['manufacturerId'];
        final location = machine['locationId'];

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ================= HEADER =================
              _headerCard(machine),

              const SizedBox(height: 18),

              /// ================= MACHINE DETAILS =================
              _sectionTitle(context, "Machine Details"),

              const SizedBox(height: 10),

              _card([
                InfoRow(
                  label: "Serial Number",
                  value: machine['serialNumber'] ?? '-',
                ),
                InfoRow(label: "Model", value: machine['model'] ?? '-'),
                InfoRow(
                  label: "Year",
                  value: machine['year']?.toString() ?? '-',
                ),
              ]),

              const SizedBox(height: 16),

              /// ================= ASSIGNMENT =================
              _sectionTitle(context, "Assignment"),

              const SizedBox(height: 10),

              _card([
                InfoRow(
                  label: "Manufacturer",
                  value: manufacturer != null
                      ? manufacturer['name']
                      : "Not Assigned",
                ),
                InfoRow(
                  label: "Location",
                  value: location != null ? location['name'] : "Not Assigned",
                ),
              ]),

              const SizedBox(height: 24),

              /// ================= ACTION BUTTONS =================
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: "Edit",
                      // onPressed: () {
                      //   Get.to(() => MachineEditView(machine: machine));
                      // },
                      onPressed: () async {
                        final result = await Get.to(
                          () => MachineEditView(machine: machine),
                        );

                        if (result != null) {
                          controller.machine.value =
                              result; // 🔥 instant update
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: AppButton(
                      text: "Delete",
                      color: AppColors.error,
                      onPressed: () async {
                        final confirm = await Get.dialog(
                          AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            title: const Text("Delete Machine"),
                            content: const Text(
                              "This action cannot be undone.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(result: false),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () => Get.back(result: true),
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          final controller = Get.find<MachineController>();

                          final success = await controller.deleteMachine(
                            machine['_id'],
                          );

                          if (success) {
                            Get.snackbar(
                              "Success",
                              "Machine deleted successfully",
                              snackPosition: SnackPosition.BOTTOM,
                            );

                            Get.offAllNamed(AppRoutes.machine);
                          }
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

  // ================= HEADER CARD =================
  Widget _headerCard(Map machine) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            machine['machineName'] ?? '-',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Model: ${machine['model'] ?? '-'}",
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ================= SECTION TITLE =================
  Widget _sectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: AppTextStyles.heading(context).copyWith(fontSize: 16),
    );
  }

  // ================= CARD =================
  Widget _card(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.grey.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}
