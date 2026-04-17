import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/controllers/machine_controller.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';
import 'package:veloce_task_frontend/core/theme/app_textstyles.dart';
import 'package:veloce_task_frontend/core/utils/custom_loader.dart';
import 'package:veloce_task_frontend/views/dashboard/machine/machine_create_view.dart';
import 'package:veloce_task_frontend/views/dashboard/machine/machine_detail_view.dart';

class MachineMasterView extends StatelessWidget {
  MachineMasterView({super.key});

  final MachineController controller = Get.put(MachineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,

      appBar: AppBar(
        title: const Text("Machine Master"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const CustomLoader();
        }

        if (controller.machineList.isEmpty) {
          return Center(
            child: Text(
              "No Machines Found",
              style: AppTextStyles.subtitle(context),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // ================= HEADER =================
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Machine Name",
                        style: AppTextStyles.heading(context),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Serial",
                        style: AppTextStyles.heading(context),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Model",
                        style: AppTextStyles.heading(context),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ================= LIST =================
              Expanded(
                child: ListView.builder(
                  itemCount: controller.machineList.length,
                  itemBuilder: (context, index) {
                    final item = controller.machineList[index];

                    return _machineCard(context, item, index);
                  },
                ),
              ),
            ],
          ),
        );
      }),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () async {
          final result = await Get.to(() => const MachineCreateView());

          if (result != null) {
            controller.machineList.insert(0, result);
            controller.machineList.refresh();

            Get.snackbar(
              "Success",
              "Machine added successfully",
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // ================= CARD =================
  Widget _machineCard(BuildContext context, Map item, int index) {
    return InkWell(
      onTap: () {
        Get.to(() => MachineDetailView(machineId: item['_id']));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: index % 2 == 0
              ? AppColors.background
              : AppColors.primaryLight.withOpacity(0.4),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.grey.withOpacity(0.12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= MACHINE NAME (MULTILINE FIX) =================
            Expanded(
              flex: 4,
              child: Text(
                item['machineName'] ?? '-',
                maxLines: 2,
                softWrap: true,
                style: AppTextStyles.body(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            const SizedBox(width: 8),

            // ================= SERIAL =================
            Expanded(
              flex: 3,
              child: Text(
                item['serialNumber'] ?? '-',
                style: AppTextStyles.small(context),
              ),
            ),

            const SizedBox(width: 8),

            // ================= MODEL =================
            Expanded(
              flex: 2,
              child: Text(
                item['model'] ?? '-',
                style: AppTextStyles.body(context).copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
