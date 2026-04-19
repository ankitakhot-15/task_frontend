// routes/app_routes.dart
import 'package:get/get.dart';
import 'package:veloce_task_frontend/views/dashboard/component/component_add_view.dart';
import 'package:veloce_task_frontend/views/dashboard/component/component_detail_view.dart';
import 'package:veloce_task_frontend/views/dashboard/component/component_master_view.dart';
import 'package:veloce_task_frontend/views/dashboard/component/component_update_view.dart';
import 'package:veloce_task_frontend/views/dashboard/dashboard_screen.dart';
import 'package:veloce_task_frontend/views/dashboard/machine/machine_detail_view.dart';
import 'package:veloce_task_frontend/views/dashboard/machine/machine_master_view.dart';
import 'package:veloce_task_frontend/views/dashboard/operation/OperationUpdateView%20.dart';
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
  static const componentUpdate = '/component-update';
  static const componentAdd = '/component-add';

  // OPERATION
  static const operation = '/operation';
  static const operationDetail = '/operation-detail';
  static const operationForm = '/operation-form';
  static const operationUpdate = '/operation-update';

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
    GetPage(name: AppRoutes.component, page: () => ComponentMasterView()),
    GetPage(name: AppRoutes.componentAdd, page: () => ComponentAddView()),

    GetPage(
      name: AppRoutes.componentDetail,
      page: () {
        final id = Get.arguments as String;
        return ComponentDetailView(id: id);
      },
    ),

    GetPage(
      name: AppRoutes.componentUpdate,
      page: () {
        final component = Get.arguments;
        return ComponentUpdateView();
      },
    ),

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
    GetPage(name: operationUpdate, page: () => OperationUpdateView()),
  ];
}
