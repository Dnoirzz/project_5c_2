import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/data_akademik_models.dart';

class DataAkademikService {
  final String baseUrl = "http://192.168.1.5/project_5c_2/backend/";

  /// Fetch all data_akademik from admin_dashboard.php
  Future<List<DataAkademikModel>> fetchDataAkademik() async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrl}admin_dashboard.php"),
        headers: {"Authorization": "Bearer mysecretkey"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Ambil bagian data akademik dari JSON
        final List<dynamic> dataAkademikList = jsonData["data"]["data_akademik"];

        return dataAkademikList
            .map((item) => DataAkademikModel.fromJson(item))
            .toList();
      } else {
        throw Exception("Failed to load data_akademik: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data_akademik: $e");
    }
  }
}
