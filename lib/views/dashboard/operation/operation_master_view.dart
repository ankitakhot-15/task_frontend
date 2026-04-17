import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/controllers/operation_controller.dart';
import 'package:veloce_task_frontend/core/utils/custom_loader.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';

class OperationMasterView extends StatelessWidget {
  OperationMasterView({super.key});

  final OperationController controller = Get.put(OperationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // 🔷 AppBar
      appBar: AppBar(
        title: const Text("Operation Master"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),

      // 🔷 Body
      body: Obx(() {
        if (controller.isLoading.value) {
          return const CustomLoader();
        }

        if (controller.operationList.isEmpty) {
          return const Center(child: Text("No Operations Found"));
        }

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // 🔷 Header
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
                          "Operation Name",
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

              // 🔷 List
              Expanded(
                child: ListView.builder(
                  itemCount: controller.operationList.length,
                  itemBuilder: (context, index) {
                    final item = controller.operationList[index];

                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        // 👉 Navigate to detail screen (later)
                        // Get.toNamed(AppRoutes.operationDetail, arguments: item['_id']);
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
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  item['name'] ?? '-',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  item['type']?.toString() ?? '-',
                                  style: TextStyle(
                                    color:
                                        AppColors.primary.withOpacity(0.8),
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
            ],
          ),
        );
      }),

      // 🔷 Floating Button (Add Operation)
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          // 👉 Open Add Operation Dialog / Screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}