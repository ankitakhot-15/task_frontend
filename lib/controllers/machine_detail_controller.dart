import 'package:get/get.dart';
import '../core/api/api_service.dart';
import '../core/api/api_endpoints.dart';

class MachineDetailController extends GetxController {
  final ApiService api = ApiService();

  var isLoading = false.obs;
  var machine = Rxn<Map<String, dynamic>>();

  Future<void> fetchMachineById(String id) async {
    try {
      isLoading(true);

      final res = await api.get("${ApiEndpoints.machines}/$id");

      machine.value = res['data'];
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}