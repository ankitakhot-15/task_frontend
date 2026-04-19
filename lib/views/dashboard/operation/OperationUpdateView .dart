// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:veloce_task_frontend/common_components/app_btn.dart';
// import 'package:veloce_task_frontend/controllers/operation_controller.dart';
// import 'package:veloce_task_frontend/core/theme/app_colors.dart';
// import 'package:veloce_task_frontend/core/utils/custom_loader.dart';

// class OperationUpdateView extends StatefulWidget {
//   const OperationUpdateView({super.key});

//   @override
//   State<OperationUpdateView> createState() => _OperationUpdateViewState();
// }

// class _OperationUpdateViewState extends State<OperationUpdateView> {
//   final controller = Get.find<OperationController>();

//   final codeCtrl = TextEditingController();
//   final nameCtrl = TextEditingController();
//   final descCtrl = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _loadData();
//     });
//   }

// void _loadData() {
//   final op = Get.arguments;

//   if (op != null) {
//     codeCtrl.text = op.operationCode ?? "";
//     nameCtrl.text = op.operationName ?? "";
//     descCtrl.text = op.operationDescription ?? "";

//     // ✅ THESE ARE STRINGS, NOT OBJECTS
//     controller.selectedMachineId.value = op.machineId ?? "";
//     controller.selectedComponentId.value = op.componentId ?? "";

//     controller.isEditMode.value = true;
//     controller.editId.value = op.id ?? "";
//   }
// }

//   @override
//   void dispose() {
//     codeCtrl.dispose();
//     nameCtrl.dispose();
//     descCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.surface,

//       // ================= APP BAR =================
//       appBar: AppBar(
//         title: const Text("Update Operation"),
//         backgroundColor: AppColors.primary,
//         centerTitle: true,
//       ),

//       // ================= BODY =================
//       body:
//        Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CustomLoader());
//         }

//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               // ================= CODE =================
//               TextField(
//                 controller: codeCtrl,
//                 decoration: const InputDecoration(
//                   labelText: "Operation Code",
//                   border: OutlineInputBorder(),
//                 ),
//               ),

//               const SizedBox(height: 12),

//               // ================= NAME =================
//               TextField(
//                 controller: nameCtrl,
//                 decoration: const InputDecoration(
//                   labelText: "Operation Name",
//                   border: OutlineInputBorder(),
//                 ),
//               ),

//               const SizedBox(height: 12),

//               // ================= DESCRIPTION =================
//               TextField(
//                 controller: descCtrl,
//                 decoration: const InputDecoration(
//                   labelText: "Description",
//                   border: OutlineInputBorder(),
//                 ),
//               ),

//               const SizedBox(height: 12),

//               // ================= MACHINE DROPDOWN (ADDED) =================
//               DropdownButtonFormField<String>(
//                 value: controller.selectedMachineId.value.isEmpty
//                     ? null
//                     : controller.selectedMachineId.value,
//                 items: controller.machines.map((m) {
//                   return DropdownMenuItem(
//                     value: m.id,
//                     child: Text(m.machineName ?? "-"),
//                   );
//                 }).toList(),
//                 onChanged: (v) {
//                   controller.selectedMachineId.value = v ?? "";
//                 },
//                 decoration: const InputDecoration(
//                   labelText: "Select Machine",
//                   border: OutlineInputBorder(),
//                 ),
//               ),

//               const SizedBox(height: 12),

//               // ================= COMPONENT DROPDOWN (ADDED) =================
//               DropdownButtonFormField<String>(
//                 value: controller.selectedComponentId.value.isEmpty
//                     ? null
//                     : controller.selectedComponentId.value,
//                 items: controller.components.map((c) {
//                   return DropdownMenuItem(
//                     value: c.id,
//                     child: Text(c.componentName ?? "-"),
//                   );
//                 }).toList(),
//                 onChanged: (v) {
//                   controller.selectedComponentId.value = v ?? "";
//                 },
//                 decoration: const InputDecoration(
//                   labelText: "Select Component",
//                   border: OutlineInputBorder(),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // ================= SAVE BUTTON =================
//               AppButton(
//                 text: "Update Operation",
//                 isLoading: controller.isLoading.value,
//                 icon: Icons.update,
//                 onPressed: () async {
//                   await controller.saveOperation(
//                     code: codeCtrl.text.trim(),
//                     name: nameCtrl.text.trim(),
//                     description: descCtrl.text.trim(),
//                     type: 1,
//                   );

//                   Get.back();
//                 },
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/common_components/app_btn.dart';
import 'package:veloce_task_frontend/controllers/operation_controller.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';
import 'package:veloce_task_frontend/core/utils/custom_loader.dart';
import 'package:veloce_task_frontend/routes/app_routes.dart';

class OperationUpdateView extends StatefulWidget {
  const OperationUpdateView({super.key});

  @override
  State<OperationUpdateView> createState() => _OperationUpdateViewState();
}

class _OperationUpdateViewState extends State<OperationUpdateView> {
  final controller = Get.find<OperationController>();

  final codeCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    final op = Get.arguments;

    if (op != null) {
      codeCtrl.text = op.operationCode ?? "";
      nameCtrl.text = op.operationName ?? "";
      descCtrl.text = op.operationDescription ?? "";

      // ✅ FIXED: these are STRING IDs
      controller.selectedMachineId.value = op.machineId ?? "";
      controller.selectedComponentId.value = op.componentId ?? "";

      controller.isEditMode.value = true;
      controller.editId.value = op.id ?? "";
    }
  }

  Future<void> _updateOperation() async {
    await controller.saveOperation(
      code: codeCtrl.text.trim(),
      name: nameCtrl.text.trim(),
      description: descCtrl.text.trim(),
      type: 1,
    );

    // refresh list
    await controller.fetchAll();

    // go back
    Get.offAllNamed(AppRoutes.operation);
  }

  @override
  void dispose() {
    codeCtrl.dispose();
    nameCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,

      // ================= APP BAR =================
      appBar: AppBar(
        title: const Text("Update Operation"),
        backgroundColor: AppColors.primary,
        centerTitle: true,
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
              // ================= CODE =================
              TextField(
                controller: codeCtrl,
                decoration: const InputDecoration(
                  labelText: "Operation Code",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              // ================= NAME =================
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: "Operation Name",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              // ================= DESCRIPTION =================
              TextField(
                controller: descCtrl,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              // ================= MACHINE DROPDOWN =================
              Obx(() {
                return DropdownButtonFormField<String>(
                  value: controller.selectedMachineId.value.isEmpty
                      ? null
                      : controller.selectedMachineId.value,

                  items: controller.machines.map((m) {
                    return DropdownMenuItem(
                      value: m.id,
                      child: Text(m.machineName ?? "-"),
                    );
                  }).toList(),

                  onChanged: (v) {
                    controller.selectedMachineId.value = v ?? "";
                  },

                  decoration: const InputDecoration(
                    labelText: "Select Machine",
                    border: OutlineInputBorder(),
                  ),
                );
              }),

              const SizedBox(height: 12),

              // ================= COMPONENT DROPDOWN =================
              Obx(() {
                return DropdownButtonFormField<String>(
                  value: controller.selectedComponentId.value.isEmpty
                      ? null
                      : controller.selectedComponentId.value,

                  items: controller.components.map((c) {
                    return DropdownMenuItem(
                      value: c.id,
                      child: Text(c.componentName ?? "-"),
                    );
                  }).toList(),

                  onChanged: (v) {
                    controller.selectedComponentId.value = v ?? "";
                  },

                  decoration: const InputDecoration(
                    labelText: "Select Component",
                    border: OutlineInputBorder(),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // ================= UPDATE BUTTON =================
              AppButton(
                text: "Update Operation",
                isLoading: controller.isLoading.value,
                icon: Icons.update,
                onPressed: _updateOperation,
              ),
            ],
          ),
        );
      }),
    );
  }
}
