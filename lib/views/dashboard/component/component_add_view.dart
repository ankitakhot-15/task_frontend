import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/common_components/app_text_field.dart';
import 'package:veloce_task_frontend/common_components/common_toast_message.dart';
import 'package:veloce_task_frontend/controllers/component_controller.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';
import 'package:veloce_task_frontend/core/theme/app_textstyles.dart';
import 'package:veloce_task_frontend/core/utils/custom_loader.dart';
import 'package:veloce_task_frontend/common_components/app_btn.dart';

class ComponentAddView extends StatefulWidget {
  const ComponentAddView({super.key});

  @override
  State<ComponentAddView> createState() => _ComponentAddViewState();
}

class _ComponentAddViewState extends State<ComponentAddView> {
  final controller = Get.find<ComponentController>();

  final nameCtrl = TextEditingController();
  final partCtrl = TextEditingController();
  final ecnCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
        title: const Text("Add Component"),
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

          child: Form(
            key: formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= HEADER =================
                Text(
                  "Create New Component",
                  style: AppTextStyles.title(context),
                ),

                const SizedBox(height: 6),

                Text(
                  "Fill all required details below",
                  style: AppTextStyles.subtitle(context),
                ),

                const SizedBox(height: 20),

                // ================= CARD =================
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // ================= NAME =================
                      AppTextField(
                        controller: nameCtrl,
                        label: "Component Name",
                      ),

                      // ================= PART NO =================
                      AppTextField(controller: partCtrl, label: "Part Number"),

                      // ================= ECN =================
                      AppTextField(controller: ecnCtrl, label: "ECN"),

                      const SizedBox(height: 10),

                      // ================= CUSTOMER DROPDOWN =================
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            value:
                                (controller.selectedCustomerId.value ?? "")
                                    .isNotEmpty
                                ? controller.selectedCustomerId.value
                                : null,

                            decoration: const InputDecoration(
                              labelText: "Select Customer",
                              border: InputBorder.none,
                            ),

                            items: controller.customers.map((c) {
                              return DropdownMenuItem<String>(
                                value: c.id ?? "",
                                child: Text(c.name ?? "-"),
                              );
                            }).toList(),

                            onChanged: (val) {
                              controller.selectedCustomerId.value = val ?? "";
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // ================= SAVE BUTTON =================
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    text: "Save Component",
                    icon: Icons.save,
                    isLoading: controller.isLoading.value,
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;

                      if ((controller.selectedCustomerId.value ?? "").isEmpty) {
                        AppToast.error("Please select customer");
                        return;
                      }

                      await controller.addComponent(
                        name: nameCtrl.text.trim(),
                        partNo: partCtrl.text.trim(),
                        ecn: ecnCtrl.text.trim(),
                      );

                      Get.offAllNamed("/component");
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
