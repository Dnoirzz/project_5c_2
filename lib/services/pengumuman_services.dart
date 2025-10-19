import 'dart:convert';
import 'package:SPMB/models/pengumuman_models.dart';
import 'package:http/http.dart' as http;

class PengumumanService {
  static const String baseUrl = "http://44.220.144.82/api";

  static Future<List<Pengumuman>> getAllPengumuman() async {
    final url = Uri.parse("$baseUrl/get_pengumuman.php");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Pengumuman.fromJson(e)).toList();
    } else {
      throw Exception("Gagal memuat data pengumuman");
    }
  }
}
