class DokumenModel {
  final int idDokumen;
  final int idMahasiswa;
  final String jenisDokumen;
  final String namaFile;
  final String formatFile;
  final String pathFile;
  final String tanggalUpload;
  final String statusVerifikasi;

  DokumenModel({
    required this.idDokumen,
    required this.idMahasiswa,
    required this.jenisDokumen,
    required this.namaFile,
    required this.formatFile,
    required this.pathFile,
    required this.tanggalUpload,
    required this.statusVerifikasi,
  });

  factory DokumenModel.fromJson(Map<String, dynamic> json) {
    return DokumenModel(
      idDokumen: int.parse(json['id_dokumen'].toString()),
      idMahasiswa: int.parse(json['id_mahasiswa'].toString()),
      jenisDokumen: json['jenis_dokumen'] ?? '',
      namaFile: json['nama_file'] ?? '',
      formatFile: json['format_file'] ?? '',
      pathFile: json['path_file'] ?? '',
      tanggalUpload: json['tanggal_upload'] ?? '',
      statusVerifikasi: json['status_verifikasi'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_dokumen': idDokumen,
      'id_mahasiswa': idMahasiswa,
      'jenis_dokumen': jenisDokumen,
      'nama_file': namaFile,
      'format_file': formatFile,
      'path_file': pathFile,
      'tanggal_upload': tanggalUpload,
      'status_verifikasi': statusVerifikasi,
    };
  }
}
