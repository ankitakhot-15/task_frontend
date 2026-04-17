import 'package:get/get.dart';
import '../core/api/api_service.dart';
import '../core/api/api_endpoints.dart';

class MachineController extends GetxController {
  final ApiService api = ApiService();

  var isLoading = false.obs;
  var isAdding = false.obs;

  var machineList = <Map<String, dynamic>>[].obs;
  var locationList = <Map<String, dynamic>>[].obs;
  var manufacturerList = <Map<String, dynamic>>[].obs;
  var machine = <String, dynamic>{}.obs;

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

  Future<Map<String, dynamic>?> addMachine({
    required String machineName,
    required String serialNumber,
    required String manufacturerId,
    required String model,
    required int year,
    required int type,
    required String locationId,
  }) async {
    try {
      isAdding(true);

      final body = {
        "machineName": machineName,
        "serialNumber": serialNumber,
        "manufacturerId": manufacturerId,
        "model": model,
        "year": year,
        "type": type,
        "locationId": locationId,
      };

      final res = await api.post(ApiEndpoints.machines, body);

      if (res != null && res['success'] == true) {
        return Map<String, dynamic>.from(res['data']);
      }

      return null;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    } finally {
      isAdding(false);
    }
  }

  Future<Map<String, dynamic>?> updateMachine({
    required String id,
    required String machineName,
    required String serialNumber,
    required String manufacturerId,
    required String model,
    required int year,
    required int type,
    required String locationId,
  }) async {
    try {
      isLoading(true);

      final body = {
        "machineName": machineName,
        "serialNumber": serialNumber,
        "manufacturerId": manufacturerId,
        "model": model,
        "year": year,
        "type": type,
        "locationId": locationId,
      };

      final res = await api.put("${ApiEndpoints.machines}/$id", body);

      if (res['success'] == true) {
        final updatedMachine = Map<String, dynamic>.from(res['data']);

        // ✅ update detail state
        machine.value = updatedMachine;

        // ✅ update list locally
        final index = machineList.indexWhere((m) => m['_id'] == id);

        if (index != -1) {
          machineList[index] = updatedMachine;
          machineList.refresh();
        }

        Get.snackbar("Success", "Machine updated");

        return updatedMachine;
      }

      return null;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteMachine(String id) async {
    try {
      isLoading(true);

      final res = await api.delete("${ApiEndpoints.machines}/$id");

      if (res['success'] == true) {
        Get.snackbar("Success", "Machine deleted");

        await fetchAllData();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
