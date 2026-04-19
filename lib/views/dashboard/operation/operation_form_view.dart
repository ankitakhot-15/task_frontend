// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:veloce_task_frontend/controllers/operation_controller.dart';
// import 'package:veloce_task_frontend/core/utils/custom_loader.dart';

// class OperationFormView extends StatefulWidget {
//   final String? operationId;

//   const OperationFormView({super.key, this.operationId});

//   @override
//   State<OperationFormView> createState() => _OperationFormViewState();
// }

// class _OperationFormViewState extends State<OperationFormView> {
//   final controller = Get.find<OperationController>();

//   final codeCtrl = TextEditingController();
//   final nameCtrl = TextEditingController();
//   final descCtrl = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _initData();
//     });
//   }

//   // Future<void> _initData() async {
//   //   // reset old state
//   //   controller.clearForm();
//   //   codeCtrl.clear();
//   //   nameCtrl.clear();
//   //   descCtrl.clear();

//   //   // IMPORTANT: ensure master data already loaded from previous screen

//   //   if (widget.operationId != null) {
//   //     await controller.getOperationById(widget.operationId!);

//   //     final op = controller.operations.firstWhereOrNull(
//   //       (e) => e.id == widget.operationId,
//   //     );

//   //     if (op != null) {
//   //       codeCtrl.text = op.operationCode ?? "";
//   //       nameCtrl.text = op.operationName ?? "";
//   //       descCtrl.text = op.operationDescription ?? "";

//   //       controller.selectedMachineId.value = op.machineId ?? "";
//   //       controller.selectedComponentId.value = op.componentId ?? "";
//   //     }
//   //   }
//   // }
// Future<void> _initData() async {
//   controller.clearForm();

//   if (widget.operationId != null) {
//     final op = controller.operations.firstWhereOrNull(
//       (e) => e.id == widget.operationId,
//     );

//     if (op != null) {
//       codeCtrl.text = op.operationCode ?? "";
//       nameCtrl.text = op.operationName ?? "";
//       descCtrl.text = op.operationDescription ?? "";

//       controller.selectedMachineId.value = op.machineId ?? "";
//       controller.selectedComponentId.value = op.componentId ?? "";

//       controller.isEditMode.value = true;
//       controller.editId.value = op.id ?? "";
//     }
//   }
// }
//   @override
//   void dispose() {
//     controller.clearForm();

//     codeCtrl.dispose();
//     nameCtrl.dispose();
//     descCtrl.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Obx(
//           () => Text(
//             controller.isEditMode.value ? "Edit Operation" : "Add Operation",
//           ),
//         ),
//       ),

//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CustomLoader());
//         }

//         return Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               TextField(
//                 controller: codeCtrl,
//                 decoration: const InputDecoration(
//                   labelText: "Operation Code",
//                   border: OutlineInputBorder(),
//                 ),
//               ),

//               const SizedBox(height: 12),

//               TextField(
//                 controller: nameCtrl,
//                 decoration: const InputDecoration(
//                   labelText: "Operation Name",
//                   border: OutlineInputBorder(),
//                 ),
//               ),

//               const SizedBox(height: 12),

//               TextField(
//                 controller: descCtrl,
//                 decoration: const InputDecoration(
//                   labelText: "Description",
//                   border: OutlineInputBorder(),
//                 ),
//               ),

//               const SizedBox(height: 12),

//               // MACHINE
//               Obx(() {
//                 return DropdownButtonFormField<String>(
//                   value: controller.selectedMachineId.value.isEmpty
//                       ? null
//                       : controller.selectedMachineId.value,
//                   items: controller.machines.map((m) {
//                     return DropdownMenuItem(
//                       value: m.id,
//                       child: Text(m.machineName ?? "-"),
//                     );
//                   }).toList(),
//                   onChanged: (v) {
//                     controller.selectedMachineId.value = v ?? "";
//                   },
//                   decoration: const InputDecoration(
//                     labelText: "Select Machine",
//                     border: OutlineInputBorder(),
//                   ),
//                 );
//               }),

//               const SizedBox(height: 12),

//               // COMPONENT
//               Obx(() {
//                 return DropdownButtonFormField<String>(
//                   value: controller.selectedComponentId.value.isEmpty
//                       ? null
//                       : controller.selectedComponentId.value,
//                   items: controller.components.map((c) {
//                     return DropdownMenuItem(
//                       value: c.id,
//                       child: Text(c.componentName ?? "-"),
//                     );
//                   }).toList(),
//                   onChanged: (v) {
//                     controller.selectedComponentId.value = v ?? "";
//                   },
//                   decoration: const InputDecoration(
//                     labelText: "Select Component",
//                     border: OutlineInputBorder(),
//                   ),
//                 );
//               }),

//               const SizedBox(height: 20),

//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: controller.isLoading.value
//                       ? null
//                       : () async {
//                           await controller.saveOperation(
//                             code: codeCtrl.text.trim(),
//                             name: nameCtrl.text.trim(),
//                             description: descCtrl.text.trim(),
//                             type: 1,
//                           );
//                         },
//                   child: const Text("Save Operation"),
//                 ),
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
import 'package:veloce_task_frontend/controllers/operation_controller.dart';
import 'package:veloce_task_frontend/core/utils/custom_loader.dart';

class OperationFormView extends StatefulWidget {
  final String? operationId;

  const OperationFormView({super.key, this.operationId});

  @override
  State<OperationFormView> createState() => _OperationFormViewState();
}

class _OperationFormViewState extends State<OperationFormView> {
  final controller = Get.find<OperationController>();

  final codeCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  bool isInitDone = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initData();
    });
  }
Future<void> _initData() async {
  controller.clearForm();

  codeCtrl.clear();
  nameCtrl.clear();
  descCtrl.clear();

  final op = Get.arguments; // 👈 GET OBJECT DIRECTLY

  if (op != null) {
    codeCtrl.text = op.operationCode ?? "";
    nameCtrl.text = op.operationName ?? "";
    descCtrl.text = op.operationDescription ?? "";

    controller.selectedMachineId.value =
        op.machineId is String ? op.machineId : op.machineId?.id ?? "";

    controller.selectedComponentId.value =
        op.componentId is String ? op.componentId : op.componentId?.id ?? "";

    controller.isEditMode.value = true;
    controller.editId.value = op.id ?? "";
  } else {
    controller.isEditMode.value = false;
    controller.editId.value = "";
  }

  setState(() {
    isInitDone = true;
  });
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
    if (!isInitDone) {
      return const Scaffold(
        body: Center(child: CustomLoader()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.isEditMode.value ? "Edit Operation" : "Add Operation",
          ),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CustomLoader());
        }

        return Padding(
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

              // ================= MACHINE =================
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

              // ================= COMPONENT =================
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

              // ================= SAVE =================
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          await controller.saveOperation(
                            code: codeCtrl.text.trim(),
                            name: nameCtrl.text.trim(),
                            description: descCtrl.text.trim(),
                            type: 1,
                          );

                          // ✅ BACK AFTER SAVE
                          Get.back();
                        },
                  child: const Text("Save Operation"),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}