import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminDashboardService {
  Future<Map<String, dynamic>> fetchDashboardData() async {
    final url = Uri.parse('http://44.220.144.82/api/admin_dashboard.php');

    try {
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer mysecretkey"},
      );

      print("=== RAW STRING RESPONSE ===");
      print(response.body);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        print("=== PARSED JSON DATA ===");
        print(jsonData);

        // Handle berbagai format response
        final List users =
            jsonData['data_mahasiswa_user'] ??
            jsonData['data'] ??
            jsonData['mahasiswa'] ??
            [];

        print("=== USERS COUNT ===");
        print("Total users: ${users.length}");

        final int totalMahasiswa =
            jsonData['total_mahasiswa'] ?? jsonData['total'] ?? users.length;

        final int lakiLakiCount =
            users
                .where(
                  (u) =>
                      (u['jenis_kelamin'] == "Laki-Laki" ||
                          u['jenis_kelamin'] == "Laki-laki" ||
                          u['jenis_kelamin'] == "LAKI-LAKI"),
                )
                .length;

        final int perempuanCount =
            users
                .where(
                  (u) =>
                      (u['jenis_kelamin'] == "Perempuan" ||
                          u['jenis_kelamin'] == "PEREMPUAN"),
                )
                .length;

        final int jumlahTerverifikasi =
            users
                .where(
                  (u) =>
                      (u['status_verifikasi'] == "Terverifikasi" ||
                          u['status_verifikasi'] == "Lulus Verifikasi" ||
                          u['status'] == "Terverifikasi"),
                )
                .length;

        final int jumlahBelumVerifikasi =
            users
                .where(
                  (u) =>
                      (u['status_verifikasi'] != "Terverifikasi" &&
                          u['status_verifikasi'] != "Lulus Verifikasi" &&
                          u['status'] != "Terverifikasi"),
                )
                .length;

        final List unverified =
            users
                .where(
                  (u) =>
                      (u['status_verifikasi'] == "Belum Diverifikasi" ||
                          u['status_verifikasi'] == "Belum Terverifikasi" ||
                          u['status_verifikasi'] == "Menunggu Verifikasi" ||
                          u['status'] == "Belum Diverifikasi"),
                )
                .toList();

        print("=== CALCULATED COUNTS ===");
        print("Total: $totalMahasiswa");
        print("Laki-laki: $lakiLakiCount");
        print("Perempuan: $perempuanCount");
        print("Terverifikasi: $jumlahTerverifikasi");
        print("Belum Verifikasi: $jumlahBelumVerifikasi");
        print("Unverified list: ${unverified.length}");

        return {
          "jumlahMahasiswa": totalMahasiswa,
          "lakiLakiCount": lakiLakiCount,
          "perempuanCount": perempuanCount,
          "jumlahTerverifikasi": jumlahTerverifikasi,
          "jumlahBelumVerifikasi": jumlahBelumVerifikasi,
          "unverified": unverified,
        };
      } else {
        throw Exception(
          "Server returned status code ${response.statusCode}: ${response.body}",
        );
      }
    } catch (e) {
      print("Error fetching dashboard data: $e");
      rethrow;
    }
  }
}
