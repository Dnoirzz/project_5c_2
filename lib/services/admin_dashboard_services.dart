import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminDashboardService {
  // 🌐 Your online API endpoint
  static const String baseUrl = "http://44.220.144.82/api";

  // 🔐 Authorization key
  static const String apiKey = "mysecretkey";

  /// 🧭 Fetch dashboard data (online)
  static Future<Map<String, dynamic>> fetchDashboardData() async {
    final Uri url = Uri.parse("$baseUrl/admin_dashboard.php");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception(
            "Failed to load dashboard (status: ${response.statusCode})");
      }
    } catch (e) {
      throw Exception("Error connecting to server: $e");
    }
  }
}
