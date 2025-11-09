// lib/models/jurusan_model.dart
class Jurusan {
  final int idJurusan;
  final String kodeJurusan;
  final String namaJurusan;

  Jurusan({
    required this.idJurusan,
    required this.kodeJurusan,
    required this.namaJurusan,
  });

  factory Jurusan.fromJson(Map<String, dynamic> json) {
    return Jurusan(
      idJurusan: int.parse(json['id_jurusan'].toString()),
      kodeJurusan: json['kode_jurusan'] ?? '',
      namaJurusan: json['nama_jurusan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_jurusan': idJurusan,
      'kode_jurusan': kodeJurusan,
      'nama_jurusan': namaJurusan,
    };
  }

  @override
  String toString() => namaJurusan;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Jurusan &&
          runtimeType == other.runtimeType &&
          idJurusan == other.idJurusan;

  @override
  int get hashCode => idJurusan.hashCode;
}
