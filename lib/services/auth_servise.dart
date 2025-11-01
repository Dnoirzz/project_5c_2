import 'dart:convert';
import 'package:http/http.dart' as http;

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

    return json.decode(response.body);
  }

  //  Fungsi Register
  static Future<Map<String, dynamic>> register(
      String email, String password, String namaLengkap,
      [String role = "mahasiswa"]) async {
    var url = Uri.parse("$baseUrl/registrasii.php");
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
    var url = Uri.parse("$baseUrl/forgot_passworddd.php");
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
