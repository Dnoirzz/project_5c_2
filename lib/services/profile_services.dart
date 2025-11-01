import 'dart:convert';
import 'package:SPMB/models/dataAkademik_models.dart';
import 'package:SPMB/models/dataDokumen_models.dart';
import 'package:SPMB/models/dataOrangTua_models.dart';
import 'package:SPMB/models/dataPribadi_models.dart';
import 'package:http/http.dart' as http;

class dataMahasiswaService {
  static const String baseUrl = "http://44.220.144.82/api";

  static Future<DataMahasiswa> getDataMahasiswaByEmail(String email) async {
    final url = Uri.parse("$baseUrl/get_dataMahasiswaaa.php?email=$email");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body["success"] == true && body["data"].isNotEmpty) {
        return DataMahasiswa.fromJson(body["data"][0]);
      } else {
        throw Exception("Data mahasiswa tidak ditemukan");
      }
    } else {
      throw Exception("Gagal memuat data mahasiswa");
    }
  }

  static Future<List<DataAkademik>> getDataAkademikByIdMahasiswa(
      int idMahasiswa) async {
    final url =
        Uri.parse("$baseUrl/get_dataAkademikk.php?id_mahasiswa=$idMahasiswa");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body["success"] == true) {
        final List data = body["data"];
        return data.map((e) => DataAkademik.fromJson(e)).toList();
      } else {
        throw Exception("Data akademik tidak ditemukan");
      }
    } else {
      throw Exception("Gagal memuat data akademik");
    }
  }

  static Future<List<DataOrangtua>> getDataOrangTuaByIdMahasiswa(
      int idMahasiswa) async {
    final url =
        Uri.parse("$baseUrl/get_dataOrangTua.php?id_mahasiswa=$idMahasiswa");
    print("Fetching from: $url");

    final response = await http.get(url);
    print("Raw response: ${response.body}");

    if (response.statusCode == 200) {
      try {
        final body = json.decode(response.body);
        if (body["success"] == true && body["data"] != null) {
          final List data = body["data"];
          print("Parsed data length: ${data.length}");
          return data.map((e) => DataOrangtua.fromJson(e)).toList();
        } else {
          throw Exception("Data kosong dari server");
        }
      } catch (e) {
        throw Exception("Gagal parsing JSON: $e");
      }
    } else {
      throw Exception("HTTP Error ${response.statusCode}");
    }
  }

  static Future<List<DataDokumen>> getDataDokumenByIdMahasiswa(
      int idMahasiswa) async {
    final url =
        Uri.parse("$baseUrl/get_dataDokumen.php?id_mahasiswa=$idMahasiswa");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      if (body["success"] == true) {
        final List data = body["data"];
        return data.map((e) => DataDokumen.fromJson(e)).toList();
      } else {
        throw Exception("Gagal memuat data dokumen: ${body['message']}");
      }
    } else {
      throw Exception("Gagal koneksi ke server: ${response.statusCode}");
    }
  }
}
