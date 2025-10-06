class Province {
  final String id;
  final String name;

  Province({required this.id, required this.name});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(id: json['id'] as String, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  @override
  String toString() => name;
}

class Regency {
  final String id;
  final String provinceId;
  final String name;

  Regency({required this.id, required this.provinceId, required this.name});

  factory Regency.fromJson(Map<String, dynamic> json) {
    return Regency(
      id: json['id'] as String,
      provinceId: json['province_id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'province_id': provinceId, 'name': name};
  }

  @override
  String toString() => name;
}

class District {
  final String id;
  final String regencyId;
  final String name;

  District({required this.id, required this.regencyId, required this.name});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'] as String,
      regencyId: json['regency_id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'regency_id': regencyId, 'name': name};
  }

  @override
  String toString() => name;
}

class Village {
  final String id;
  final String districtId;
  final String name;

  Village({required this.id, required this.districtId, required this.name});

  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(
      id: json['id'] as String,
      districtId: json['district_id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'district_id': districtId, 'name': name};
  }

  @override
  String toString() => name;
}
