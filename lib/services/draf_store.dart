import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DraftStorage {
  static Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();

    // ambil user_id dari SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id') ?? 0;

    // simpan per user
    return '${dir.path}/form_draft_user_$userId.json';
  }

  static Future<void> saveDraft(Map<String, dynamic> data) async {
    final path = await _getFilePath();
    final file = File(path);
    await file.writeAsString(jsonEncode(data));
  }

  static Future<Map<String, dynamic>?> loadDraft() async {
    final path = await _getFilePath();
    final file = File(path);
    if (await file.exists()) {
      final content = await file.readAsString();
      return jsonDecode(content);
    }
    return null;
  }

  static Future<void> clearDraft() async {
    final path = await _getFilePath();
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
