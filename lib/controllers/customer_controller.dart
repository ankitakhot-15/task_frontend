import 'package:get/get.dart';
import 'package:veloce_task_frontend/common_components/common_toast_message.dart';
import 'package:veloce_task_frontend/core/api/api_endpoints.dart';
import 'package:veloce_task_frontend/core/api/api_service.dart';
import 'package:veloce_task_frontend/data/models/customer_model.dart';

class CustomerController extends GetxController {
  final ApiService api = ApiService();

  var isLoading = false.obs;
  var customers = <Customer>[].obs;

  @override
  void onInit() {
    fetchCustomers();
    super.onInit();
  }

  // =========================
  // 🔹 COMMON LOADER WRAPPER
  // =========================
  Future<T?> _safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      isLoading(true);
      return await apiCall();
    } catch (e) {
      AppToast.error(e.toString());
      return null;
    } finally {
      isLoading(false);
    }
  }

  // =========================
  // 🔹 GET ALL CUSTOMERS
  // =========================
  Future<void> fetchCustomers() async {
    final response = await _safeApiCall(() async {
      return await api.get(ApiEndpoints.customers);
    });

    if (response != null) {
      final model = CustomerModel.fromJson(response);
      customers.value = model.data ?? [];
    }
  }

  // =========================
  // 🔹 CREATE CUSTOMER
  // =========================
  Future<void> addCustomer(String name) async {
    await _safeApiCall(() async {
      await api.post(ApiEndpoints.customers, {
        "name": name,
      });
    });

    await fetchCustomers();
    AppToast.success("Customer added successfully");
  }

  // =========================
  // 🔹 UPDATE CUSTOMER
  // =========================
  Future<void> updateCustomer(String id, String name) async {
    await _safeApiCall(() async {
      await api.put("${ApiEndpoints.customers}/$id", {
        "name": name,
      });
    });

    await fetchCustomers();
    AppToast.success( "Customer updated successfully");
  }

  // =========================
  // 🔹 DELETE CUSTOMER
  // =========================
  Future<void> deleteCustomer(String id) async {
    await _safeApiCall(() async {
      await api.delete("${ApiEndpoints.customers}/$id");
    });

    customers.removeWhere((c) => c.id == id);
    AppToast.success("Customer deleted");
  }
}