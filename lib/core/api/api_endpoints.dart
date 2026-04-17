class ApiEndpoints {
  static const String baseUrl = "https://task-backend-4-5f76.onrender.com/api";

  // Helper method (clean + reusable)
  static String _path(String endpoint) => "$baseUrl$endpoint";

  // =========================
  // 🔹 MACHINE MODULE
  // =========================
  static String machines = _path("/machine");

  // =========================
  // 🔹 COMPONENT MODULE
  // =========================
  static String components = _path("/component");

  // =========================
  // 🔹 OPERATION MODULE
  // =========================
  static String operations = _path("/operation");

  // =========================
  // 🔹 MASTER DATA
  // =========================
  static String manufacturers = _path("/manufacturer");
  static String locations = _path("/location");
  static String customers = _path("/customer");
}
