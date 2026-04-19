// import 'package:get/get.dart';
// import '../core/api/api_service.dart';
// import '../core/api/api_endpoints.dart';

// import '../data/models/operation_model.dart';
// import '../data/models/machine_model.dart';
// import '../data/models/component_model.dart';

// class OperationController extends GetxController {
//   final ApiService api = ApiService();

//   var isLoading = false.obs;

//   var operations = <Operation>[].obs;
//   var machines = <Machine>[].obs;
//   var components = <Component>[].obs;
//   var selectedMachineId = "".obs;
//   var selectedComponentId = "".obs;

//   @override
//   void onInit() {
//     fetchAll();
//     super.onInit();
//   }

//   // ================= FETCH ALL =================
//   Future<void> fetchAll() async {
//     try {
//       isLoading(true);

//       final opRes = await api.get(ApiEndpoints.operations);
//       final machineRes = await api.get(ApiEndpoints.machines);
//       final compRes = await api.get(ApiEndpoints.components);

//       operations.value = OperationModel.fromJson(opRes).data ?? [];

//       machines.value = MachineModel.fromJson(machineRes).data ?? [];

//       components.value = ComponentModel.fromJson(compRes).data ?? [];
//     } catch (e) {
//       Get.snackbar("Error", "Failed to load data");
//     } finally {
//       isLoading(false);
//     }
//   }

//   // ================= ADD OPERATION =================
//   Future<void> addOperation({
//     required String code,
//     required String name,
//     required String description,
//     required int type,
//   }) async {
//     try {
//       isLoading(true);

//       final body = {
//         "operationCode": code,
//         "operationName": name,
//         "operationDescription": description,
//         "operationType": type,
//         "machineId": selectedMachineId.value,
//         "componentId": selectedComponentId.value,
//       };

//       await api.post(ApiEndpoints.operations, body);

//       await fetchAll();

//       Get.snackbar("Success", "Operation created");
//     } catch (e) {
//       Get.snackbar("Error", "Failed to create operation");
//     } finally {
//       isLoading(false);
//     }
//   }

//   // ================= DELETE =================
//   Future<void> deleteOperation(String id) async {
//     try {
//       isLoading(true);

//       await api.delete("${ApiEndpoints.operations}/$id");

//       operations.removeWhere((o) => o.id == id);

//       Get.snackbar("Success", "Deleted");
//     } catch (e) {
//       Get.snackbar("Error", "Delete failed");
//     } finally {
//       isLoading(false);
//     }
//   }
// }
import 'package:get/get.dart';
import '../core/api/api_service.dart';
import '../core/api/api_endpoints.dart';

import '../data/models/operation_model.dart';
import '../data/models/machine_model.dart';
import '../data/models/component_model.dart';

class OperationController extends GetxController {
  final ApiService api = ApiService();

  var isLoading = false.obs;

  var operations = <Operation>[].obs;
  var machines = <Machine>[].obs;
  var components = <Component>[].obs;

  var selectedMachineId = "".obs;
  var selectedComponentId = "".obs;

  var isEditMode = false.obs;
  var editId = "".obs;

  @override
  void onInit() {
    fetchAll();
    super.onInit();
  }

  // ================= FETCH ALL =================
  Future<void> fetchAll() async {
    try {
      isLoading(true);

      final opRes = await api.get(ApiEndpoints.operations);
      final machineRes = await api.get(ApiEndpoints.machines);
      final compRes = await api.get(ApiEndpoints.components);

      operations.value = OperationModel.fromJson(opRes).data ?? [];
      machines.value = MachineModel.fromJson(machineRes).data ?? [];
      components.value = ComponentModel.fromJson(compRes).data ?? [];
    } catch (e) {
      Get.snackbar("Error", "Failed to load data: $e");
    } finally {
      isLoading(false);
    }
  }

  // ================= GET BY ID =================
  Future<void> getOperationById(String id) async {
    try {
      isLoading(true);

      final res = await api.get("${ApiEndpoints.operations}/$id");
      final op = Operation.fromJson(res["data"]);

      // ✅ SAFE (ONLY STRING NOW)
      selectedMachineId.value = op.machineId ?? "";
      selectedComponentId.value = op.componentId ?? "";

      editId.value = op.id ?? "";
      isEditMode.value = true;
    } catch (e) {
      Get.snackbar("Error", "Failed to load operation: $e");
    } finally {
      isLoading(false);
    }
  }

  // ================= ADD / UPDATE =================
  Future<void> saveOperation({
    required String code,
    required String name,
    required String description,
    required int type,
  }) async {
    try {
      isLoading(true);

      final body = {
        "operationCode": code,
        "operationName": name,
        "operationDescription": description,
        "operationType": type,
        "machineId": selectedMachineId.value,
        "componentId": selectedComponentId.value,
      };

      if (isEditMode.value) {
        await api.put("${ApiEndpoints.operations}/${editId.value}", body);

        Get.snackbar("Success", "Operation updated");
      } else {
        await api.post(ApiEndpoints.operations, body);

        Get.snackbar("Success", "Operation created");
      }

      // refresh list FIRST
      await fetchAll();

      // clear AFTER success
      clearForm();

      // go back only after everything succeeds
      Get.back();
    } catch (e) {
      Get.snackbar("Error", "Operation failed: $e");
    } finally {
      isLoading(false);
    }
  }
  // Future<void> saveOperation({
  //   required String code,
  //   required String name,
  //   required String description,
  //   required int type,
  // }) async {
  //   try {
  //     isLoading(true);

  //     final body = {
  //       "operationCode": code,
  //       "operationName": name,
  //       "operationDescription": description,
  //       "operationType": type,
  //       "machineId": selectedMachineId.value,
  //       "componentId": selectedComponentId.value,
  //     };

  //     if (isEditMode.value) {
  //       await api.put("${ApiEndpoints.operations}/${editId.value}", body);
  //       Get.snackbar("Success", "Operation updated");
  //     } else {
  //       await api.post(ApiEndpoints.operations, body);
  //       Get.snackbar("Success", "Operation created");
  //     }

  //     await fetchAll();
  //     clearForm();

  //     // ✅ BACK TO PREVIOUS SCREEN
  //     Get.back();
  //   } catch (e) {
  //     Get.snackbar("Error", "Operation failed: $e");
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  // ================= DELETE =================
  Future<void> deleteOperation(String id) async {
    try {
      isLoading(true);

      await api.delete("${ApiEndpoints.operations}/$id");

      operations.removeWhere((o) => o.id == id);

      Get.snackbar("Success", "Operation deleted");
    } catch (e) {
      Get.snackbar("Error", "Delete failed: $e");
    } finally {
      isLoading(false);
    }
  }

  // ================= CLEAR FORM =================
  void clearForm() {
    selectedMachineId.value = "";
    selectedComponentId.value = "";
    isEditMode.value = false;
    editId.value = "";
  }

  // ================= OPTIONAL HELPERS =================
  String getMachineName(String? id) {
    return machines.firstWhereOrNull((m) => m.id == id)?.machineName ?? "-";
  }

  String getComponentName(String? id) {
    return components.firstWhereOrNull((c) => c.id == id)?.componentName ?? "-";
  }
}
