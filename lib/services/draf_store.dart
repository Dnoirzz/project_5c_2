// lib/utils/draft_storage.dart
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class DraftStorage {
  static Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/form_draft.json';
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
