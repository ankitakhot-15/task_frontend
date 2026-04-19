
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:veloce_task_frontend/controllers/component_controller.dart';
// import 'package:veloce_task_frontend/core/theme/app_colors.dart';
// import 'package:veloce_task_frontend/core/utils/custom_loader.dart';
// import 'package:veloce_task_frontend/data/models/component_model.dart';
// import 'package:veloce_task_frontend/routes/app_routes.dart';

// class ComponentMasterView extends StatelessWidget {
//   ComponentMasterView({super.key});

//   final ComponentController controller = Get.find<ComponentController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.surface,

//       // ================= APP BAR =================
//       appBar: AppBar(
//         title: const Text("Component Master"),
//         centerTitle: true,
//         backgroundColor: AppColors.primary,
//       ),

//       // ================= BODY =================
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CustomLoader());
//         }

//         if (controller.components.isEmpty) {
//           return const Center(child: Text("No Components Found"));
//         }

//         return ListView.separated(
//           padding: const EdgeInsets.all(12),
//           itemCount: controller.components.length,
//           separatorBuilder: (_, __) => const SizedBox(height: 10),

//           itemBuilder: (context, index) {
//             final Component item = controller.components[index];

//             return InkWell(
//               borderRadius: BorderRadius.circular(16),

//               // ✅ PASS ONLY ID (SAFE + CLEAN)
//               onTap: () {
//                 Get.toNamed(AppRoutes.componentDetail, arguments: item.id);
//               },

//               child: _componentCard(item),
//             );
//           },
//         );
//       }),
//     );
//   }

//   // ================= CARD =================
//   Widget _componentCard(Component item) {
//     final name = item.componentName ?? "-";

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(14),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 26,
//               backgroundColor: AppColors.primary.withOpacity(0.1),
//               child: Text(
//                 name.isNotEmpty ? name[0].toUpperCase() : "C",
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.primary,
//                 ),
//               ),
//             ),

//             const SizedBox(width: 12),

//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     name,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   const SizedBox(height: 6),

//                   Text("Part No: ${item.partNo ?? '-'}"),
//                   Text("ECN: ${item.ecn ?? '-'}"),

//                   const SizedBox(height: 6),

//                   Text(item.customer?.name ?? "No Customer"),
//                 ],
//               ),
//             ),

//             const Icon(Icons.arrow_forward_ios, size: 16),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/controllers/component_controller.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';
import 'package:veloce_task_frontend/core/utils/custom_loader.dart';
import 'package:veloce_task_frontend/data/models/component_model.dart';
import 'package:veloce_task_frontend/routes/app_routes.dart';

class ComponentMasterView extends StatelessWidget {
  ComponentMasterView({super.key});

  final ComponentController controller = Get.find<ComponentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,

      // ================= APP BAR =================
      appBar: AppBar(
        title: const Text("Component Master"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),

      // ================= FAB =================
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          // 👉 OPEN ADD COMPONENT SCREEN
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

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: controller.components.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),

          itemBuilder: (context, index) {
            final Component item = controller.components[index];

            return InkWell(
              borderRadius: BorderRadius.circular(16),

              // ================= DETAIL NAVIGATION =================
              onTap: () {
                Get.toNamed(
                  AppRoutes.componentDetail,
                  arguments: item.id,
                );
              },

              child: _componentCard(item),
            );
          },
        );
      }),
    );
  }

  // ================= CARD UI =================
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