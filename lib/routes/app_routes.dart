// routes/app_routes.dart
import 'package:get/get.dart';
import 'package:veloce_task_frontend/views/dashboard/component/component_master_view.dart';
import 'package:veloce_task_frontend/views/dashboard/dashboard_screen.dart';
import 'package:veloce_task_frontend/views/dashboard/machine/machine_detail_view.dart';
import 'package:veloce_task_frontend/views/dashboard/machine/machine_master_view.dart';
import 'package:veloce_task_frontend/views/dashboard/operation/operation_detail_screen.dart';
import 'package:veloce_task_frontend/views/dashboard/operation/operation_form_view.dart';
import 'package:veloce_task_frontend/views/dashboard/operation/operation_master_view.dart';

class AppRoutes {
  //dashboard
  static const dashboard = '/dashboard';
  // MACHINE
  static const machine = '/machine';
  static const machineDetail = '/machine-detail';

  // COMPONENT
  static const component = '/component';
  static const componentDetail = '/component-detail';

  // OPERATION
  static const operation = '/operation';
  static const operationDetail = '/operation-detail';
  static const operationForm = '/operation-form';

  static final routes = [
    //dashboard
    GetPage(name: dashboard, page: () => DashboardView()),
    // MACHINE
    GetPage(name: machine, page: () => MachineMasterView()),
    GetPage(
      name: machineDetail,
      page: () {
        final id = Get.arguments as String;
        return MachineDetailView(machineId: id);
      },
    ),

    // COMPONENT
    GetPage(name: component, page: () => ComponentMasterView()),

    // OPERATION
    GetPage(name: operation, page: () => OperationMasterView()),
    GetPage(
      name: operationDetail,
      page: () {
        final id = Get.arguments as String;
        return OperationDetailView(id: id);
      },
    ),
    GetPage(name: operationForm, page: () => OperationFormView()),
  ];
}
