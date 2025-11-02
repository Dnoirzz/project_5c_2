class DataAkademikModel {
  final int idAkademik;
  final int idMahasiswa;
  final int idJurusan;
  final int idProdi;
  final String asalSekolah;
  final String tahunLulus;
  final double nilaiRataRata;

  DataAkademikModel({
    required this.idAkademik,
    required this.idMahasiswa,
    required this.idJurusan,
    required this.idProdi,
    required this.asalSekolah,
    required this.tahunLulus,
    required this.nilaiRataRata,
  });

  factory DataAkademikModel.fromJson(Map<String, dynamic> json) {
    return DataAkademikModel(
      idAkademik: int.parse(json['id_akademik'].toString()),
      idMahasiswa: int.parse(json['id_mahasiswa'].toString()),
      idJurusan: int.parse(json['id_jurusan'].toString()),
      idProdi: int.parse(json['id_prodi'].toString()),
      asalSekolah: json['asal_sekolah'] ?? '',
      tahunLulus: json['tahun_lulus'].toString(),
      nilaiRataRata: double.tryParse(json['nilai_rata_rata'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_akademik': idAkademik,
      'id_mahasiswa': idMahasiswa,
      'id_jurusan': idJurusan,
      'id_prodi': idProdi,
      'asal_sekolah': asalSekolah,
      'tahun_lulus': tahunLulus,
      'nilai_rata_rata': nilaiRataRata,
    };
  }
}
