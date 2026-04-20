
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/common_components/app_back_btn.dart';
import 'package:veloce_task_frontend/common_components/app_btn.dart';

import 'package:veloce_task_frontend/controllers/operation_controller.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';
import 'package:veloce_task_frontend/core/utils/custom_loader.dart';
import 'package:veloce_task_frontend/routes/app_routes.dart';

class OperationMasterView extends StatefulWidget {
  const OperationMasterView({super.key});

  @override
  State<OperationMasterView> createState() => _OperationMasterViewState();
}

class _OperationMasterViewState extends State<OperationMasterView> {
  final OperationController controller = Get.put(OperationController());

  // ================= PAGINATION =================
  int currentPage = 0;
  final int pageSize = 10;

  List get paginatedList {
    final list = controller.operations;

    final start = currentPage * pageSize;
    if (start >= list.length) return [];

    final end = (start + pageSize > list.length)
        ? list.length
        : start + pageSize;

    return list.sublist(start, end);
  }

  bool get hasNext =>
      (currentPage + 1) * pageSize < controller.operations.length;

  bool get hasPrev => currentPage > 0;

  void nextPage() {
    if (hasNext) setState(() => currentPage++);
  }

  void prevPage() {
    if (hasPrev) setState(() => currentPage--);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // ================= APP BAR =================
      appBar: AppBar(
        title: const Text("Operation Master"),
        // leading: AppBackButton(),
        leading: AppBackButton(
          onTap: () {
            Get.offAllNamed(AppRoutes.dashboard);
          },
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),

      // ================= BODY =================
      body: Obx(() {
        if (controller.isLoading.value) {
          return const CustomLoader();
        }

        if (controller.operations.isEmpty) {
          return const Center(child: Text("No Operations Found"));
        }

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // ================= HEADER =================
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Operation",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Machine",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Type",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ================= LIST (PAGINATED) =================
              Expanded(
                child: ListView.builder(
                  itemCount: paginatedList.length,
                  itemBuilder: (context, index) {
                    final item = paginatedList[index];

                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.operationDetail,
                          arguments: item.id,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: index.isEven
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
                                  item.operationName ?? "-",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Center(
                                child: Text(item.machineName ?? "-"),
                              ),
                            ),

                            Expanded(
                              child: Center(
                                child: Text(
                                  item.operationType?.toString() ?? "-",
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
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

              // ================= PAGINATION BUTTONS =================
              Padding(
                padding: const EdgeInsets.only(bottom: 70), // FAB safe space
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

                    Text(
                      "Page ${currentPage + 1}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

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

      // ================= FLOATING BUTTON =================
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          final ctrl = Get.find<OperationController>();
          ctrl.clearForm();
          Get.toNamed(AppRoutes.operationForm);
        },
        child: const Icon(Icons.add, color: AppColors.background),
      ),
    );
  }
}
