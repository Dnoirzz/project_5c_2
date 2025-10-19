import 'dart:convert';
import 'package:http/http.dart' as http;

class FormulirService {
  // Ganti dengan URL VPS Anda (tanpa trailing slash)
  static const String baseUrl = 'http://44.220.144.82/api';

  /// Simpan draft ke database
  static Future<Map<String, dynamic>> saveDraft(
      {required int userId,
      required int pageNumber,
      required Map<String, dynamic> formData,
      x}) async {
    try {
      final url = Uri.parse('$baseUrl/upload_final.php');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'page_number': pageNumber,
          'form_data': formData,
        }),
      );

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

  /// Ambil draft dari database
  static Future<Map<String, dynamic>> getDraft({
    required int userId,
    int? pageNumber,
  }) async {
    try {
      String url = '$baseUrl/get_draft.php?user_id=$userId';
      if (pageNumber != null) {
        url += '&page_number=$pageNumber';
      }

      final response = await http.get(Uri.parse(url));

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

  /// Upload data final ke database
  static Future<Map<String, dynamic>> uploadFinal({
    required int userId,
    required Map<int, Map<String, dynamic>> allFormData,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/upload_final.php');

      // Format data sesuai dengan yang dibutuhkan PHP
      Map<String, dynamic> payload = {
        'user_id': userId,
        'page_0': allFormData[0] ?? {},
        'page_1': allFormData[1] ?? {},
        'page_2': allFormData[2] ?? {},
        'page_3': allFormData[3] ?? {},
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

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

  /// Load semua draft saat membuka formulir
  static Future<Map<int, Map<String, dynamic>>> loadAllDrafts({
    required int userId,
  }) async {
    try {
      final result = await getDraft(userId: userId);

      if (result['status'] == 'success' && result['data'] != null) {
        Map<int, Map<String, dynamic>> drafts = {};

        if (result['data'] is List) {
          // Multiple drafts
          for (var draft in result['data']) {
            int pageNum = draft['page_number'];
            drafts[pageNum] = draft['form_data'];
          }
        } else {
          // Single draft
          int pageNum = result['data']['page_number'];
          drafts[pageNum] = result['data']['form_data'];
        }

        return drafts;
      }

      return {};
    } catch (e) {
      print('Error loading drafts: $e');
      return {};
    }
  }
}
