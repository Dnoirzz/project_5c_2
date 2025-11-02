class PengumumanModel {
  final int idPengumuman;
  final String judul;
  final String isi;
  final String uploadGambar;
  final String tanggal;

  PengumumanModel({
    required this.idPengumuman,
    required this.judul,
    required this.isi,
    required this.uploadGambar,
    required this.tanggal,
  });

  factory PengumumanModel.fromJson(Map<String, dynamic> json) {
    return PengumumanModel(
      idPengumuman: int.parse(json['id_pengumuman'].toString()),
      judul: json['judul'] ?? '',
      isi: json['isi'] ?? '',
      uploadGambar: json['upload_gambar'] ?? '',
      tanggal: json['tanggal'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pengumuman': idPengumuman,
      'judul': judul,
      'isi': isi,
      'upload_gambar': uploadGambar,
      'tanggal': tanggal,
    };
  }
}
