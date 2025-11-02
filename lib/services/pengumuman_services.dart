import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/prodi_models.dart';

class ProdiService {
  final String baseUrl = "http://192.168.1.5/project_5c_2/backend/";

  Future<List<ProdiModel>> fetchProdi() async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrl}admin_dashboard.php"),
        headers: {"Authorization": "Bearer mysecretkey"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> data = jsonData["data"]["prodi"];
        return data.map((e) => ProdiModel.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load prodi data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching prodi data: $e");
    }
  }
}
