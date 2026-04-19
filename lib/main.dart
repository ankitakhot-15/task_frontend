import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veloce_task_frontend/core/theme/app_theme.dart';
import 'package:veloce_task_frontend/core/utils/inital_binding.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.dashboard,
      getPages: AppRoutes.routes,
    );
  }
}
