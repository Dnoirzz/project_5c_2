class DataDokumen {
  final String idDokumen;
  final String jenisDokumen;
  final String namaFile;
  final String uploadFile; // base64 string
  final String statusVerifikasi;

  DataDokumen({
    required this.idDokumen,
    required this.jenisDokumen,
    required this.namaFile,
    required this.uploadFile,
    required this.statusVerifikasi,
  });

  factory DataDokumen.fromJson(Map<String, dynamic> json) {
    return DataDokumen(
      idDokumen: json['id_dokumen'],
      jenisDokumen: json['jenis_dokumen'],
      namaFile: json['nama_file'],
      uploadFile: json['upload_file'] ?? '',
      statusVerifikasi: json['status_verifikasi'],
    );
  }
}
