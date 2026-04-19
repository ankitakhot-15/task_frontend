import 'package:get/get.dart';
import 'package:veloce_task_frontend/core/api/api_endpoints.dart';
import 'package:veloce_task_frontend/core/api/api_service.dart';
import 'package:veloce_task_frontend/data/models/component_model.dart';
import 'package:veloce_task_frontend/data/models/customer_model.dart';

class ComponentController extends GetxController {
  final ApiService api = ApiService();

  var isLoading = false.obs;

  var components = <Component>[].obs;
  var customers = <Customer>[].obs;

  var selectedCustomerId = Rxn<String>();

  @override
  void onInit() {
    fetchAll();
    super.onInit();
  }

  // =========================
  // 🔹 FETCH ALL DATA
  // =========================
  Future<void> fetchAll() async {
    try {
      isLoading(true);

      final componentRes = await api.get(ApiEndpoints.components);
      final customerRes = await api.get(ApiEndpoints.customers);

      components.value =
          ComponentModel.fromJson(componentRes).data ?? [];

      customers.value =
          CustomerModel.fromJson(customerRes).data ?? [];

    } catch (e) {
      Get.snackbar("Error", "Failed to load data");
    } finally {
      isLoading(false);
    }
  }

  // =========================
  // 🔹 CREATE COMPONENT
  // =========================
  Future<void> addComponent({
    required String name,
    required String partNo,
    required String ecn,
  }) async {
    try {
      isLoading(true);

      final body = {
        "componentName": name,
        "partNo": partNo,
        "ecn": ecn,
        "customerId": selectedCustomerId.value,
      };

      await api.post(ApiEndpoints.components, body);

      await fetchAll();

      Get.snackbar("Success", "Component added");
    } catch (e) {
      Get.snackbar("Error", "Failed to add component");
    } finally {
      isLoading(false);
    }
  }

  // =========================
  // 🔹 UPDATE COMPONENT
  // =========================
  Future<void> updateComponent(
  String id,
  Map<String, dynamic> data,
) async {
  try {
    isLoading(true);

    await api.put(
      "${ApiEndpoints.components}/$id",
      data,
    );

    await fetchAll();

    Get.snackbar("Success", "Component updated");
  } catch (e) {
    Get.snackbar("Error", "Update failed");
  } finally {
    isLoading(false);
  }
}
  // =========================
  // 🔹 DELETE COMPONENT
  // =========================
  Future<void> deleteComponent(String id) async {
    try {
      isLoading(true);

      await api.delete("${ApiEndpoints.components}/$id");

      components.removeWhere((c) => c.id == id);

      Get.snackbar("Success", "Component deleted");
    } catch (e) {
      Get.snackbar("Error", "Delete failed");
    } finally {
      isLoading(false);
    }
  }
}