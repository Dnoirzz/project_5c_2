// ignore_for_file: avoid_print

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
    
    print('===== API CALL =====');
    print('URL: $uri');
    print('Query Params: $queryParams');
    
    try {
      final response = await http.get(uri);

      print('===== API RESPONSE =====');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        
        print('===== PARSED BODY =====');
        print('Success: ${body["success"]}');
        print('Message: ${body["message"]}');
        print('Data length: ${body["data"] != null ? (body["data"] as List).length : 0}');
        
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
      print('===== API ERROR =====');
      print('Error: $e');
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

  /// Update status dokumen (terima/tolak)
  /// jenisDokumen: 'ktp', 'ijazah', 'akta', 'kk', 'foto'
  /// status: 'diterima' -> 'Lulus Verifikasi', 'ditolak' -> 'Ditolak Verifikasi'
  static Future<bool> updateStatusDokumen({
    required String idMahasiswa,
    required String jenisDokumen,
    required String status, // 'diterima' atau 'ditolak'
  }) async {
    final url = Uri.parse("$baseUrl/update_status_dokumen.php");
    
    // Mapping jenis dokumen ke format database
    // Berdasarkan enum di database: 'Ijazah/SKL', 'Kartu Keluarga', 'Akta Kelahir...', dll
    final jenisDokumenMap = {
      'ktp': 'KTP',
      'ijazah': 'Ijazah/SKL',
      'akta': 'Akta Kelahiran',
      'kk': 'Kartu Keluarga',
      'foto': 'Pas Foto 3x4',
      // Alternatif mapping jika format berbeda
      'kartu tanda penduduk': 'KTP',
      'skl': 'Ijazah/SKL',
      'kartu keluarga': 'Kartu Keluarga',
      'pas foto': 'Pas Foto 3x4',
    };
    
    final jenisDokumenLower = jenisDokumen.toLowerCase();
    final jenisDokumenDb = jenisDokumenMap[jenisDokumenLower] ?? jenisDokumen;
    
    // Mapping status ke enum database
    final statusDb = status == 'diterima' 
        ? 'Lulus Verifikasi' 
        : 'Ditolak Verifikasi';
    
    try {
      print('===== UPDATE STATUS DOKUMEN =====');
      print('ID Mahasiswa: $idMahasiswa');
      print('Jenis Dokumen: $jenisDokumen -> $jenisDokumenDb');
      print('Status: $status -> $statusDb');
      print('URL: $url');

      final response = await http.post(
        url,
        body: {
          'id_mahasiswa': idMahasiswa,
          'jenis_dokumen': jenisDokumenDb,
          'status_verifikasi': statusDb,
        },
      );

      print('===== RESPONSE =====');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      print('Response Headers: ${response.headers}');

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw Exception("Response body kosong. Kemungkinan error PHP atau config tidak ditemukan.");
        }
        
        final body = json.decode(response.body);
        print('Parsed Body: $body');
        
        if (body["success"] == true) {
          return true;
        } else {
          throw Exception(body["message"] ?? "Update gagal tanpa pesan error");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}. Response: ${response.body}");
      }
    } catch (e) {
      print('===== ERROR UPDATE STATUS DOKUMEN =====');
      print('Error: $e');
      print('Error Type: ${e.runtimeType}');
      throw Exception("Gagal update status dokumen: $e");
    }
  }

  /// Get list dokumen untuk mahasiswa tertentu
  static Future<List<Map<String, dynamic>>> getDokumenMahasiswa(String idMahasiswa) async {
    final url = Uri.parse("$baseUrl/get_dokumen_mahasiswa.php?id_mahasiswa=$idMahasiswa");
    
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body["success"] == true) {
          final List data = body["data"] ?? [];
          return data.map((e) => e as Map<String, dynamic>).toList();
        } else {
          throw Exception("Gagal: ${body["message"]}");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Gagal memuat dokumen mahasiswa: $e");
    }
  }

  /// Debug: Get semua jenis dokumen untuk mahasiswa tertentu (untuk melihat format yang benar)
  static Future<List<String>> getJenisDokumenMahasiswa(String idMahasiswa) async {
    // Buat file PHP sederhana untuk cek jenis dokumen
    // Atau gunakan query langsung jika ada endpoint
    try {
      final dokumenList = await getDokumenMahasiswa(idMahasiswa);
      return dokumenList.map((d) => d['jenis_dokumen']?.toString() ?? '').toList();
    } catch (e) {
      print('Error get jenis dokumen: $e');
      return [];
    }
  }
}