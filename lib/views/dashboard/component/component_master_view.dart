

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/common_components/app_back_btn.dart';
import 'package:veloce_task_frontend/common_components/app_btn.dart';
import 'package:veloce_task_frontend/controllers/component_controller.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';
import 'package:veloce_task_frontend/core/utils/custom_loader.dart';
import 'package:veloce_task_frontend/data/models/component_model.dart';
import 'package:veloce_task_frontend/routes/app_routes.dart';

class ComponentMasterView extends StatefulWidget {
  const ComponentMasterView({super.key});

  @override
  State<ComponentMasterView> createState() => _ComponentMasterViewState();
}

class _ComponentMasterViewState extends State<ComponentMasterView> {
  final ComponentController controller = Get.put(ComponentController());

  // ================= PAGINATION =================
  int currentPage = 0;
  final int pageSize = 10;

  List<Component> get paginatedList {
    final list = controller.components;

    final start = currentPage * pageSize;
    if (start >= list.length) return [];

    final end = (start + pageSize > list.length)
        ? list.length
        : start + pageSize;

    return list.sublist(start, end);
  }

  bool get hasNext =>
      (currentPage + 1) * pageSize < controller.components.length;

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
      backgroundColor: AppColors.surface,

      // ================= APP BAR =================
      appBar: AppBar(
        title: const Text("Component Master"),
        leading: AppBackButton(
          onTap: () {
            Get.offAllNamed(AppRoutes.dashboard);
          },
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),

      // ================= FAB (UNCHANGED) =================
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Get.toNamed(AppRoutes.componentAdd);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      // ================= BODY =================
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CustomLoader());
        }

        if (controller.components.isEmpty) {
          return const Center(child: Text("No Components Found"));
        }

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // ================= LIST =================
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: paginatedList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),

                  itemBuilder: (context, index) {
                    final Component item = paginatedList[index];

                    return InkWell(
                      borderRadius: BorderRadius.circular(16),

                      onTap: () {
                        Get.toNamed(
                          AppRoutes.componentDetail,
                          arguments: item.id,
                        );
                      },

                      child: _componentCard(item),
                    );
                  },
                ),
              ),

              // ================= PAGINATION =================
              Row(
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
            ],
          ),
        );
      }),
    );
  }

  // ================= CARD UI (UNCHANGED) =================
  Widget _componentCard(Component item) {
    final name = item.componentName ?? "-";

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : "C",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text("Part No: ${item.partNo ?? '-'}"),
                  Text("ECN: ${item.ecn ?? '-'}"),

                  const SizedBox(height: 6),

                  Text(item.customer?.name ?? "No Customer"),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
