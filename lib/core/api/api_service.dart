import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const Duration _timeout = Duration(seconds: 30);

  // =======================
  // 🔹 GET API
  // =======================
  Future<dynamic> get(String url) async {
    try {
      final response = await http
          .get(Uri.parse(url), headers: _headers())
          .timeout(_timeout);

      return _handleResponse(response);
    } catch (e) {
      throw Exception("GET API Error: $e");
    }
  }

  // =======================
  // 🔹 POST API (CREATE)
  // =======================
  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: _headers(),
            body: jsonEncode(body),
          )
          .timeout(_timeout);

      return _handleResponse(response);
    } catch (e) {
      throw Exception("POST API Error: $e");
    }
  }

  // =======================
  // 🔹 PUT API (UPDATE)
  // =======================
  Future<dynamic> put(String url, Map<String, dynamic> body) async {
    try {
      final response = await http
          .put(
            Uri.parse(url),
            headers: _headers(),
            body: jsonEncode(body),
          )
          .timeout(_timeout);

      return _handleResponse(response);
    } catch (e) {
      throw Exception("PUT API Error: $e");
    }
  }

  // =======================
  // 🔹 DELETE API
  // =======================
  Future<dynamic> delete(String url) async {
    try {
      final response = await http
          .delete(Uri.parse(url), headers: _headers())
          .timeout(_timeout);

      return _handleResponse(response);
    } catch (e) {
      throw Exception("DELETE API Error: $e");
    }
  }

  // =======================
  // 🔹 COMMON HEADERS
  // =======================
  Map<String, String> _headers() {
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
      // Add token here if needed:
      // "Authorization": "Bearer YOUR_TOKEN",
    };
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
        throw Exception("Bad Request: ${body ?? response.body}");

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