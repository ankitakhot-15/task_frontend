import 'package:get/get.dart';
import '../core/api/api_service.dart';
import '../core/api/api_endpoints.dart';
import '../data/models/machine_model.dart';

class MachineController extends GetxController {
  var machines = <MachineModel>[].obs;
  var isLoading = false.obs;

  final ApiService api = ApiService();

  @override
  void onInit() {
    fetchMachines();
    super.onInit();
  }

  Future<void> fetchMachines() async {
    try {
      isLoading.value = true;

      final data = await api.get(ApiEndpoints.machines);

      machines.value = List<MachineModel>.from(
        data.map((e) => MachineModel.fromJson(e)),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addMachine(MachineModel model) async {
    await api.post(ApiEndpoints.machines, model.toJson());
    fetchMachines();
  }
}