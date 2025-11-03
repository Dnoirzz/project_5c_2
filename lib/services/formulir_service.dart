import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FormulirService {
  // Ganti dengan URL VPS Anda (tanpa trailing slash)
  static const String baseUrl = 'http://44.220.144.82/api';

  /// Upload data final ke database
  static Future<Map<String, dynamic>> uploadFinal({
    int? userId,
    required Map<String, dynamic> formData,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedId = prefs.getInt('user_id') ?? 0;
      userId = (userId == null || userId == 0) ? storedId : userId;

      if (userId == 0) {
        return {
          'status': 'error',
          'message': 'User ID tidak valid. Silakan login ulang.'
        };
      }// 🔹 Perbaiki nama field agama sebelum dikirim ke PHP
      if (formData[0]?['selectedAgama'] != null && formData[0]?['agama'] == null) {
        formData[0]?['agama'] = formData[0]?['selectedAgama'];
      }


      final url = Uri.parse('http://44.220.144.82/api/uplaod_final.php');
      
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'form_data': formData,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'status': 'error',
          'message': 'HTTP Error ${response.statusCode}'
        };
      }
    } catch (e) {
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
