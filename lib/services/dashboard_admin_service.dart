import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardService {
  static const String baseUrl = "http://44.220.144.82/api";

  static Future<Map<String, dynamic>> getDashboardStats(String s) async {
    try {
      print('📡 Fetching from: $baseUrl/admin_dashboard_finall.php');

      final response = await http.get(
        Uri.parse('$baseUrl/admin_dashboard_finall.php?email=$s'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw Exception('Connection timeout - Server tidak merespon');
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Jika API memiliki key nama admin
        if (data.containsKey('nama_lengkap')) {
          print("Nama admin: ${data['nama_lengkap']}");
        }

        print('✅ Data parsed successfully');
        return data;
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      print('❌ ClientException: $e');
      throw Exception('Tidak dapat terhubung ke server');
    } on FormatException catch (e) {
      print('❌ FormatException: $e');
      throw Exception('Format response tidak valid');
    } catch (e) {
      print('❌ Error: $e');
      throw Exception('Error: $e');
    }
  }
}
