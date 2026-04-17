import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/core/theme/app_theme.dart';
import 'package:veloce_task_frontend/views/dashboard/machine/machine_master_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/machine',
       getPages: [
        GetPage(
          name: '/machine',
          page: () => MachineMasterView(),
        ),
      ],
    );
  }
}