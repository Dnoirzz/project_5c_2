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
      // 🔹 Ambil ID pengguna yang tersimpan
      final prefs = await SharedPreferences.getInstance();
      final storedId = prefs.getInt('user_id') ?? 0;
      userId = (userId == null || userId == 0) ? storedId : userId;

      if (userId == 0) {
        print("[ERROR] userId tidak valid");
        return {
          'status': 'error',
          'message': 'User ID tidak valid. Silakan login ulang.'
        };
      }

      // 🔹 Endpoint upload
      final url = Uri.parse('$baseUrl/upload_final.php');

      // 🔹 Data JSON dikirim ke PHP
      final Map<String, dynamic> bodyData = {
        'user_id': userId,
        'page_0': allFormData[0] ?? {},
        'page_1': allFormData[1] ?? {},
        'page_2': allFormData[2] ?? {},
        'page_3': allFormData[3] ?? {},
      };

      print("[DEBUG] Body data yang dikirim: ${jsonEncode(bodyData)}");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyData),
      );

      print("[DEBUG] HTTP Status: ${response.statusCode}");
      print("[DEBUG] Response body: ${response.body}");

      // 🔹 Pastikan response JSON valid
      if (response.statusCode == 200) {
        try {
          return jsonDecode(response.body);
        } catch (e) {
          print("[ERROR] Gagal decode JSON: $e");
          return {
            'status': 'error',
            'message': 'Respon server bukan JSON valid.'
          };
        }
      } else {
        return {
          'status': 'error',
          'message': 'HTTP Error: ${response.statusCode}',
        };
      }
    } catch (e) {
      print("[EXCEPTION] $e");
      return {'status': 'error', 'message': e.toString()};
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
