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
import 'dart:convert';
import '../../models/pengumuman_models.dart';
import 'package:http/http.dart' as http;

class PengumumanService {
  static const String baseUrl = "http://44.220.144.82/api";

  static Future<List<Pengumuman>> getSemuaPengumuman() async {
    final url = Uri.parse("$baseUrl/get_pengumuman_mahasiswa.php");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body["success"] == true) {
        final List data = body["data"];
        return data.map((e) => Pengumuman.fromJson(e)).toList();
      } else {
        throw Exception("Gagal: ${body["message"]}");
      }
    } else {
      throw Exception("Gagal memuat data pengumuman");
    }
  }
}
