class JurusanModel {
  final int idJurusan;
  final String kodeJurusan;
  final String namaJurusan;

  JurusanModel({
    required this.idJurusan,
    required this.kodeJurusan,
    required this.namaJurusan,
  });

  factory JurusanModel.fromJson(Map<String, dynamic> json) {
    return JurusanModel(
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
}
