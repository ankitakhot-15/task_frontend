
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/common_components/app_back_btn.dart';
import 'package:veloce_task_frontend/common_components/common_toast_message.dart';
import 'package:veloce_task_frontend/common_components/app_btn.dart';
import 'package:veloce_task_frontend/controllers/machine_controller.dart';
import 'package:veloce_task_frontend/core/theme/app_textstyles.dart';
import 'package:veloce_task_frontend/core/utils/custom_loader.dart';
import 'package:veloce_task_frontend/views/dashboard/machine/machine_create_view.dart';
import 'package:veloce_task_frontend/views/dashboard/machine/machine_detail_view.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';

class MachineMasterView extends StatefulWidget {
  const MachineMasterView({super.key});

  @override
  State<MachineMasterView> createState() => _MachineMasterViewState();
}

class _MachineMasterViewState extends State<MachineMasterView> {
  final MachineController controller = Get.put(MachineController());

  // ================= PAGINATION =================
  int currentPage = 0;
  final int pageSize = 10;

  List get paginatedList {
    final list = controller.machineList;

    final start = currentPage * pageSize;
    if (start >= list.length) return [];

    final end = (start + pageSize > list.length)
        ? list.length
        : start + pageSize;

    return list.sublist(start, end);
  }

  bool get hasNext =>
      (currentPage + 1) * pageSize < controller.machineList.length;

  bool get hasPrev => currentPage > 0;

  void nextPage() {
    if (hasNext) {
      setState(() => currentPage++);
    }
  }

  void prevPage() {
    if (hasPrev) {
      setState(() => currentPage--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ================= APP BAR (UNCHANGED) =================
      appBar: AppBar(
        title: const Text("Machine Master"),
        leading: AppBackButton(onTap: () => Get.offAllNamed("/dashboard")),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),

      backgroundColor: AppColors.background,

      // ================= BODY =================
      body: Obx(() {
        if (controller.isLoading.value) {
          return const CustomLoader();
        }

        if (controller.machineList.isEmpty) {
          return const Center(child: Text("No Machines Found"));
        }
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // HEADER
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Name",
                          style: AppTextStyles.heading(context),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Serial",
                          style: AppTextStyles.heading(context),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Model",
                          style: AppTextStyles.heading(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // LIST
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80), 
                  itemCount: paginatedList.length,
                  itemBuilder: (context, index) {
                    final item = paginatedList[index];

                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Get.to(() => MachineDetailView(machineId: item['_id']));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? AppColors.background
                              : AppColors.primary.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.grey.withOpacity(0.2),
                          ),
                        ),
                       
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  item['machineName'] ?? '-',
                                  style: AppTextStyles.body(context),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Center(
                                child: Text(
                                  item['serialNumber'] ?? '-',
                                  style: AppTextStyles.body(context),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Center(
                                child: Text(
                                  item['model'] ?? '-',
                                  style: AppTextStyles.body(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // PAGINATION (SAFE SPACE ABOVE FAB)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 70,
                ), // ✅ prevents overlap
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: "Prev",
                        icon: Icons.arrow_back,
                        isLoading: false,
                        onPressed: hasPrev ? prevPage : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text("Page ${currentPage + 1}"),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppButton(
                        text: "Next",
                        icon: Icons.arrow_forward,
                        isLoading: false,
                        onPressed: hasNext ? nextPage : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
   
      }),

      // ================= FAB (UNCHANGED) =================
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final result = await Get.to(() => const MachineCreateView());

          if (result != null) {
            controller.machineList.insert(0, result);
            controller.machineList.refresh();

            AppToast.success("Machine added to list");
          }
        },
      ),
    );
  }
}
