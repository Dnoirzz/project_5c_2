import 'dart:convert';
import 'package:SPMB/models/dataAkademik_models.dart';
import 'package:SPMB/models/dataDokumen_models.dart';
import 'package:SPMB/models/dataOrangTua_models.dart';
import 'package:SPMB/models/dataPribadi_models.dart';
import 'package:http/http.dart' as http;

class dataMahasiswaService {
  static const String baseUrl = "http://44.220.144.82/api";

  static Future<DataMahasiswa> getDataMahasiswaByEmail(String email) async {
    // final url = Uri.parse("$baseUrl/get_dataMahasiswaaa.php?email=$email");
    final url = Uri.parse("$baseUrl/get_dataMahasiswa_final.php?email=$email");
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

//sudah hapirbenar
  // static Future<List<DataDokumen>> getDataDokumenByIdMahasiswa(
  //     int idMahasiswa) async {
  //   final url = Uri.parse(
  //       "$baseUrl/get_dataMahasiswa_finall.php?id_mahasiswa=$idMahasiswa");
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final body = json.decode(response.body);

  //     if (body["success"] == true) {
  //       final List data = body["data"];
  //       // kalau data kosong, tetap kembalikan list kosong tanpa error
  //       return data.map((e) => DataDokumen.fromJson(e)).toList();
  //     } else {
  //       return []; // aman kalau tidak ada data
  //     }
  //   } else {
  //     throw Exception("Gagal koneksi ke server: ${response.statusCode}");
  //   }
  // }

  static Future<List<DataDokumen>> getDataDokumenByIdMahasiswa(
      int idMahasiswa) async {
    // Sesuaikan dengan endpoint yang benar dari gambar (tanpa double 'l')
    final url = Uri.parse(
        "$baseUrl/get_dataMahasiswa_finall.php?id_mahasiswa=$idMahasiswa");

    print("📄 Fetching dokumen from: $url");

    try {
      final response = await http.get(url);
      print("📄 Response status: ${response.statusCode}");
      print("📄 Response body: ${response.body}");

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        if (body["success"] == true && body["data"] != null) {
          final List data = body["data"];
          print("📄 Total dokumen ditemukan: ${data.length}");

          // Parse setiap dokumen dan print detailnya
          final dokumenList = data.map((e) {
            print(
                "📄 Parsing dokumen: ${e['jenis_dokumen']} - Status: ${e['status_verifikasi']}");
            return DataDokumen.fromJson(e);
          }).toList();

          return dokumenList;
        } else {
          print("📄 Data kosong atau success=false");
          return []; // Return list kosong jika tidak ada data
        }
      } else {
        throw Exception("Gagal koneksi ke server: ${response.statusCode}");
      }
    } catch (e) {
      print("📄 Error getDataDokumen: $e");
      throw Exception("Gagal memuat data dokumen: $e");
    }
  }
  // static Future<List<DataDokumen>> getDataDokumenByIdMahasiswa(
  //     int idMahasiswa) async {
  //   final url =
  //       Uri.parse("$baseUrl/get_dokumen_final.php?id_mahasiswa=$idMahasiswa");
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final body = json.decode(response.body);

  //     if (body["success"] == true) {
  //       final List data = body["data"];
  //       return data.map((e) => DataDokumen.fromJson(e)).toList();
  //     } else {
  //       throw Exception("Gagal memuat data dokumen: ${body['message']}");
  //     }
  //   } else {
  //     throw Exception("Gagal koneksi ke server: ${response.statusCode}");
  //   }
  // }
  // static Future<List<DataDokumen>> getDataDokumenByIdMahasiswa(
  //     int idMahasiswa) async {
  //   final url = Uri.parse(
  //       "$baseUrl/get_data_dokumen_final.php?id_mahasiswa=$idMahasiswa");
  //   print("📤 Fetch Dokumen dari URL: $url");
  //   final response = await http.get(url);
  //   print("📥 Response Dokumen: ${response.body}");

  //   if (response.statusCode == 200) {
  //     final body = json.decode(response.body);
  //     if (body["success"] == true && body["data"] != null) {
  //       final List data = body["data"];
  //       return data.map((e) => DataDokumen.fromJson(e)).toList();
  //     } else {
  //       return [];
  //     }
  //   } else {
  //     throw Exception("Gagal koneksi ke server: ${response.statusCode}");
  //   }
  // }
}
