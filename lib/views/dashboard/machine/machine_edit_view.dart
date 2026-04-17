import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/common_components/app_dropdown.dart';
import 'package:veloce_task_frontend/common_components/app_text_field.dart';
import 'package:veloce_task_frontend/common_components/machine_header_card.dart';
import 'package:veloce_task_frontend/controllers/machine_controller.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';
import 'package:veloce_task_frontend/core/utils/custom_loader.dart';

class MachineEditView extends StatefulWidget {
  final Map machine;

  const MachineEditView({super.key, required this.machine});

  @override
  State<MachineEditView> createState() => _MachineEditViewState();
}

class _MachineEditViewState extends State<MachineEditView> {
  final controller = Get.find<MachineController>();
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final serialCtrl = TextEditingController();
  final modelCtrl = TextEditingController();
  final yearCtrl = TextEditingController();

  String? selectedManufacturer;
  String? selectedLocation;

  @override
  void initState() {
    super.initState();

    final m = Map<String, dynamic>.from(widget.machine);

    controller.machine.value = m;

    nameCtrl.text = m['machineName'] ?? '';
    serialCtrl.text = m['serialNumber'] ?? '';
    modelCtrl.text = m['model'] ?? '';
    yearCtrl.text = m['year']?.toString() ?? '';

    selectedManufacturer = m['manufacturerId']?['_id'];
    selectedLocation = m['locationId']?['_id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Edit Machine"),
        backgroundColor: AppColors.primary,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const CustomLoader();
        }

        final machine = controller.machine.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                MachineHeaderCard(
                  name: machine['machineName'] ?? '',
                  model: machine['model'] ?? '',
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      AppTextField(controller: nameCtrl, label: "Machine Name"),
                      AppTextField(
                        controller: serialCtrl,
                        label: "Serial Number",
                      ),
                      AppTextField(controller: modelCtrl, label: "Model"),
                      AppTextField(
                        controller: yearCtrl,
                        label: "Year",
                        keyboard: TextInputType.number,
                      ),

                      AppDropdown(
                        label: "Manufacturer",
                        value: selectedManufacturer,
                        items: controller.manufacturerList,
                        onChanged: (val) =>
                            setState(() => selectedManufacturer = val),
                      ),

                      AppDropdown(
                        label: "Location",
                        value: selectedLocation,
                        items: controller.locationList,
                        onChanged: (val) =>
                            setState(() => selectedLocation = val),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) return;

                            final updated = await controller.updateMachine(
                              id: machine['_id'],
                              machineName: nameCtrl.text.trim(),
                              serialNumber: serialCtrl.text.trim(),
                              manufacturerId: selectedManufacturer!,
                              model: modelCtrl.text.trim(),
                              year: int.tryParse(yearCtrl.text) ?? 0,
                              type: 1,
                              locationId: selectedLocation!,
                            );

                            if (updated != null) {
                              controller.machine.value = updated;
                            }
                          },
                          child: const Text("Update Machine"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
