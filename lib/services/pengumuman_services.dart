// // import 'dart:convert';
// // import '../../models/pengumuman_models.dart';
// // import 'package:http/http.dart' as http;

// // class PengumumanService {
// //   static const String baseUrl = "http://44.220.144.82/api";

// //   static Future<List<Pengumuman>> getSemuaPengumuman() async {
// //     final url = Uri.parse("$baseUrl/get_pengumuman.php");
// //     final response = await http.get(url);

// //     if (response.statusCode == 200) {
// //       final List data = json.decode(response.body);
// //       return data.map((e) => Pengumuman.fromJson(e)).toList();
// //     } else {
// //       throw Exception("Gagal memuat data pengumuman");
// //     }
// //   }

// //   static Future<List<Pengumuman>> getPengumumanDashboard() async {
// //     final url = Uri.parse("$baseUrl/get_pengumuman_dashboard.php");
// //     final response = await http.get(url);

// //     if (response.statusCode == 200) {
// //       final List data = json.decode(response.body);
// //       return data.map((e) => Pengumuman.fromJson(e)).toList();
// //     } else {
// //       throw Exception("Gagal memuat data pengumuman");
// //     }
// //   }

// // untuk dashboard
// // static Future<List<dynamic>> getPengumumanDashboard() async {
// //   final url = Uri.parse('$baseUrl/get_pengumuman_dashboard.php');
// //   final res = await http.get(url);
// //   if (res.statusCode == 200) return json.decode(res.body);
// //   throw Exception('Gagal memuat pengumuman dashboard');
// // }

// // // 🔹 untuk halaman daftar semua pengumuman
// // static Future<List<dynamic>> getSemuaPengumuman() async {
// //   final url = Uri.parse('$baseUrl/get_pengumuman.php');
// //   final res = await http.get(url);
// //   if (res.statusCode == 200) return json.decode(res.body);
// //   throw Exception('Gagal memuat semua pengumuman');
// // }
// // }
// import 'dart:convert';
// import '../../models/pengumuman_models.dart';
// import 'package:http/http.dart' as http;

// class PengumumanService {
//   static const String baseUrl = "http://44.220.144.82/api";

//   static Future<List<Pengumuman>> getSemuaPengumuman() async {
//     final url = Uri.parse("$baseUrl/get_pengumuman_mahasiswa.php");
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final body = json.decode(response.body);
//       if (body["success"] == true) {
//         final List data = body["data"];
//         return data.map((e) => Pengumuman.fromJson(e)).toList();
//       } else {
//         throw Exception("Gagal: ${body["message"]}");
//       }
//     } else {
//       throw Exception("Gagal memuat data pengumuman");
//     }
//   }
// }
// import 'dart:convert';
// import '../../models/pengumuman_models.dart';
// import 'package:http/http.dart' as http;

// class PengumumanService {
//   static const String baseUrl = "http://44.220.144.82/api";

//   static Future<List<Pengumuman>> getSemuaPengumuman() async {
//     final url = Uri.parse("$baseUrl/get_pengumuman_mahasiswa.php");
//     final response = await http.get(url);

// ignore_for_file: avoid_print

//     if (response.statusCode == 200) {
//       final body = json.decode(response.body);
//       if (body["success"] == true) {
//         final List data = body["data"];
//         return data.map((e) => Pengumuman.fromJson(e)).toList();
//       } else {
//         throw Exception("Gagal: ${body["message"]}");
//       }
//     } else {
//       throw Exception("Gagal memuat data pengumuman");
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pengumuman_models.dart';

class PengumumanService {
  static const String baseUrl = "http://44.220.144.82/api";

  static Future<List<Pengumuman>> getSemuaPengumuman() async {
    try {
      final res = await http.get(Uri.parse("$baseUrl/get_pengumuman.php"));

      if (res.statusCode == 200) {
        print("=== FULL RESPONSE ===");
        print(res.body);
        print("=== END RESPONSE ===");

        final body = jsonDecode(res.body);
        if (body['success'] == true && body['data'] != null) {
          final dataList = body['data'] as List;

          if (dataList.isNotEmpty) {
            print("=== SAMPLE ITEM ===");
            print(dataList[0]); // Print item pertama untuk lihat struktur
            print("=== END SAMPLE ===");
          }

          return dataList.map((e) => Pengumuman.fromJson(e)).toList();
        }
      }
      return [];
    } catch (e) {
      print("Error getSemuaPengumuman: $e");
      return [];
    }
  }
  // }

  static Future<bool> deletePengumuman(int id) async {
    try {
      if (id <= 0) {
        print("ERROR: ID tidak valid ($id)");
        return false;
      }

      print("Menghapus pengumuman dengan ID: $id");

      final response = await http.post(
        Uri.parse('$baseUrl/delete_pengumuman.php'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'id': id.toString(), // Ubah jadi 'id'
        },
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      print("Error deletePengumuman: $e");
      return false;
    }
  }

  static Future<bool> tambahPengumuman(Map<String, dynamic> data) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/tambah_pengumuman.php"),
        body: data,
      );
      final body = jsonDecode(res.body);
      return body['success'] == true;
    } catch (e) {
      print("Error tambahPengumuman: $e");
      return false;
    }
  }

  static Future<bool> updatePengumuman(
      int id, Map<String, dynamic> data) async {
    try {
      final Map<String, String> body = {
        'id_pengumuman': id.toString(),
        'judul': data['judul'],
        'deskripsi': data['deskripsi'],
      };

      if (data['gambar'] != null) {
        body['upload_gambar'] = data['gambar'];
      }

      final res = await http.post(
        Uri.parse("$baseUrl/edit_pengumuman_final.php"),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );

      print("Server response: ${res.body}"); // penting untuk debugging

      final bodyRes = jsonDecode(res.body);
      return bodyRes['success'] == true;
    } catch (e) {
      print("Error updatePengumuman: $e");
      return false;
    }
  }
}
