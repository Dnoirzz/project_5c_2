// class Pengumuman {
//   final String id;
//   final String judul;
//   final String isi;
//   final String gambar;
//   final String tanggal;

//   Pengumuman({
//     required this.id,
//     required this.judul,
//     required this.isi,
//     required this.gambar,
//     required this.tanggal,
//   });

//   factory Pengumuman.fromJson(Map<String, dynamic> json) {
//     return Pengumuman(
//       id: json['id_pengumuman'] ?? '',
//       judul: json['judul'] ?? '',
//       isi: json['isi'] ?? '',
//       gambar: json['upload_gambar'] ?? '',
//       tanggal: json['tanggal'] ?? '',
//     );
//   }
// }
// class Pengumuman {
//   final String id;
//   final String judul;
//   final String isi;
//   final String gambar;
//   final String tanggal;

//   Pengumuman({
//     required this.id,
//     required this.judul,
//     required this.isi,
//     required this.gambar,
//     required this.tanggal,
//   });

//   factory Pengumuman.fromJson(Map<String, dynamic> json) {
//     return Pengumuman(
//       id: json['id_pengumuman'] ?? '',
//       judul: json['judul'] ?? '',
//       isi: json['isi'] ?? '',
//       gambar: json['upload_gambar'] ?? '',
//       tanggal: json['tanggal'] ?? '',
//     );
//   }

//   // String get uploadGambar => null;
// }
class Pengumuman {
  final int id;
  final String judul;
  final String isi;
  final String gambar;
  final String tanggal;

  Pengumuman({
    required this.id,
    required this.judul,
    required this.isi,
    required this.gambar,
    required this.tanggal,
  });

  factory Pengumuman.fromJson(Map<String, dynamic> json) {
    return Pengumuman(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0, // Pakai 'id'
      judul: json['judul'] ?? '',
      isi: json['deskripsi'] ?? '', // Pakai 'deskripsi'
      gambar: json['upload_gambar'] ?? '',
      tanggal: json['tanggal'] ?? '',
    );
  }
}
