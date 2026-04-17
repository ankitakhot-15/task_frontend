import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/common_components/app_btn.dart';
import 'package:veloce_task_frontend/controllers/machine_controller.dart';
import 'package:veloce_task_frontend/core/theme/app_colors.dart';
import 'package:veloce_task_frontend/core/utils/custom_loader.dart';
import 'package:veloce_task_frontend/common_components/app_text_field.dart';
import 'package:veloce_task_frontend/common_components/app_dropdown.dart';

class MachineCreateView extends StatefulWidget {
  const MachineCreateView({super.key});

  @override
  State<MachineCreateView> createState() => _MachineCreateViewState();
}

class _MachineCreateViewState extends State<MachineCreateView> {
  final controller = Get.find<MachineController>();
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final serialCtrl = TextEditingController();
  final modelCtrl = TextEditingController();
  final yearCtrl = TextEditingController();

  String? selectedManufacturer;
  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Machine"),
        backgroundColor: AppColors.primary,
      ),
      body: Obx(() {
        return controller.isAdding.value
            ? const CustomLoader()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
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

                      const SizedBox(height: 10),

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
                        child: Obx(() {
                          return AppButton(
                            text: "Create Machine",
                            isLoading: controller.isAdding.value,
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) return;

                              final res = await controller.addMachine(
                                machineName: nameCtrl.text.trim(),
                                serialNumber: serialCtrl.text.trim(),
                                manufacturerId: selectedManufacturer!,
                                model: modelCtrl.text.trim(),
                                year: int.tryParse(yearCtrl.text) ?? 0,
                                type: 1,
                                locationId: selectedLocation!,
                              );

                              if (res != null) {
                                Get.back(result: res);
                              }
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
