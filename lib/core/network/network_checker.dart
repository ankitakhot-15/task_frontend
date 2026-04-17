import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkChecker {
  Future<bool> isConnected() async {
    var result = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    return result != ConnectivityResult.none;
  }
}