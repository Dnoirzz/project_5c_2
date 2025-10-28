class DataOrangtua {
  final int idOrangtua;
  final int idMahasiswa;
  final String namaAyah;
  final String nikAyah;
  final String pekerjaanAyah;
  final String noHpAyah;
  final String penghasilanAyah;
  final String alamatAyah;
  final String namaIbu;
  final String nikIbu;
  final String pekerjaanIbu;
  final String noHpIbu;
  final String penghasilanIbu;
  final String alamatIbu;

  DataOrangtua({
    required this.idOrangtua,
    required this.idMahasiswa,
    required this.namaAyah,
    required this.nikAyah,
    required this.pekerjaanAyah,
    required this.noHpAyah,
    required this.penghasilanAyah,
    required this.alamatAyah,
    required this.namaIbu,
    required this.nikIbu,
    required this.pekerjaanIbu,
    required this.noHpIbu,
    required this.penghasilanIbu,
    required this.alamatIbu,
  });

  factory DataOrangtua.fromJson(Map<String, dynamic> json) {
    return DataOrangtua(
      idOrangtua: int.parse(json['id_orangtua'].toString()),
      idMahasiswa: int.parse(json['id_mahasiswa'].toString()),
      namaAyah: json['nama_ayah'] ?? '',
      nikAyah: json['nik_ayah'].toString(),
      pekerjaanAyah: json['pekerjaan_ayah'] ?? '',
      noHpAyah: json['nohp_ayah'] ?? '',
      penghasilanAyah: json['penghasilan_ayah'] ?? '',
      alamatAyah: json['alamat_ayah'] ?? '',
      namaIbu: json['nama_ibu'] ?? '',
      nikIbu: json['nik_ibu'].toString(),
      pekerjaanIbu: json['pekerjaan_ibu'] ?? '',
      noHpIbu: json['nohp_ibu'] ?? '',
      penghasilanIbu: json['penghasilan_ibu'] ?? '',
      alamatIbu: json['alamat_ibu'] ?? '',
    );
  }

  // bool get isEmpty => null;
}
