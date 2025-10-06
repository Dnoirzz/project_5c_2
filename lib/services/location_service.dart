import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/location_models.dart';

class LocationService {
  static List<Province> _provinces = [];
  static List<Regency> _regencies = [];
  static List<District> _districts = [];
  static List<Village> _villages = [];

  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Load provinces
      final provincesData = await rootBundle.loadString(
        'assets/data/provinces_merged.json',
      );
      final List<dynamic> provincesJson = json.decode(provincesData);
      _provinces =
          provincesJson.map((json) => Province.fromJson(json)).toList();

      // Load regencies
      final regenciesData = await rootBundle.loadString(
        'assets/data/regencies_merged.json',
      );
      final List<dynamic> regenciesJson = json.decode(regenciesData);
      _regencies = regenciesJson.map((json) => Regency.fromJson(json)).toList();

      // Load districts
      final districtsData = await rootBundle.loadString(
        'assets/data/districts_merged.json',
      );
      final List<dynamic> districtsJson = json.decode(districtsData);
      _districts =
          districtsJson.map((json) => District.fromJson(json)).toList();

      // Load villages
      final villagesData = await rootBundle.loadString(
        'assets/data/villages_merged.json',
      );
      final List<dynamic> villagesJson = json.decode(villagesData);
      _villages = villagesJson.map((json) => Village.fromJson(json)).toList();

      _isInitialized = true;
    } catch (e) {
      print('Error loading location data: $e');
    }
  }

  static List<Province> searchProvinces(String query) {
    if (!_isInitialized) {
      return [];
    }

    if (query.isEmpty) return _provinces;
    final lowercaseQuery = query.toLowerCase();
    return _provinces
        .where(
          (province) => province.name.toLowerCase().contains(lowercaseQuery),
        )
        .toList();
  }

  static List<Regency> searchRegencies(String query, String? provinceId) {
    List<Regency> filteredRegencies = _regencies;

    if (provinceId != null) {
      filteredRegencies =
          _regencies
              .where((regency) => regency.provinceId == provinceId)
              .toList();
    }

    if (query.isEmpty) return filteredRegencies;

    return filteredRegencies
        .where(
          (regency) => regency.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  static List<District> searchDistricts(String query, String? regencyId) {
    List<District> filteredDistricts = _districts;

    if (regencyId != null) {
      filteredDistricts =
          _districts
              .where((district) => district.regencyId == regencyId)
              .toList();
    }

    if (query.isEmpty) return filteredDistricts;

    return filteredDistricts
        .where(
          (district) =>
              district.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  static List<Village> searchVillages(String query, String? districtId) {
    List<Village> filteredVillages = _villages;

    if (districtId != null) {
      filteredVillages =
          _villages
              .where((village) => village.districtId == districtId)
              .toList();
    }

    if (query.isEmpty) return filteredVillages;

    return filteredVillages
        .where(
          (village) => village.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  static Province? getProvinceById(String id) {
    try {
      return _provinces.firstWhere((province) => province.id == id);
    } catch (e) {
      return null;
    }
  }

  static Regency? getRegencyById(String id) {
    try {
      return _regencies.firstWhere((regency) => regency.id == id);
    } catch (e) {
      return null;
    }
  }

  static District? getDistrictById(String id) {
    try {
      return _districts.firstWhere((district) => district.id == id);
    } catch (e) {
      return null;
    }
  }

  static Village? getVillageById(String id) {
    try {
      return _villages.firstWhere((village) => village.id == id);
    } catch (e) {
      return null;
    }
  }
}
