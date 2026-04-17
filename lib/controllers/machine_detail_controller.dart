// import 'package:get/get.dart';
// import '../core/api/api_service.dart';
// import '../core/api/api_endpoints.dart';

// class MachineDetailController extends GetxController {
//   final ApiService api = ApiService();

//   var isLoading = false.obs;
//   var machine = Rxn<Map<String, dynamic>>();

//   Future<void> fetchMachineById(String id) async {
//     try {
//       isLoading(true);

//       final res = await api.get("${ApiEndpoints.machines}/$id");

//       machine.value = res['data'];
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
// }
import 'package:get/get.dart';
import '../core/api/api_service.dart';
import '../core/api/api_endpoints.dart';

class MachineDetailController extends GetxController {
  final ApiService api = ApiService();

  var isLoading = false.obs;

  var machine = Rxn<Map<String, dynamic>>();

  // Dropdown data
  var manufacturers = <Map<String, dynamic>>[].obs;
  var locations = <Map<String, dynamic>>[].obs;

  // Selected values
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

      // Machine data
      machine.value = results[0]['data'];

      // Dropdown lists
      manufacturers.value =
          List<Map<String, dynamic>>.from(results[1]['data']);

      locations.value =
          List<Map<String, dynamic>>.from(results[2]['data']);

      // Pre-select existing values
      selectedManufacturer.value =
          machine.value?['manufacturerId']?['_id'];

      selectedLocation.value =
          machine.value?['locationId']?['_id'];

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}