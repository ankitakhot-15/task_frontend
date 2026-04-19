import 'package:get/get.dart';
import 'package:veloce_task_frontend/controllers/component_controller.dart';
import 'package:veloce_task_frontend/controllers/machine_controller.dart';
import 'package:veloce_task_frontend/controllers/operation_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // ================= CORE CONTROLLERS =================
    Get.put(OperationController(), permanent: true);
    Get.put(MachineController(), permanent: true);
    Get.put(ComponentController(), permanent: true);
  }
}
