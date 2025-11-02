class ProdiModel {
  final int idProdi;
  final int idJurusan;
  final String kodeProdi;
  final String namaProdi;

  ProdiModel({
    required this.idProdi,
    required this.idJurusan,
    required this.kodeProdi,
    required this.namaProdi,
  });

  factory ProdiModel.fromJson(Map<String, dynamic> json) {
    return ProdiModel(
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
}
