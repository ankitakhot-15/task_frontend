import 'package:get/get.dart';
import '../core/api/api_service.dart';
import '../core/api/api_endpoints.dart';

class MachineController extends GetxController {
  final ApiService api = ApiService();

  var isLoading = false.obs;

  var machineList = <Map<String, dynamic>>[].obs;
  var locationList = <Map<String, dynamic>>[].obs;
  var manufacturerList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    fetchAllData();
    super.onInit();
  }

  Future<void> fetchAllData() async {
    try {
      isLoading(true);

      final results = await Future.wait([
        api.get(ApiEndpoints.machines),
        api.get(ApiEndpoints.locations),
        api.get(ApiEndpoints.manufacturers),
      ]);

      machineList.value = List<Map<String, dynamic>>.from(results[0]['data']);

      locationList.value = List<Map<String, dynamic>>.from(results[1]['data']);

      manufacturerList.value = List<Map<String, dynamic>>.from(
        results[2]['data'],
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
