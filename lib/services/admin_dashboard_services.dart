// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminDashboardService {
  static const String baseUrl = 'http://44.220.144.82/api';

  /// Fetch dashboard data dari API menggunakan endpoint yang sudah ada
  Future<Map<String, dynamic>> fetchDashboardData() async {
    // Gunakan endpoint get_mahasiswa_admin.php yang sudah ada
    final url = Uri.parse('$baseUrl/get_mahasiswa_admin.php');

    try {
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      print("📡 Response Status: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        // Handle different response formats
        List<dynamic> mahasiswaList = [];

        if (jsonData is List) {
          mahasiswaList = jsonData;
        } else if (jsonData['success'] == true && jsonData['data'] != null) {
          mahasiswaList = jsonData['data'];
        } else if (jsonData['mahasiswa'] != null) {
          mahasiswaList = jsonData['mahasiswa'];
        }

        print("📊 Total mahasiswa: ${mahasiswaList.length}");

        // Hitung statistik dari data yang ada
        int lakiLakiCount = 0;
        int perempuanCount = 0;
        int jumlahTerverifikasi = 0;
        int jumlahBelumVerifikasi = 0;
        List<dynamic> unverifiedList = [];
        Map<String, int> distribusiJurusan = {};

        for (var mahasiswa in mahasiswaList) {
          // Count berdasarkan jenis kelamin - cek di formData juga
          String jenisKelamin = '';
          if (mahasiswa['formData'] != null &&
              mahasiswa['formData']['dataPribadi'] != null) {
            jenisKelamin =
                (mahasiswa['formData']['dataPribadi']['jenisKelamin'] ?? '')
                    .toString()
                    .toLowerCase();
          }

          if (jenisKelamin.contains('laki')) {
            lakiLakiCount++;
          } else if (jenisKelamin.contains('perempuan')) {
            perempuanCount++;
          }

          // Count berdasarkan status verifikasi
          final status =
              (mahasiswa['status'] ?? 'Belum Diverifikasi').toString();

          if (status.toLowerCase().contains('terverifikasi') &&
              !status.toLowerCase().contains('belum')) {
            jumlahTerverifikasi++;
          } else {
            jumlahBelumVerifikasi++;
            unverifiedList.add({
              'id_mahasiswa': mahasiswa['id_mahasiswa'] ?? mahasiswa['id'],
              'nama_mahasiswa': mahasiswa['nama'] ?? '-',
              'email': mahasiswa['formData']?['dataPribadi']?['email'] ?? '-',
              'jurusan': mahasiswa['jurusan'] ?? '-',
              'prodi': mahasiswa['kode_prodi'] ?? mahasiswa['prodi'] ?? '-',
              'status_verifikasi': status,
            });
          }

          // Hitung distribusi per jurusan
          final jurusan =
              (mahasiswa['jurusan'] ?? 'Belum Memilih Jurusan').toString();
          if (jurusan.isNotEmpty && jurusan != '-') {
            distribusiJurusan[jurusan] = (distribusiJurusan[jurusan] ?? 0) + 1;
          }
        }

        // Convert distribusi jurusan ke format yang diinginkan
        List<Map<String, dynamic>> distribusiJurusanList =
            distribusiJurusan.entries
                .map((entry) => {
                      'jurusan': entry.key,
                      'jumlah': entry.value,
                    })
                .toList();

        final result = {
          "jumlahMahasiswa": mahasiswaList.length,
          "lakiLakiCount": lakiLakiCount,
          "perempuanCount": perempuanCount,
          "jumlahTerverifikasi": jumlahTerverifikasi,
          "jumlahBelumVerifikasi": jumlahBelumVerifikasi,
          "unverified": unverifiedList,
          "distribusiJurusan": distribusiJurusanList,
          "allStudents": mahasiswaList,
        };

        print("✅ Processed data: $result");
        return result;
      } else {
        throw Exception(
          "Server error: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("❌ Error fetching dashboard data: $e");
      rethrow;
    }
  }

  /// Search mahasiswa berdasarkan nama atau filter lainnya
  Future<List<dynamic>> searchMahasiswa(
      String query, List<dynamic> allStudents) async {
    if (query.isEmpty) return allStudents;

    final lowerQuery = query.toLowerCase();
    return allStudents.where((student) {
      final nama = (student['nama_lengkap'] ?? '').toString().toLowerCase();
      final email = (student['email'] ?? '').toString().toLowerCase();
      final jurusan = (student['jurusan'] ?? '').toString().toLowerCase();
      final prodi = (student['kode_prodi'] ?? '').toString().toLowerCase();

      return nama.contains(lowerQuery) ||
          email.contains(lowerQuery) ||
          jurusan.contains(lowerQuery) ||
          prodi.contains(lowerQuery);
    }).toList();
  }
}
