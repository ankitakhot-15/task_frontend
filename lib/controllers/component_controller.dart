import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:veloce_task_frontend/core/api/api_endpoints.dart';
import 'package:veloce_task_frontend/core/api/api_service.dart';

class ComponentController extends GetxController {
  final ApiService api = ApiService();

  var isLoading = false.obs;
  var componentList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    fetchComponents();
    super.onInit();
  }

  Future<void> fetchComponents() async {
    try {
      isLoading(true);

      final res = await api.get(ApiEndpoints.components);
      componentList.value = List<Map<String, dynamic>>.from(res['data']);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}