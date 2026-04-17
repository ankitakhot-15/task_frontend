import 'package:get/get.dart';
import 'network_checker.dart';

class NetworkGuard {
  static Future<bool> ensureInternet() async {
    final connected = await NetworkChecker.isConnected();

    if (!connected) {
      Get.snackbar(
        "No Internet",
        "Please check your internet connection",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    return true;
  }
}