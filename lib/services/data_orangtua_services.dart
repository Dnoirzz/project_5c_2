import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/data_orangtua_models.dart';

class DataOrangtuaService {
  final String baseUrl = "http://192.168.1.5/project_5c_2/backend/";

  /// Fetch all data_orangtua from admin_dashboard.php
  Future<List<DataOrangtuaModel>> fetchDataOrangtua() async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrl}admin_dashboard.php"),
        headers: {"Authorization": "Bearer mysecretkey"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Ambil bagian data_orangtua dari JSON
        final List<dynamic> dataOrangtuaList = jsonData["data"]["data_orangtua"];

        return dataOrangtuaList
            .map((item) => DataOrangtuaModel.fromJson(item))
            .toList();
      } else {
        throw Exception("Failed to load data_orangtua: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data_orangtua: $e");
    }
  }
}
