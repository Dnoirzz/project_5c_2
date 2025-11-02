class DataOrangtuaModel {
  final int idOrangtua;
  final int idMahasiswa;
  final String namaAyah;
  final String nikAyah;
  final String pekerjaanAyah;
  final String penghasilanAyah;
  final String nohpAyah;
  final String alamatAyah;
  final String namaIbu;
  final String nikIbu;
  final String pekerjaanIbu;
  final String penghasilanIbu;
  final String nohpIbu;
  final String alamatIbu;

  DataOrangtuaModel({
    required this.idOrangtua,
    required this.idMahasiswa,
    required this.namaAyah,
    required this.nikAyah,
    required this.pekerjaanAyah,
    required this.penghasilanAyah,
    required this.nohpAyah,
    required this.alamatAyah,
    required this.namaIbu,
    required this.nikIbu,
    required this.pekerjaanIbu,
    required this.penghasilanIbu,
    required this.nohpIbu,
    required this.alamatIbu,
  });

  factory DataOrangtuaModel.fromJson(Map<String, dynamic> json) {
    return DataOrangtuaModel(
      idOrangtua: int.parse(json['id_orangtua'].toString()),
      idMahasiswa: int.parse(json['id_mahasiswa'].toString()),
      namaAyah: json['nama_ayah'] ?? '',
      nikAyah: json['nik_ayah'] ?? '',
      pekerjaanAyah: json['pekerjaan_ayah'] ?? '',
      penghasilanAyah: json['penghasilan_ayah'] ?? '',
      nohpAyah: json['nohp_ayah'] ?? '',
      alamatAyah: json['alamat_ayah'] ?? '',
      namaIbu: json['nama_ibu'] ?? '',
      nikIbu: json['nik_ibu'] ?? '',
      pekerjaanIbu: json['pekerjaan_ibu'] ?? '',
      penghasilanIbu: json['penghasilan_ibu'] ?? '',
      nohpIbu: json['nohp_ibu'] ?? '',
      alamatIbu: json['alamat_ibu'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_orangtua': idOrangtua,
      'id_mahasiswa': idMahasiswa,
      'nama_ayah': namaAyah,
      'nik_ayah': nikAyah,
      'pekerjaan_ayah': pekerjaanAyah,
      'penghasilan_ayah': penghasilanAyah,
      'nohp_ayah': nohpAyah,
      'alamat_ayah': alamatAyah,
      'nama_ibu': namaIbu,
      'nik_ibu': nikIbu,
      'pekerjaan_ibu': pekerjaanIbu,
      'penghasilan_ibu': penghasilanIbu,
      'nohp_ibu': nohpIbu,
      'alamat_ibu': alamatIbu,
    };
  }
}
