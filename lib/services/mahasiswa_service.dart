import 'dart:convert';
import '../../models/mahasiswa_models.dart';
import 'package:http/http.dart' as http;

class MahasiswaService {
  static const String baseUrl = "http://44.220.144.82/api";

  /// Get semua mahasiswa dengan filter
  static Future<List<Mahasiswa>> getSemuaMahasiswa({
    String? jurusan,
    String? prodi,
    String? status,
    String? search,
  }) async {
    final queryParams = <String, String>{};
    
    if (jurusan != null && jurusan.isNotEmpty) {
      queryParams['jurusan'] = jurusan;
    }
    if (prodi != null && prodi.isNotEmpty) {
      queryParams['prodi'] = prodi;
    }
    if (status != null && status.isNotEmpty) {
      queryParams['status'] = status;
    }
    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }

    final uri = Uri.parse("$baseUrl/get_mahasiswa_admin.php")
        .replace(queryParameters: queryParams);
    
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        
        if (body["success"] == true) {
          final List data = body["data"] ?? [];
          return data.map((e) => Mahasiswa.fromJson(e)).toList();
        } else {
          throw Exception("Gagal: ${body["message"]}");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Gagal memuat data mahasiswa: $e");
    }
  }

  /// Get detail mahasiswa berdasarkan ID
  static Future<Mahasiswa> getDetailMahasiswa(int idMahasiswa) async {
    final url = Uri.parse("$baseUrl/get_detail_mahasiswa_admin.php?id=$idMahasiswa");
    
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        
        if (body["success"] == true) {
          return Mahasiswa.fromJson(body["data"]);
        } else {
          throw Exception("Gagal: ${body["message"]}");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Gagal memuat detail mahasiswa: $e");
    }
  }

  /// Verifikasi mahasiswa
  static Future<bool> verifikasiMahasiswa(String idMahasiswa) async {
    final url = Uri.parse("$baseUrl/verifikasi_mahasiswa.php");
    
    try {
      final response = await http.post(
        url,
        body: {
          'id_mahasiswa': idMahasiswa,
        },
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return body["success"] == true;
      }
      return false;
    } catch (e) {
      throw Exception("Gagal verifikasi mahasiswa: $e");
    }
  }

  /// Tolak mahasiswa
  static Future<bool> tolakMahasiswa(String idMahasiswa) async {
    final url = Uri.parse("$baseUrl/tolak_verifikasi.php");
    
    try {
      final response = await http.post(
        url,
        body: {
          'id_mahasiswa': idMahasiswa,
        },
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return body["success"] == true;
      }
      return false;
    } catch (e) {
      throw Exception("Gagal menolak mahasiswa: $e");
    }
  }
}