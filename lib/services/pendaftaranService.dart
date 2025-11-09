// // lib/services/pendaftaran_service.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class PendaftaranService {
//   static const String baseUrl = "http://44.220.144.82/api";

//   static Future<Map<String, dynamic>> submitPendaftaran(
//     Map<String, dynamic> formData,
//   ) async {
//     try {
//       // Ambil email dari SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       final email = prefs.getString('user_email');

//       if (email == null) {
//         return {
//           'success': false,
//           'message': 'Email tidak ditemukan. Silakan login ulang.',
//         };
//       }

//       // Prepare data pribadi
//       final dataPribadi = formData[0] ?? {};
//       final tanggalLahir = dataPribadi['tanggalLahir'];
//       final formattedTanggalLahir = tanggalLahir != null
//           ? DateTime.parse(tanggalLahir).toIso8601String().split('T')[0]
//           : '';

//       // Prepare data akademik
//       final dataAkademik = formData[1] ?? {};

//       // Extract jurusan and prodi IDs from saved objects
//       final jurusanData = dataAkademik['jurusan'];
//       final prodiData = dataAkademik['prodi'];

//       final idJurusan = jurusanData != null ? jurusanData['id_jurusan'] : 0;
//       final idProdi = prodiData != null ? prodiData['id_prodi'] : 0;

//       // Validasi
//       if (idJurusan == 0 || idProdi == 0) {
//         return {
//           'success': false,
//           'message': 'Jurusan dan Prodi harus dipilih',
//         };
//       }

//       // Prepare data orangtua
//       final dataOrangtua = formData[2] ?? {};

//       // Extract province/regency/district/village names
//       final province = dataPribadi['province'];
//       final regency = dataPribadi['regency'];
//       final district = dataPribadi['district'];
//       final village = dataPribadi['village'];

//       final provinceNama = province != null ? province['name'] : '';
//       final regencyNama = regency != null ? regency['name'] : '';
//       final districtNama = district != null ? district['name'] : '';
//       final villageNama = village != null ? village['name'] : '';

//       // Prepare request body
//       final requestBody = {
//         'email': email,
//         'data_pribadi': {
//           'nama_lengkap': dataPribadi['namaLengkap'] ?? '',
//           'nik': dataPribadi['nik'] ?? '',
//           'tempat_lahir': dataPribadi['tempatLahir'] ?? '',
//           'tanggal_lahir': formattedTanggalLahir,
//           'jenis_kelamin': dataPribadi['jenisKelamin'] ?? '',
//           'agama': dataPribadi['agama'] ?? '',
//           'no_hp': dataPribadi['noHp'] ?? '',
//           'alamat_mahasiswa': dataPribadi['alamat'] ?? '',
//           'provinsi': provinceNama,
//           'kabupaten': regencyNama,
//           'kecamatan': districtNama,
//           'kelurahan': villageNama,
//           'kode_pos': dataPribadi['kodePos'] ?? '',
//         },
//         'data_akademik': {
//           'asal_sekolah': dataAkademik['asalSekolah'] ?? '',
//           'tahun_lulus': dataAkademik['tahunLulus'] ?? '',
//           'nilai_rata_rata': dataAkademik['nilaiRata'] ?? '0',
//           'id_jurusan': idJurusan,
//           'id_prodi': idProdi,
//         },
//         'data_orangtua': {
//           'nama_ayah': dataOrangtua['namaAyah'] ?? '',
//           'nik_ayah': dataOrangtua['nikAyah'] ?? '',
//           'pekerjaan_ayah': dataOrangtua['pekerjaanAyah'] ?? '',
//           'penghasilan_ayah': dataOrangtua['penghasilanAyah'] ?? '',
//           'nohp_ayah': dataOrangtua['noTlpAyah'] ?? '',
//           'alamat_ayah': dataOrangtua['alamatAyah'] ?? '',
//           'nama_ibu': dataOrangtua['namaIbu'] ?? '',
//           'nik_ibu': dataOrangtua['nikIbu'] ?? '',
//           'pekerjaan_ibu': dataOrangtua['pekerjaanIbu'] ?? '',
//           'penghasilan_ibu': dataOrangtua['penghasilanIbu'] ?? '',
//           'nohp_ibu': dataOrangtua['noTlpIbu'] ?? '',
//           'alamat_ibu': dataOrangtua['alamatIbu'] ?? '',
//         },
//       };

//       print('📤 Sending data to server...');
//       print('📝 ID Jurusan: $idJurusan');
//       print('📝 ID Prodi: $idProdi');
//       print('📝 Request body: ${jsonEncode(requestBody)}');

//       // Send POST request
//       final url = Uri.parse("$baseUrl/submit_pendaftaran.php");
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(requestBody),
//       );

//       print('📥 Response status: ${response.statusCode}');
//       print('📥 Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);

//         if (responseData['success'] == true) {
//           // Clear draft data after successful submission
//           await _clearDraftData();

//           return {
//             'success': true,
//             'message': responseData['message'] ?? 'Pendaftaran berhasil!',
//           };
//         } else {
//           return {
//             'success': false,
//             'message': responseData['message'] ?? 'Pendaftaran gagal.',
//           };
//         }
//       } else {
//         return {
//           'success': false,
//           'message': 'Server error: ${response.statusCode}',
//         };
//       }
//     } catch (e) {
//       print('❌ Error in submitPendaftaran: $e');
//       return {
//         'success': false,
//         'message': 'Terjadi kesalahan: $e',
//       };
//     }
//   }

//   // Clear draft data after successful submission
//   static Future<void> _clearDraftData() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();

//       for (int i = 0; i < 5; i++) {
//         await prefs.remove('draft_formulir_page_$i');
//         await prefs.remove('draft_formulir_saved_$i');
//       }

//       print('✅ Draft data cleared');
//     } catch (e) {
//       print('⚠️ Error clearing draft: $e');
//     }
//   }
// }
// lib/services/pendaftaran_service.dart
// lib/services/pendaftaran_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PendaftaranService {
  static const String baseUrl = "http://44.220.144.82/api";

  static Future<Map<String, dynamic>> submitPendaftaran(
      Map<String, dynamic> formData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('user_email');

      if (email == null) {
        return {
          'success': false,
          'message': 'Email tidak ditemukan. Silakan login ulang.'
        };
      }

      final idJurusan = formData['id_jurusan'] ?? 0;
      final idProdi = formData['id_prodi'] ?? 0;
      if (idJurusan == 0 || idProdi == 0) {
        return {'success': false, 'message': 'Jurusan & Prodi harus dipilih'};
      }

      final requestBody = {
        'email': email,
        'data_pribadi': {
          'nama_lengkap': formData['nama_lengkap'] ?? '',
          'nik': formData['nik'] ?? '',
          'tempat_lahir': formData['tempat_lahir'] ?? '',
          'tanggal_lahir': formData['tanggal_lahir'] ?? '',
          'jenis_kelamin': formData['jenis_kelamin'] ?? '',
          'agama': formData['agama'] ?? '',
          'no_hp': formData['no_hp'] ?? '',
          'alamat_mahasiswa': formData['alamat'] ?? '',
          'provinsi': formData['province_name'] ?? '',
          'kabupaten': formData['regency_name'] ?? '',
          'kecamatan': formData['district_name'] ?? '',
          'kelurahan': formData['village_name'] ?? '',
          'kode_pos': formData['kode_pos'] ?? '',
        },
        'data_akademik': {
          'asal_sekolah': formData['asal_sekolah'] ?? '',
          'tahun_lulus': formData['tahun_lulus'] ?? '',
          'nilai_rata_rata': formData['nilai_rata'] ?? '0',
          'id_jurusan': idJurusan,
          'id_prodi': idProdi,
        },
        'data_orangtua': {
          'nama_ayah': formData['nama_ayah'] ?? '',
          'nik_ayah': formData['nik_ayah'] ?? '',
          'pekerjaan_ayah': formData['pekerjaan_ayah'] ?? '',
          'penghasilan_ayah': formData['penghasilan_ayah'] ?? '',
          'nohp_ayah': formData['no_tlp_ayah'] ?? '',
          'alamat_ayah': formData['alamat_ayah'] ?? '',
          'nama_ibu': formData['nama_ibu'] ?? '',
          'nik_ibu': formData['nik_ibu'] ?? '',
          'pekerjaan_ibu': formData['pekerjaan_ibu'] ?? '',
          'penghasilan_ibu': formData['penghasilan_ibu'] ?? '',
          'nohp_ibu': formData['no_tlp_ibu'] ?? '',
          'alamat_ibu': formData['alamat_ibu'] ?? '',
        },
        'dokumen': formData['dokumen'] ?? [],
      };

      final url = Uri.parse("$baseUrl/submit_pendaftaran.php");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Terjadi kesalahan: $e'};
    }
  }
}
