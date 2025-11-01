class DataMahasiswa {
  final int idMahasiswa;
  final int idPengguna;
  final String namaLengkap;
  final String nik;
  final String tempatLahir;
  final String tanggalLahir;
  final String jenisKelamin;
  final String agama;
  final String noHp;
  final String email;
  final String alamatMahasiswa;
  final String namaProvinsi;
  final String namaKabupaten;
  final String namaKecamatan;
  final String namaKelurahan;
  final String kodePos;
  final String tanggalDaftar;

  // final String alamat;

  DataMahasiswa(
      {required this.idMahasiswa,
      required this.idPengguna,
      required this.namaLengkap,
      required this.nik,
      required this.tempatLahir,
      required this.tanggalLahir,
      required this.jenisKelamin,
      required this.agama,
      required this.noHp,
      required this.email,
      required this.alamatMahasiswa,
      required this.namaProvinsi,
      required this.namaKabupaten,
      required this.namaKecamatan,
      required this.namaKelurahan,
      required this.kodePos,
      required this.tanggalDaftar
      // required this.alamat,
      });

  factory DataMahasiswa.fromJson(Map<String, dynamic> json) {
    return DataMahasiswa(
      idMahasiswa: int.parse(json['id_mahasiswa']),
      idPengguna: int.parse(json['id_pengguna']),
      namaLengkap: json['nama_lengkap'] ?? '',
      nik: json['nik'] ?? '',
      tempatLahir: json['tempat_lahir'] ?? '',
      tanggalLahir: json['tanggal_lahir'] ?? '',
      jenisKelamin: json['jenis_kelamin'] ?? '',
      agama: json['agama'] ?? '',
      noHp: json['no_hp'] ?? '',
      email: json['email'] ?? '',
      alamatMahasiswa: json['alamat_mahasiswa'] ?? '',
      namaProvinsi: json['nama_provinsi'] ?? '',
      namaKabupaten: json['nama_kabupaten'] ?? '',
      namaKecamatan: json['nama_kecamatan'] ?? '',
      namaKelurahan: json['nama_kelurahan'] ?? '',
      kodePos: json['kode_pos'] ?? '',
      tanggalDaftar: json['tanggal_daftar'] ?? '',
    );
  }
}
