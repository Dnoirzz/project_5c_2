import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_models.dart';

class UserService {
  final String baseUrl = "http://192.168.1.5/project_5c_2/backend/";

  /// Fetch all users from admin_dashboard.php
  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrl}admin_dashboard.php"),
        headers: {"Authorization": "Bearer mysecretkey"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // take only the "user" table
        final List<dynamic> usersData = jsonData["data"]["user"];

        return usersData.map((item) => UserModel.fromJson(item)).toList();
      } else {
        throw Exception("Failed to load users: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching users: $e");
    }
  }
}
