import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  /// Simpan draft ke file JSON lokal
  static Future<Map<String, dynamic>> saveDraftLocal({
    required int userId,
    required int pageNumber,
    required Map<String, dynamic> formData,
  }) async {
    try {
      // Dapatkan directory untuk menyimpan file
      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          '${directory.path}/draft_user_${userId}_page_$pageNumber.json';
      final file = File(filePath);

      // Buat data dengan timestamp
      Map<String, dynamic> draftData = {
        'user_id': userId,
        'page_number': pageNumber,
        'form_data': formData,
        'saved_at': DateTime.now().toIso8601String(),
      };

      // Tulis ke file
      await file.writeAsString(jsonEncode(draftData));

      return {
        'status': 'success',
        'message': 'Draft berhasil disimpan secara lokal',
        'file_path': filePath,
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Gagal menyimpan draft: $e',
      };
    }
  }

  /// Ambil draft dari file JSON lokal
  static Future<Map<String, dynamic>> getDraftLocal({
    required int userId,
    required int pageNumber,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          '${directory.path}/draft_user_${userId}_page_$pageNumber.json';
      final file = File(filePath);

      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final data = jsonDecode(jsonString);

        return {
          'status': 'success',
          'data': data,
        };
      } else {
        return {
          'status': 'success',
          'message': 'Draft tidak ditemukan',
          'data': null,
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Gagal membaca draft: $e',
      };
    }
  }

  /// Ambil semua draft untuk user tertentu
  static Future<Map<int, Map<String, dynamic>>> loadAllDraftsLocal({
    required int userId,
  }) async {
    Map<int, Map<String, dynamic>> allDrafts = {};

    try {
      final directory = await getApplicationDocumentsDirectory();

      // Loop untuk setiap halaman (0-3)
      for (int i = 0; i < 4; i++) {
        final filePath = '${directory.path}/draft_user_${userId}_page_$i.json';
        final file = File(filePath);

        if (await file.exists()) {
          final jsonString = await file.readAsString();
          final data = jsonDecode(jsonString);
          allDrafts[i] = data['form_data'];
        }
      }

      return allDrafts;
    } catch (e) {
      print('Error loading drafts: $e');
      return {};
    }
  }

  /// Hapus draft lokal
  static Future<Map<String, dynamic>> deleteDraftLocal({
    required int userId,
    required int pageNumber,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          '${directory.path}/draft_user_${userId}_page_$pageNumber.json';
      final file = File(filePath);

      if (await file.exists()) {
        await file.delete();
        return {
          'status': 'success',
          'message': 'Draft berhasil dihapus',
        };
      } else {
        return {
          'status': 'success',
          'message': 'Draft tidak ditemukan',
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Gagal menghapus draft: $e',
      };
    }
  }

  /// Hapus semua draft user
  static Future<Map<String, dynamic>> deleteAllDraftsLocal({
    required int userId,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      int deletedCount = 0;

      for (int i = 0; i < 4; i++) {
        final filePath = '${directory.path}/draft_user_${userId}_page_$i.json';
        final file = File(filePath);

        if (await file.exists()) {
          await file.delete();
          deletedCount++;
        }
      }

      return {
        'status': 'success',
        'message': 'Berhasil menghapus $deletedCount draft',
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Gagal menghapus draft: $e',
      };
    }
  }

  /// Cek apakah ada draft lokal
  static Future<bool> hasDraftLocal({
    required int userId,
    required int pageNumber,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          '${directory.path}/draft_user_${userId}_page_$pageNumber.json';
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  /// Simpan semua draft sekaligus
  static Future<Map<String, dynamic>> saveAllDraftsLocal({
    required int userId,
    required Map<int, Map<String, dynamic>> allFormData,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      int savedCount = 0;

      // Loop untuk setiap halaman dan simpan
      for (int i = 0; i < 5; i++) {  // Changed to 5 to include all pages 0-4
        final formData = allFormData[i];
        if (formData != null && formData.isNotEmpty) {
          final filePath = '${directory.path}/draft_user_${userId}_page_$i.json';
          final file = File(filePath);

          // Buat data dengan timestamp
          Map<String, dynamic> draftData = {
            'user_id': userId,
            'page_number': i,
            'form_data': formData,
            'saved_at': DateTime.now().toIso8601String(),
          };

          // Tulis ke file
          await file.writeAsString(jsonEncode(draftData));
          savedCount++;
        }
      }

      return {
        'status': 'success',
        'message': 'Berhasil menyimpan $savedCount draft',
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Gagal menyimpan semua draft: $e',
      };
    }
  }

  /// Get info semua draft yang ada
  static Future<List<Map<String, dynamic>>> getDraftInfoLocal({
    required int userId,
  }) async {
    List<Map<String, dynamic>> draftInfo = [];

    try {
      final directory = await getApplicationDocumentsDirectory();

      for (int i = 0; i < 4; i++) {
        final filePath = '${directory.path}/draft_user_${userId}_page_$i.json';
        final file = File(filePath);

        if (await file.exists()) {
          final jsonString = await file.readAsString();
          final data = jsonDecode(jsonString);

          draftInfo.add({
            'page_number': i,
            'saved_at': data['saved_at'],
            'has_data':
                data['form_data'] != null && data['form_data'].isNotEmpty,
          });
        }
      }

      return draftInfo;
    } catch (e) {
      print('Error getting draft info: $e');
      return [];
    }
  }
}
