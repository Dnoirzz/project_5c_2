import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://44.220.144.82/api";

  // Fungsi Login
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    var url = Uri.parse("$baseUrl/login.php");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    var data = json.decode(response.body);
    print(" Response Login: $data"); // debug

    if (data['status'] == 'success') {
      final prefs = await SharedPreferences.getInstance();
      final user = data['data'];

      //  Simpan semua data penting dari server
      await prefs.setInt('user_id', user['id_pengguna']);
      await prefs.setString('user_email', user['email']);
      await prefs.setString('user_nama_lengkap', user['nama_lengkap']);
      await prefs.setString('user_role', data['role'] ?? 'mahasiswa');
      await prefs.setBool('is_logged_in', true);

      print(' user_id tersimpan: ${prefs.getInt('user_id')}');
    } else {
      print(' Login gagal: ${data['message']}');
    }

    return data;
  }

  //  Fungsi Register
  static Future<Map<String, dynamic>> register(
      String email, String password, String namaLengkap,
      [String role = "mahasiswa"]) async {
    var url = Uri.parse("$baseUrl/registrasi.php");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
        "nama_lengkap": namaLengkap,
        "role": role,
      }),
    );

    return json.decode(response.body);
  }

  //  Fungsi Reset_password
//   static Future<Map<String, dynamic>> reset_password(
//       String email, String new_password) async {
//     var url = Uri.parse("$baseUrl/forgot_password_mahasiswa.php");
//     var response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "email": email,
//         "password": new_password,
//       }),
//     );

//     return json.decode(response.body);
//   }
// }
  static Future<Map<String, dynamic>> reset_Password(
      String email, String oldPassword, String newPassword) async {
    var url = Uri.parse("$baseUrl/reset_password_mahasiswa.php");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "old_password": oldPassword,
        "new_password": newPassword,
      }),
    );

    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> forgotPassword(
      String email, String newPassword) async {
    var url = Uri.parse("$baseUrl/forgot_password.php");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "new_password": newPassword,
      }),
    );
    return json.decode(response.body);
  }

  // Kirim OTP ke email
  static Future<Map<String, dynamic>> sendVerification(String email) async {
    var url = Uri.parse("$baseUrl/send_verification.php");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );
    return json.decode(response.body);
  }

// Verifikasi OTP
  static Future<Map<String, dynamic>> verifyOtp(
      String email, String otp) async {
    var url = Uri.parse("$baseUrl/verify_otp.php");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "otp": otp}),
    );
    return json.decode(response.body);
  }
}
