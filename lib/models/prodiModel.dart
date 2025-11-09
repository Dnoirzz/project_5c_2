// lib/models/prodi_model.dart
class Prodi {
  final int idProdi;
  final int idJurusan;
  final String kodeProdi;
  final String namaProdi;

  Prodi({
    required this.idProdi,
    required this.idJurusan,
    required this.kodeProdi,
    required this.namaProdi,
  });

  factory Prodi.fromJson(Map<String, dynamic> json) {
    return Prodi(
      idProdi: int.parse(json['id_prodi'].toString()),
      idJurusan: int.parse(json['id_jurusan'].toString()),
      kodeProdi: json['kode_prodi'] ?? '',
      namaProdi: json['nama_prodi'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_prodi': idProdi,
      'id_jurusan': idJurusan,
      'kode_prodi': kodeProdi,
      'nama_prodi': namaProdi,
    };
  }

  @override
  String toString() => namaProdi;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Prodi &&
          runtimeType == other.runtimeType &&
          idProdi == other.idProdi;

  @override
  int get hashCode => idProdi.hashCode;
}
