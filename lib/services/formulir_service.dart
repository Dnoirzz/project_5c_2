import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FormulirService {
  // Ganti dengan URL VPS Anda (tanpa trailing slash)
  static const String baseUrl = 'http://44.220.144.82/api';

  /// Upload data final ke database
  static Future<Map<String, dynamic>> uploadFinal({
    int? userId,
    required Map<int, Map<String, dynamic>> allFormData,
  }) async {
    try {
      // 🔹 Ambil user_id dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final storedId = prefs.getInt('user_id') ?? 0;
      userId = userId == 0 ? storedId : userId;

      if (userId == 0) {
        print(" [WARNING] userId tidak valid ($userId). Silakan login ulang.");
        return {
          'status': 'error',
          'message': 'User ID tidak valid. Silakan login ulang.',
        };
      }

      final url = Uri.parse('$baseUrl/upload_final.php');
      print(" [DEBUG] userId yang dikirim: $userId");

      Map<String, dynamic> payload = {
        'user_id': userId,
        'page_0': allFormData[0] ?? {},
        'page_1': allFormData[1] ?? {},
        'page_2': allFormData[2] ?? {},
        'page_3': allFormData[3] ?? {},
      };

      print(" [DEBUG] Mengirim data ke server: ${jsonEncode(payload)}");

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      print(" [DEBUG] Response server: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'status': 'error',
          'message': 'HTTP Error: ${response.statusCode}',
          'body': response.body,
        };
      }
    } catch (e) {
      print("❌ Error di uploadFinal: $e");
      return {'status': 'error', 'message': 'Network error: $e'};
    }
  }

  /// Cek status pendaftaran mahasiswa
  static Future<Map<String, dynamic>> checkStatus({
    required int userId,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/check_status.php?user_id=$userId');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'status': 'error',
          'message': 'HTTP Error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Network error: $e',
      };
    }
  }

  /// Get data mahasiswa yang sudah tersimpan
  static Future<Map<String, dynamic>> getMahasiswaData({
    required int userId,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/get_mahasiswa.php?user_id=$userId');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'status': 'error',
          'message': 'HTTP Error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Network error: $e',
      };
    }
  }
}
