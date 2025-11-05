import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FormulirService {
  // Ganti dengan URL VPS Anda (tanpa trailing slash)
  static const String baseUrl = 'http://44.220.144.82/api';

  /// Upload data final ke database
  static Future<Map<String, dynamic>> uploadDataPribadi(
      Map<String, dynamic> formData) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id_pengguna') ?? 0;

    if (userId == 0) {
      return {'status': 'error', 'message': 'User belum login'};
    }

    final url = Uri.parse('$baseUrl/uplaod_pribadi.php'); //  fix di sini
    print("🔹 Mengirim data ke: $url");
    print("📦 Payload: ${jsonEncode({
          'id_pengguna': userId,
          'form_data': formData
        })}");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id_pengguna': userId,
        'form_data': formData,
      }),
    );

    print("📩 Response dari server: ${response.body}");

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      // ✅ Simpan ID Mahasiswa kalau ada di response
      if (result['status'] == 'success' && result['id_mahasiswa'] != null) {
        await prefs.setInt('id_mahasiswa', result['id_mahasiswa']);
        print("✅ ID Mahasiswa disimpan: ${result['id_mahasiswa']}");
      } else {
        print("⚠️ Response tidak berisi id_mahasiswa: $result");
      }

      return result;
    } else {
      print("❌ HTTP Error: ${response.statusCode}");
      return {
        'status': 'error',
        'message': 'HTTP Error: ${response.statusCode}'
      };
    }
  }

  static Future<Map<String, dynamic>> uploadDataAkademik(
      Map<String, dynamic> formData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final idMahasiswa = prefs.getInt('id_mahasiswa') ?? 0;

      if (idMahasiswa == 0) {
        return {
          'status': 'error',
          'message':
              'ID Mahasiswa tidak ditemukan. Silakan isi Data Pribadi terlebih dahulu.'
        };
      }

      final url = Uri.parse('$baseUrl/upload_akademik.php');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id_mahasiswa': idMahasiswa,
          'form_data': formData,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'status': 'error',
          'message': 'HTTP Error: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'status': 'error', 'message': e.toString()};
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
