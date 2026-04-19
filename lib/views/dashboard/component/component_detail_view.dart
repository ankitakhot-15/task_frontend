// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:veloce_task_frontend/controllers/component_controller.dart';
// import 'package:veloce_task_frontend/core/theme/app_colors.dart';
// import 'package:veloce_task_frontend/core/theme/app_textstyles.dart';
// import 'package:veloce_task_frontend/core/utils/custom_loader.dart';
// import 'package:veloce_task_frontend/routes/app_routes.dart';

// class ComponentDetailView extends StatelessWidget {
//   final String id;

//   ComponentDetailView({super.key, required this.id});

//   final controller = Get.find<ComponentController>();

//   @override
//   Widget build(BuildContext context) {
//     final item = controller.components.firstWhereOrNull((e) => e.id == id);

//     if (item == null) {
//       return const Scaffold(body: Center(child: Text("Component not found")));
//     }

//     return Scaffold(
//       backgroundColor: AppColors.surface,

//       // ================= APP BAR =================
//       appBar: AppBar(
//         title: const Text("Component Details"),
//         backgroundColor: AppColors.primary,
//         centerTitle: true,
//         actions: [
//           // DELETE
//           IconButton(
//             icon: const Icon(Icons.delete, color: Colors.white),
//             onPressed: () async {
//               await controller.deleteComponent(id);

//               // go back to master
//               Get.offAllNamed(AppRoutes.component);
//             },
//           ),
//         ],
//       ),

//       // ================= BODY =================
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // ================= CARD =================
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.06),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   _row("Component Name", item.componentName),
//                   _divider(),
//                   _row("Part No", item.partNo),
//                   _divider(),
//                   _row("ECN", item.ecn),
//                   _divider(),
//                   _row("Customer", item.customer?.name),
//                 ],
//               ),
//             ),

//             const Spacer(),

//             // ================= UPDATE BUTTON =================
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 icon: const Icon(Icons.edit, color: Colors.white),
//                 label: Text("Update Component", style: AppTextStyles.button),
//                 onPressed: () {
//                   Get.toNamed(AppRoutes.componentUpdate, arguments: item);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _row(String label, String? value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 120,
//             child: Text(
//               "$label:",
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(child: Text(value ?? "-")),
//         ],
//       ),
//     );
//   }

//   Widget _divider() {
//     return Divider(color: Colors.grey.withOpacity(0.3));
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';
import 'package:veloce_task_frontend/core/theme/app_textstyles.dart';
import 'package:veloce_task_frontend/routes/app_routes.dart';
import 'package:veloce_task_frontend/controllers/component_controller.dart';
import 'package:veloce_task_frontend/data/models/component_model.dart';

class ComponentDetailView extends StatelessWidget {
  final String id;

  ComponentDetailView({super.key, required this.id});

  final controller = Get.find<ComponentController>();

  @override
  Widget build(BuildContext context) {
    final Component? item =
        controller.components.firstWhereOrNull((e) => e.id == id);

    if (item == null) {
      return const Scaffold(
        body: Center(child: Text("Component not found")),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surface,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Component Details"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () async {
              await controller.deleteComponent(id);

              // go back to master
              Get.offAllNamed(AppRoutes.component);
            },
          ),
        ],
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= CARD =================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _row("Component Name", item.componentName),
                  _divider(),

                  _row("Part No", item.partNo),
                  _divider(),

                  _row("ECN", item.ecn),
                  _divider(),

                  _row("Customer", item.customer?.name),
                ],
              ),
            ),

            const Spacer(),

            // ================= EDIT BUTTON =================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.edit, color: Colors.white),
                label: Text("Edit Component", style: AppTextStyles.button),
                onPressed: () {
                  // send full object for autofill
                  Get.toNamed(
                    AppRoutes.componentUpdate,
                    arguments: item,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= ROW =================
  Widget _row(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              "$label:",
              style: AppTextStyles.heading(Get.context!),
            ),
          ),
          Expanded(
            child: Text(
              value ?? "-",
              style: AppTextStyles.body(Get.context!),
            ),
          ),
        ],
      ),
    );
  }

  // ================= DIVIDER =================
  Widget _divider() {
    return Divider(
      color: AppColors.grey.withOpacity(0.3),
      height: 18,
    );
  }
}