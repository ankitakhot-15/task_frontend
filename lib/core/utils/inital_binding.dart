import 'package:get/get.dart';
import 'package:veloce_task_frontend/controllers/component_controller.dart';
import 'package:veloce_task_frontend/controllers/machine_controller.dart';
import 'package:veloce_task_frontend/controllers/operation_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // ================= LAZY LOAD CONTROLLERS =================
    Get.lazyPut<OperationController>(() => OperationController());
    Get.lazyPut<MachineController>(() => MachineController());
    Get.lazyPut<ComponentController>(() => ComponentController());
  }
}