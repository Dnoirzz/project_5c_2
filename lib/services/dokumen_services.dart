import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dokumen_models.dart';

class DokumenService {
  final String baseUrl = "http://192.168.1.5/project_5c_2/backend/";

  Future<List<DokumenModel>> fetchDokumen() async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrl}admin_dashboard.php"),
        headers: {"Authorization": "Bearer mysecretkey"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> data = jsonData["data"]["dokumen"];
        return data.map((e) => DokumenModel.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load dokumen: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching dokumen: $e");
    }
  }
}
