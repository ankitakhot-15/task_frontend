import 'dart:convert';
import 'dart:developer';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const Duration _timeout = Duration(seconds: 30);

  // =======================
  // 🔹 GET API
  // =======================
  Future<dynamic> get(String url) async {
    try {
      log("=========GET Request: $url==============");

      final response = await http
          .get(Uri.parse(url), headers: _headers())
          .timeout(_timeout);

      log("====================GET Response Status: ${response.statusCode}");
      log("====================GET Response Body: ${response.body}");

      final result = _handleResponse(response);

      log("✅========= Parsed GET Data: $result");

      return result;
    } catch (e) {
      log("==========❌ GET Error: $e");
      throw Exception("GET API Error: $e");
    }
  }

  // =======================
  // 🔹 POST API
  // =======================
  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    try {
      log("============== POST Request: $url=================");
      log("=====================Request Body: $body");

      final response = await http
          .post(Uri.parse(url), headers: _headers(), body: jsonEncode(body))
          .timeout(_timeout);

      log("============POST Response Status: ${response.statusCode}");
      log("============= POST Response Body: ${response.body}");

      final result = _handleResponse(response);

      log("✅ =============Parsed POST Data: $result");

      return result;
    } catch (e) {
      log("============❌ POST Error: $e");
      throw Exception("POST API Error: $e");
    }
  }

  // =======================
  // 🔹 PUT API
  // =======================
  Future<dynamic> put(String url, Map<String, dynamic> body) async {
    try {
      log("================ PUT Request: $url===================");
      log(" Request Body: $body");

      final response = await http
          .put(Uri.parse(url), headers: _headers(), body: jsonEncode(body))
          .timeout(_timeout);

      log("===================== PUT Response Status: ${response.statusCode}");
      log("==================== PUT Response Body: ${response.body}");

      final result = _handleResponse(response);

      log("✅================= Parsed PUT Data: $result");

      return result;
    } catch (e) {
      log("==============❌ PUT Error: $e");
      throw Exception("PUT API Error: $e");
    }
  }

  // =======================
  // 🔹 DELETE API
  // =======================
  Future<dynamic> delete(String url) async {
    try {
      log("==========DELETE Request: $url==============");

      final response = await http
          .delete(Uri.parse(url), headers: _headers())
          .timeout(_timeout);

      log("============DELETE Response Status: ${response.statusCode}");
      log("============DELETE Response Body: ${response.body}");

      final result = _handleResponse(response);

      log("✅============= Parsed DELETE Data: $result");

      return result;
    } catch (e) {
      log("===============❌ DELETE Error: $e");
      throw Exception("DELETE API Error: $e");
    }
  }

  // =======================
  // 🔹 HEADERS
  // =======================
  Map<String, String> _headers() {
    return {"Content-Type": "application/json", "Accept": "application/json"};
  }

  // =======================
  // 🔹 RESPONSE HANDLER
  // =======================
  dynamic _handleResponse(http.Response response) {
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;

    switch (response.statusCode) {
      case 200:
      case 201:
        return body;

      case 400:
        final message = body is Map ? body["message"] : "Bad Request";
        Get.snackbar("Alert", message);
        throw Exception(message);

      case 401:
        throw Exception("Unauthorized Access");

      case 403:
        throw Exception("Forbidden Request");

      case 404:
        throw Exception("API Not Found");

      case 500:
        throw Exception("Server Error");

      default:
        throw Exception(
          "Unexpected Error: ${response.statusCode} ${response.body}",
        );
    }
  }
}
