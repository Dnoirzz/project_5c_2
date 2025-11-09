// lib/services/jurusan_prodi_service.dart
import 'dart:convert';
import 'package:SPMB/models/jurusanModel.dart';
import 'package:SPMB/models/prodiModel.dart';
import 'package:http/http.dart' as http;
// import '../models/jurusan_model.dart';
// import '../models/prodi_model.dart';

class JurusanProdiService {
  static const String baseUrl = "http://44.220.144.82/api";

  // Cache untuk menyimpan data agar tidak perlu fetch berkali-kali
  static List<Jurusan>? _cachedJurusan;
  static Map<int, List<Prodi>> _cachedProdi = {};

  // Get semua jurusan
  static Future<List<Jurusan>> getAllJurusan() async {
    // Return cached data if available
    if (_cachedJurusan != null && _cachedJurusan!.isNotEmpty) {
      return _cachedJurusan!;
    }

    try {
      final url = Uri.parse("$baseUrl/get_jurusan_pendaftaran.php");
      final response = await http.get(url);

      print('📥 Get Jurusan - Status: ${response.statusCode}');
      print('📥 Get Jurusan - Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          List<Jurusan> jurusanList = (data['data'] as List)
              .map((item) => Jurusan.fromJson(item))
              .toList();

          // Cache the result
          _cachedJurusan = jurusanList;

          return jurusanList;
        } else {
          throw Exception(data['message'] ?? 'Gagal memuat jurusan');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error get jurusan: $e');
      throw Exception('Gagal memuat data jurusan: $e');
    }
  }

  // Get prodi berdasarkan id_jurusan
  static Future<List<Prodi>> getProdiByJurusan(int idJurusan) async {
    // Return cached data if available
    if (_cachedProdi.containsKey(idJurusan) &&
        _cachedProdi[idJurusan]!.isNotEmpty) {
      return _cachedProdi[idJurusan]!;
    }

    try {
      final url =
          Uri.parse("$baseUrl/get_prodi_pendaftaran.php?id_jurusan=$idJurusan");
      final response = await http.get(url);

      print('📥 Get Prodi - Status: ${response.statusCode}');
      print('📥 Get Prodi - Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          List<Prodi> prodiList = (data['data'] as List)
              .map((item) => Prodi.fromJson(item))
              .toList();

          // Cache the result
          _cachedProdi[idJurusan] = prodiList;

          return prodiList;
        } else {
          throw Exception(data['message'] ?? 'Gagal memuat prodi');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error get prodi: $e');
      throw Exception('Gagal memuat data prodi: $e');
    }
  }

  // Clear cache
  static void clearCache() {
    _cachedJurusan = null;
    _cachedProdi.clear();
  }
}
