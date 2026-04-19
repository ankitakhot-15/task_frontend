import 'package:get/get.dart';
import 'package:veloce_task_frontend/common_components/common_toast_message.dart';
import '../core/api/api_service.dart';
import '../core/api/api_endpoints.dart';

class MachineDetailController extends GetxController {
  final ApiService api = ApiService();

  var isLoading = false.obs;

  var machine = Rxn<Map<String, dynamic>>();

  var manufacturers = <Map<String, dynamic>>[].obs;
  var locations = <Map<String, dynamic>>[].obs;

  var selectedManufacturer = RxnString();
  var selectedLocation = RxnString();

  Future<void> fetchMachineById(String id) async {
    try {
      isLoading(true);

      final results = await Future.wait([
        api.get("${ApiEndpoints.machines}/$id"),
        api.get(ApiEndpoints.manufacturers),
        api.get(ApiEndpoints.locations),
      ]);

      machine.value = results[0]['data'];

      manufacturers.value = List<Map<String, dynamic>>.from(results[1]['data']);

      locations.value = List<Map<String, dynamic>>.from(results[2]['data']);

      selectedManufacturer.value = machine.value?['manufacturerId']?['_id'];

      selectedLocation.value = machine.value?['locationId']?['_id'];
    } catch (e) {
      AppToast.error(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
