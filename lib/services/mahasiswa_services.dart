import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/mahasiswa_models.dart';

class MahasiswaService {
  final String baseUrl = "http://192.168.1.5/project_5c_2/backend/";

  /// Fetch all mahasiswa data from admin_dashboard.php
  Future<List<MahasiswaModel>> fetchMahasiswa() async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrl}admin_dashboard.php"),
        headers: {"Authorization": "Bearer mysecretkey"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // take only the "mahasiswa" table data
        final List<dynamic> mahasiswaData = jsonData["data"]["mahasiswa"];

        return mahasiswaData
            .map((item) => MahasiswaModel.fromJson(item))
            .toList();
      } else {
        throw Exception("Failed to load mahasiswa: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching mahasiswa: $e");
    }
  }
}
