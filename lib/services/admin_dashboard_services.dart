import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminDashboardService {
  Future<Map<String, dynamic>> fetchDashboardData() async {
    final url = Uri.parse('http://44.220.144.82/api/admin_dashboard.php');

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer mysecretkey",
        },
      );

      print("=== RAW STRING RESPONSE ===");
      print(response.body);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        final List users = jsonData['data_mahasiswa_user'] ?? [];

        final int totalMahasiswa = jsonData['total_mahasiswa'] ?? 0;
        final int lakiLakiCount = users.where((u) => u['jenis_kelamin'] == "Laki-Laki").length;
        final int perempuanCount = users.where((u) => u['jenis_kelamin'] == "Perempuan").length;
        final int jumlahTerverifikasi = users.where((u) => u['status_verifikasi'] == "Terverifikasi").length;
        final int jumlahBelumVerifikasi = users.where((u) => u['status_verifikasi'] != "Terverifikasi").length;

        final List unverified = users.where((u) => u['status_verifikasi'] == "Belum Diverifikasi").toList();

        return {
          "jumlahMahasiswa": totalMahasiswa,
          "lakiLakiCount": lakiLakiCount,
          "perempuanCount": perempuanCount,
          "jumlahTerverifikasi": jumlahTerverifikasi,
          "jumlahBelumVerifikasi": jumlahBelumVerifikasi,
          "unverified": unverified,
        };
      } else {
        throw Exception("Server returned status code ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching dashboard data: $e");
      rethrow;
    }
  }
}
