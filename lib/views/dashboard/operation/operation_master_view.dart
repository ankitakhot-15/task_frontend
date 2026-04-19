import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:veloce_task_frontend/controllers/operation_controller.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';
import 'package:veloce_task_frontend/core/utils/custom_loader.dart';
import 'package:veloce_task_frontend/routes/app_routes.dart';

class OperationMasterView extends StatelessWidget {
  OperationMasterView({super.key});

  final OperationController controller = Get.find<OperationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // ================= APP BAR =================
      appBar: AppBar(
        title: const Text("Operation Master"),
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

              // ================= LIST =================
              Expanded(
                child: ListView.builder(
                  itemCount: controller.operations.length,
                  itemBuilder: (context, index) {
                    final item = controller.operations[index];

                    // return Container(
                    //   margin: const EdgeInsets.only(bottom: 10),
                    //   padding: const EdgeInsets.symmetric(
                    //     vertical: 14,
                    //     horizontal: 10,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: index.isEven
                    //         ? AppColors.background
                    //         : AppColors.primary.withOpacity(0.05),
                    //     borderRadius: BorderRadius.circular(12),
                    //     border: Border.all(
                    //       color: AppColors.grey.withOpacity(0.2),
                    //     ),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.black.withOpacity(0.05),
                    //         blurRadius: 6,
                    //       ),
                    //     ],
                    //   ),

                    //   child: Row(
                    //     children: [
                    //       // ================= OPERATION NAME =================
                    //       Expanded(
                    //         child: Center(
                    //           child: Text(
                    //             item.operationName ?? "-",
                    //             textAlign: TextAlign.center,
                    //             style: const TextStyle(
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //           ),
                    //         ),
                    //       ),

                    //       // ================= MACHINE NAME =================
                    //       Expanded(
                    //         child: Center(
                    //           child: Text(
                    //             item.machineId ?? "-",
                    //             textAlign: TextAlign.center,
                    //             style: const TextStyle(color: Colors.black87),
                    //           ),
                    //         ),
                    //       ),

                    //       // ================= TYPE =================
                    //       Expanded(
                    //         child: Center(
                    //           child: Text(
                    //             item.operationType?.toString() ?? "-",
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(
                    //               color: AppColors.primary,
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // );
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
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                            ),
                          ],
                        ),

                        child: Row(
                          children: [
                            // OPERATION NAME
                            Expanded(
                              child: Center(
                                child: Text(
                                  item.operationName ?? "-",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            // MACHINE (FIXED)
                            // Expanded(
                            //   child: Center(
                            //     child: Text(
                            //       item.machineId ?? "-",
                            //       textAlign: TextAlign.center,
                            //       style: const TextStyle(color: Colors.black87),
                            //     ),
                            //   ),
                            // ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  item.machineName ?? "-",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.black87),
                                ),
                              ),
                            ),

                            // TYPE
                            Expanded(
                              child: Center(
                                child: Text(
                                  item.operationType?.toString() ?? "-",
                                  textAlign: TextAlign.center,
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

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:veloce_task_frontend/controllers/operation_controller.dart';
// import 'package:veloce_task_frontend/core/theme/app_colors.dart';
// import 'package:veloce_task_frontend/core/utils/custom_loader.dart';
// import 'package:veloce_task_frontend/routes/app_routes.dart';

// class OperationMasterView extends StatelessWidget {
//   OperationMasterView({super.key});

//   final OperationController controller = Get.find<OperationController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,

//       // ================= APP BAR =================
//       appBar: AppBar(
//         title: const Text("Operation Master"),
//         centerTitle: true,
//         backgroundColor: AppColors.primary,
//       ),

//       // ================= BODY =================
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const CustomLoader();
//         }

//         if (controller.operations.isEmpty) {
//           return const Center(child: Text("No Operations Found"));
//         }

//         return Padding(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             children: [
//               // ================= HEADER =================
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 decoration: BoxDecoration(
//                   color: AppColors.primary.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Row(
//                   children: [
//                     Expanded(
//                       child: Center(
//                         child: Text(
//                           "Operation",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Center(
//                         child: Text(
//                           "Machine",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Center(
//                         child: Text(
//                           "Type",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 12),

//               // ================= LIST =================
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: controller.operations.length,
//                   itemBuilder: (context, index) {
//                     final item = controller.operations[index];

//                     return InkWell(
//                       onTap: () {
//                         // 👉 PASS FULL OBJECT FOR EDIT/DETAIL
//                         Get.toNamed(AppRoutes.operationForm, arguments: item);
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.only(bottom: 10),
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 14,
//                           horizontal: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           color: index.isEven
//                               ? AppColors.background
//                               : AppColors.primary.withOpacity(0.05),
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(
//                             color: AppColors.grey.withOpacity(0.2),
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.05),
//                               blurRadius: 6,
//                             ),
//                           ],
//                         ),

//                         child: Row(
//                           children: [
//                             // OPERATION NAME
//                             Expanded(
//                               child: Center(
//                                 child: Text(
//                                   item.operationName ?? "-",
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             // MACHINE (SAFE FIX)
//                             Expanded(
//                               child: Center(
//                                 child: Text(
//                                   item.machineId is Map
//                                       ? item.machineId ?? "-"
//                                       : item.machineId ?? "-",
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(color: Colors.black87),
//                                 ),
//                               ),
//                             ),

//                             // TYPE
//                             Expanded(
//                               child: Center(
//                                 child: Text(
//                                   item.operationType?.toString() ?? "-",
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),

//       // ================= FLOATING BUTTON =================
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: AppColors.primary,
//         onPressed: () {
//           final ctrl = Get.find<OperationController>();

//           ctrl.clearForm();

//           // 👉 OPEN FORM IN ADD MODE
//           Get.toNamed(AppRoutes.operationForm);
//         },
//         child: const Icon(Icons.add, color: AppColors.background),
//       ),
//     );
//   }
// }
