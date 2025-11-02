class MahasiswaModel {
  final int idMahasiswa;
  final int idPengguna;
  final String namaLengkap;
  final String nik;
  final String tempatLahir;
  final String tanggalLahir;
  final String jenisKelamin;
  final String agama;
  final String noHp;
  final String email1;
  final String alamatMahasiswa;
  final int? idProvinsi;
  final int? idKabupaten;
  final int? idKecamatan;
  final int? idKelurahan;
  final String kodePos;
  final String tanggalDaftar;
  final String statusVerifikasi;
  final String? catatanAdmin;
  final String statusPendaftaran;

  MahasiswaModel({
    required this.idMahasiswa,
    required this.idPengguna,
    required this.namaLengkap,
    required this.nik,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.agama,
    required this.noHp,
    required this.email1,
    required this.alamatMahasiswa,
    this.idProvinsi,
    this.idKabupaten,
    this.idKecamatan,
    this.idKelurahan,
    required this.kodePos,
    required this.tanggalDaftar,
    required this.statusVerifikasi,
    this.catatanAdmin,
    required this.statusPendaftaran,
  });

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaModel(
      idMahasiswa: int.parse(json['id_mahasiswa'].toString()),
      idPengguna: int.parse(json['id_pengguna'].toString()),
      namaLengkap: json['nama_lengkap'] ?? '',
      nik: json['nik'] ?? '',
      tempatLahir: json['tempat_lahir'] ?? '',
      tanggalLahir: json['tanggal_lahir'] ?? '',
      jenisKelamin: json['jenis_kelamin'] ?? '',
      agama: json['agama'] ?? '',
      noHp: json['no_hp'] ?? '',
      email1: json['email1'] ?? '',
      alamatMahasiswa: json['alamat_mahasiswa'] ?? '',
      idProvinsi: json['id_provinsi'] != null ? int.tryParse(json['id_provinsi'].toString()) : null,
      idKabupaten: json['id_kabupaten'] != null ? int.tryParse(json['id_kabupaten'].toString()) : null,
      idKecamatan: json['id_kecamatan'] != null ? int.tryParse(json['id_kecamatan'].toString()) : null,
      idKelurahan: json['id_kelurahan'] != null ? int.tryParse(json['id_kelurahan'].toString()) : null,
      kodePos: json['kode_pos'] ?? '',
      tanggalDaftar: json['tanggal_daftar'] ?? '',
      statusVerifikasi: json['status_verifikasi'] ?? '',
      catatanAdmin: json['catatan_admin'] ?? '',
      statusPendaftaran: json['status_pendaftaran'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_mahasiswa': idMahasiswa,
      'id_pengguna': idPengguna,
      'nama_lengkap': namaLengkap,
      'nik': nik,
      'tempat_lahir': tempatLahir,
      'tanggal_lahir': tanggalLahir,
      'jenis_kelamin': jenisKelamin,
      'agama': agama,
      'no_hp': noHp,
      'email1': email1,
      'alamat_mahasiswa': alamatMahasiswa,
      'id_provinsi': idProvinsi,
      'id_kabupaten': idKabupaten,
      'id_kecamatan': idKecamatan,
      'id_kelurahan': idKelurahan,
      'kode_pos': kodePos,
      'tanggal_daftar': tanggalDaftar,
      'status_verifikasi': statusVerifikasi,
      'catatan_admin': catatanAdmin,
      'status_pendaftaran': statusPendaftaran,
    };
  }
}
