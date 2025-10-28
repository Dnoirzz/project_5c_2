// class DataAkademik {
//   final int idAkademik;
//   final int idMahasiswa;
//   final int idJurusan;
//   final int idProdi;
//   final String asalSekolah;
//   final String tahunLulus;
//   final double nilaiRataRata;

//   DataAkademik({
//     required this.idAkademik,
//     required this.idMahasiswa,
//     required this.idJurusan,
//     required this.idProdi,
//     required this.asalSekolah,
//     required this.tahunLulus,
//     required this.nilaiRataRata,
//   });

//   factory DataAkademik.fromJson(Map<String, dynamic> json) {
//     return DataAkademik(
//       idAkademik: int.parse(json['id_akademik']),
//       idMahasiswa: int.parse(json['id_mahasiswa']),
//       idJurusan: int.parse(json['id_jurusan']),
//       idProdi: int.parse(json['id_prodi']),
//       asalSekolah: json['asal_sekolah'] ?? '',
//       tahunLulus: json['tahun_lulus'] ?? '',
//       nilaiRataRata: double.parse(json['nilai_rata_rata'] ?? '0'),
//     );
//   }
// }
class DataAkademik {
  final int idAkademik;
  final int idMahasiswa;
  final String namaJurusan;
  final String namaProdi;
  final String asalSekolah;
  final String tahunLulus;
  final String nilaiRataRata;

  // final String alamat;

  DataAkademik({
    required this.idAkademik,
    required this.idMahasiswa,
    required this.namaJurusan,
    required this.namaProdi,
    required this.asalSekolah,
    required this.tahunLulus,
    required this.nilaiRataRata,
  });

  factory DataAkademik.fromJson(Map<String, dynamic> json) {
    return DataAkademik(
      idAkademik: int.parse(json['id_akademik']),
      idMahasiswa: int.parse(json['id_mahasiswa']),
      namaJurusan: json['nama_jurusan'] ?? '',
      namaProdi: json['nama_prodi'] ?? '',
      asalSekolah: json['asal_sekolah'] ?? '',
      tahunLulus: json['tahun_lulus'] ?? '',
      nilaiRataRata: json['nilai_rata_rata'] ?? '',
    );
  }
}
