import 'package:veloce_task_frontend/common_components/common_toast_message.dart';
import 'network_checker.dart';

class NetworkGuard {
  static Future<bool> ensureInternet() async {
    final connected = await NetworkChecker.isConnected();

    if (!connected) {
      AppToast.info("No Internet", "Please check your internet connection");
      return false;
    }

    return true;
  }
}
