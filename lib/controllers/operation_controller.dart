import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:veloce_task_frontend/core/api/api_endpoints.dart';
import 'package:veloce_task_frontend/core/api/api_service.dart';

class OperationController extends GetxController {
  final ApiService api = ApiService();

  var isLoading = false.obs;
  var operationList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    fetchOperations();
    super.onInit();
  }

  Future<void> fetchOperations() async {
    try {
      isLoading(true);

      final res = await api.get(ApiEndpoints.operations);
      operationList.value = List<Map<String, dynamic>>.from(res['data']);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}