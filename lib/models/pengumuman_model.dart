class Pengumuman {
  String id;
  String judul;
  String isi;
  String tanggal;
  String? gambar;

  Pengumuman({
    required this.id,
    required this.judul,
    required this.isi,
    required this.tanggal,
    this.gambar,
  });
}
