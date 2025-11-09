import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminDashboardService {
  static const String baseUrl = "http://44.220.144.82/api";
  
  /// Fetch dashboard data dari API
  Future<Map<String, dynamic>> fetchDashboardData() async {
    try {
      final url = Uri.parse("$baseUrl/admin_dashboard.php");
      
      print("📊 Fetching dashboard data from: $url");
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print("📊 Response status: ${response.statusCode}");
      print("📊 Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['success'] == true) {
          // Validasi dan return data
          return {
            'jumlahMahasiswa': data['jumlahMahasiswa'] ?? 0,
            'lakiLakiCount': data['lakiLakiCount'] ?? 0,
            'perempuanCount': data['perempuanCount'] ?? 0,
            'jumlahTerverifikasi': data['jumlahTerverifikasi'] ?? 0,
            'jumlahBelumVerifikasi': data['jumlahBelumVerifikasi'] ?? 0,
            'distribusiJurusan': data['distribusiJurusan'] ?? [],
            'unverified': data['unverified'] ?? [], // 5 terbaru
            'unverifiedAll': data['unverifiedAll'] ?? [], // Semua data
            'allStudents': data['allStudents'] ?? [],
          };
        } else {
          throw Exception(data['message'] ?? 'Gagal memuat data dashboard');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ Error in fetchDashboardData: $e");
      rethrow;
    }
  }

  /// Get detail mahasiswa by ID
  Future<Map<String, dynamic>> getMahasiswaDetail(int idMahasiswa) async {
    try {
      final url = Uri.parse("$baseUrl/get_mahasiswa_detail.php?id_mahasiswa=$idMahasiswa");
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['success'] == true) {
          return data['data'];
        } else {
          throw Exception(data['message'] ?? 'Mahasiswa tidak ditemukan');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ Error getting mahasiswa detail: $e");
      rethrow;
    }
  }

  /// Update status verifikasi dokumen
  Future<bool> updateStatusVerifikasi({
    required int idDokumen,
    required String status,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/update_status_verifikasi.php");
      
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id_dokumen': idDokumen,
          'status_verifikasi': status,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      print("❌ Error updating status: $e");
      return false;
    }
  }

  /// Get statistik dashboard (alternatif untuk summary card)
  Future<Map<String, int>> getStatistikSummary() async {
    try {
      final data = await fetchDashboardData();
      
      return {
        'total': data['jumlahMahasiswa'] ?? 0,
        'laki': data['lakiLakiCount'] ?? 0,
        'perempuan': data['perempuanCount'] ?? 0,
        'verified': data['jumlahTerverifikasi'] ?? 0,
        'unverified': data['jumlahBelumVerifikasi'] ?? 0,
      };
    } catch (e) {
      print("❌ Error getting statistik: $e");
      return {
        'total': 0,
        'laki': 0,
        'perempuan': 0,
        'verified': 0,
        'unverified': 0,
      };
    }
  }
}