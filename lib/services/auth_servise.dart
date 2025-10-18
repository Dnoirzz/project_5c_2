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
}
