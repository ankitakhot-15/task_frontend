import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/views/dashboard/machine/machine_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MachineListView(),
    );
  }
}
