
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/common_components/common_toast_message.dart';
import 'package:veloce_task_frontend/controllers/component_controller.dart';
import 'package:veloce_task_frontend/core/utils/custom_loader.dart';
import 'package:veloce_task_frontend/common_components/app_btn.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';

class ComponentUpdateView extends StatefulWidget {
  const ComponentUpdateView({super.key});

  @override
  State<ComponentUpdateView> createState() => _ComponentUpdateViewState();
}

class _ComponentUpdateViewState extends State<ComponentUpdateView> {
  final controller = Get.find<ComponentController>();

  final nameCtrl = TextEditingController();
  final partCtrl = TextEditingController();
  final ecnCtrl = TextEditingController();

  String id = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    final item = Get.arguments;

    if (item == null) return;

    id = item.id ?? "";

    nameCtrl.text = item.componentName ?? "";
    partCtrl.text = item.partNo ?? "";
    ecnCtrl.text = item.ecn ?? "";

    controller.selectedCustomerId.value = item.customer?.id ?? "";
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    partCtrl.dispose();
    ecnCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,

      // ================= APP BAR =================
      appBar: AppBar(
        title: const Text("Update Component"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),

      // ================= BODY =================
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CustomLoader());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // ================= NAME =================
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: "Component Name",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              // ================= PART NO =================
              TextField(
                controller: partCtrl,
                decoration: const InputDecoration(
                  labelText: "Part No",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              // ================= ECN =================
              TextField(
                controller: ecnCtrl,
                decoration: const InputDecoration(
                  labelText: "ECN",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              // ================= CUSTOMER DROPDOWN =================
              Obx(() {
                final selectedId = controller.selectedCustomerId.value ?? "";

                final isValid =
                    selectedId.isNotEmpty &&
                    controller.customers.any((c) => c.id == selectedId);

                return DropdownButtonFormField<String>(
                  value: isValid ? selectedId : null,

                  isExpanded: true,

                  items: controller.customers.map((c) {
                    final cid = c.id ?? "";

                    return DropdownMenuItem<String>(
                      value: cid.isEmpty ? null : cid,
                      child: Text(c.name ?? "-"),
                    );
                  }).toList(),

                  onChanged: (v) {
                    controller.selectedCustomerId.value = v ?? "";
                  },

                  decoration: const InputDecoration(
                    labelText: "Customer",
                    border: OutlineInputBorder(),
                  ),
                );
              }),

              const SizedBox(height: 25),

              // ================= UPDATE BUTTON =================
              AppButton(
                text: "Update Component",
                icon: Icons.update,
                isLoading: controller.isLoading.value,
                onPressed: () async {
                  if (id.isEmpty) {
                    AppToast.error("Invalid component ID");
                    return;
                  }

                  await controller.updateComponent(id, {
                    "componentName": nameCtrl.text.trim(),
                    "partNo": partCtrl.text.trim(),
                    "ecn": ecnCtrl.text.trim(),
                    "customerId": controller.selectedCustomerId.value ?? "",
                  });

                  // BACK TO MASTER
                  Get.offAllNamed("/component");
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
