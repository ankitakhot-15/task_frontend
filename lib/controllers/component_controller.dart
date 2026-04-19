import 'package:get/get.dart';
import 'package:veloce_task_frontend/common_components/common_toast_message.dart';
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
    fetchAllComponents();
    super.onInit();
  }

  // =========================
  // 🔹 FETCH ALL DATA
  // =========================

  Future<void> fetchAllComponents() async {
    try {
      isLoading(true);

      final componentRes = await api.get(ApiEndpoints.components);
      final customerRes = await api.get(ApiEndpoints.customers);

      final componentList = ComponentModel.fromJson(componentRes).data ?? [];

      final customerList = CustomerModel.fromJson(customerRes).data ?? [];

      components.assignAll(componentList);
      customers.assignAll(customerList);
    } catch (e) {
      AppToast.error("Failed to load data");
    } finally {
      isLoading(false);
    }
  }

  // =========================
  //  CREATE COMPONENT
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

      await fetchAllComponents();

      AppToast.success("Component added successfully");
    } catch (e) {
      AppToast.error("Failed to add component");
    } finally {
      isLoading(false);
    }
  }

  // =========================
  //  UPDATE COMPONENT
  // =========================
  Future<void> updateComponent(String id, Map<String, dynamic> data) async {
    try {
      isLoading(true);

      await api.put("${ApiEndpoints.components}/$id", data);

      await fetchAllComponents();

      AppToast.success("Component updated");
    } catch (e) {
      AppToast.error("Update failed");
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

      AppToast.success("Component deleted");
    } catch (e) {
      AppToast.error("Delete failed");
    } finally {
      isLoading(false);
    }
  }
}
