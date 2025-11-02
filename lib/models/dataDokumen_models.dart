class DataDokumen {
  final int idDokumen;
  final int idMahasiswa;
  final String jenisDokumen;
  final String namaFile;
  final String formatFile;
  final String pathFile;
  final String tanggalUpload;
  final String statusVerifikasi;

  DataDokumen({
    required this.idDokumen,
    required this.idMahasiswa,
    required this.jenisDokumen,
    required this.namaFile,
    required this.formatFile,
    required this.pathFile,
    required this.tanggalUpload,
    required this.statusVerifikasi,
  });

  factory DataDokumen.fromJson(Map<String, dynamic> json) {
    return DataDokumen(
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
}
