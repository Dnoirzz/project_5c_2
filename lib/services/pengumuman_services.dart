import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pengumuman_models.dart';

class PengumumanService {
  static const String baseUrl = "http://44.220.144.82/api";

  // 🔹 Ambil semua pengumuman
  static Future<List<Pengumuman>> getSemuaPengumuman() async {
    final url = Uri.parse("$baseUrl/get_pengumuman.php");
    final response = await http.get(url);

    print("🔹 [GET] $url");
    print("🔹 Status Code: ${response.statusCode}");
    print("🔹 Body: ${response.body}");

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      if (body["success"] == true && body["data"] != null) {
        List dataList = body["data"];
        return dataList.map((e) => Pengumuman.fromJson(e)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception("Gagal memuat data pengumuman");
    }
  }

  // 🔹 Ambil pengumuman untuk dashboard
  static Future<List<Pengumuman>> getPengumumanDashboard() async {
    final url = Uri.parse("$baseUrl/get_pengumuman_dashboard.php");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body["success"] == true && body["data"] != null) {
        List dataList = body["data"];
        return dataList.map((e) => Pengumuman.fromJson(e)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception("Gagal memuat data pengumuman dashboard");
    }
  }

  // 🔹 Update pengumuman
  static Future<bool> updatePengumuman({
    required String id,
    required String judul,
    required String isi,
    required String base64Image,
  }) async {
    final url = Uri.parse("$baseUrl/edit_pengumuman.php");

    print("🔹 Update pengumuman ke: $url");
    print("🔹 ID: $id, Judul: $judul");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "id_pengumuman": id,
        "judul": judul,
        "deskripsi": isi,
        "upload_gambar": base64Image,
      },
    );

    print("🔹 Status: ${response.statusCode}");
    print("🔹 Body: ${response.body}");

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result["success"] == true;
    }
    return false;
  }

  // 🔹 Tambah pengumuman
  static Future<bool> tambahPengumuman({
    required String judul,
    required String isi,
    required String base64Image,
  }) async {
    final url = Uri.parse("$baseUrl/tambah_pengumuman.php");
    final response = await http.post(
      url,
      body: {
        "judul": judul,
        "deskripsi": isi,
        "upload_gambar": base64Image,
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result["success"] == true;
    } else {
      return false;
    }
  }

  // 🔹 Hapus pengumuman
  static Future<bool> deletePengumuman(String id) async {
    final url = Uri.parse("$baseUrl/delete_pengumumann.php");
    print("🔹 Mengirim request hapus dengan id_pengumuman: $id");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {"id_pengumuman": id},
    );

    print("🔹 Status code: ${response.statusCode}");
    print("🔹 Response body: ${response.body}");

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      print("🔹 Response JSON: $result");
      return result["success"] == true;
    } else {
      print("❌ Server error: ${response.statusCode}");
      return false;
    }
  }
}
