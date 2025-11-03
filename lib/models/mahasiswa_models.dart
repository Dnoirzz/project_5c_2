class Mahasiswa {
  final int id;
  final String idMahasiswa;
  final String nama;
  final String prodi;
  final String kodeProdi;
  final String jurusan;
  final String kodeJurusan;
  final String status;
  final List<Detail> details;
  final FormData? formData;

  Mahasiswa({
    required this.id,
    required this.idMahasiswa,
    required this.nama,
    required this.prodi,
    required this.kodeProdi,
    required this.jurusan,
    required this.kodeJurusan,
    required this.status,
    required this.details,
    this.formData,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      id: json['id'] is int ? json['id'] : (json['id'] != null ? int.tryParse(json['id'].toString()) ?? 0 : 0),
      idMahasiswa: json['id_mahasiswa']?.toString() ?? '',
      nama: json['nama']?.toString() ?? '',
      prodi: json['prodi']?.toString() ?? '',
      kodeProdi: json['kode_prodi']?.toString() ?? '',
      jurusan: json['jurusan']?.toString() ?? '',
      kodeJurusan: json['kode_jurusan']?.toString() ?? '',
      status: json['status']?.toString() ?? 'Belum Terverifikasi',
      details: (json['details'] as List?)
              ?.map((e) => Detail.fromJson(e))
              .toList() ??
          [],
      formData:
          json['formData'] != null ? FormData.fromJson(json['formData']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_mahasiswa': idMahasiswa,
      'nama': nama,
      'prodi': prodi,
      'kode_prodi': kodeProdi,
      'jurusan': jurusan,
      'kode_jurusan': kodeJurusan,
      'status': status,
      'details': details.map((e) => e.toJson()).toList(),
      'formData': formData?.toJson(),
    };
  }
}

class Detail {
  final String name;
  final bool hasSubDetail;

  Detail({
    required this.name,
    required this.hasSubDetail,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      name: json['name']?.toString() ?? '',
      hasSubDetail: json['hasSubDetail'] is bool 
          ? json['hasSubDetail'] 
          : (json['hasSubDetail']?.toString().toLowerCase() == 'true' || json['hasSubDetail'] == 1),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hasSubDetail': hasSubDetail,
    };
  }
}

class FormData {
  final DataPribadi? dataPribadi;
  final DataAkademik? dataAkademik;
  final DataOrangTua? dataOrangTua;
  final Dokumen? dokumen;

  FormData({
    this.dataPribadi,
    this.dataAkademik,
    this.dataOrangTua,
    this.dokumen,
  });

  factory FormData.fromJson(Map<String, dynamic> json) {
    return FormData(
      dataPribadi: json['dataPribadi'] != null
          ? DataPribadi.fromJson(json['dataPribadi'])
          : null,
      dataAkademik: json['dataAkademik'] != null
          ? DataAkademik.fromJson(json['dataAkademik'])
          : null,
      dataOrangTua: json['dataOrangTua'] != null
          ? DataOrangTua.fromJson(json['dataOrangTua'])
          : null,
      dokumen:
          json['dokumen'] != null ? Dokumen.fromJson(json['dokumen']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dataPribadi': dataPribadi?.toJson(),
      'dataAkademik': dataAkademik?.toJson(),
      'dataOrangTua': dataOrangTua?.toJson(),
      'dokumen': dokumen?.toJson(),
    };
  }
}

class DataPribadi {
  final String namaLengkap;
  final String nik;
  final String tempatLahir;
  final String tanggalLahir;
  final String jenisKelamin;
  final String agama;
  final String noHandphone;
  final String email;
  final String alamat;
  final String provinsi;
  final String kota;
  final String kodePos;

  DataPribadi({
    required this.namaLengkap,
    required this.nik,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.agama,
    required this.noHandphone,
    required this.email,
    required this.alamat,
    required this.provinsi,
    required this.kota,
    required this.kodePos,
  });

  factory DataPribadi.fromJson(Map<String, dynamic> json) {
    return DataPribadi(
      namaLengkap: json['namaLengkap']?.toString() ?? '',
      nik: json['nik']?.toString() ?? '',
      tempatLahir: json['tempatLahir']?.toString() ?? '',
      tanggalLahir: json['tanggalLahir']?.toString() ?? '',
      jenisKelamin: json['jenisKelamin']?.toString() ?? '',
      agama: json['agama']?.toString() ?? '',
      noHandphone: json['noHandphone']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      alamat: json['alamat']?.toString() ?? '',
      provinsi: json['provinsi']?.toString() ?? '',
      kota: json['kota']?.toString() ?? '',
      kodePos: json['kodePos']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'namaLengkap': namaLengkap,
      'nik': nik,
      'tempatLahir': tempatLahir,
      'tanggalLahir': tanggalLahir,
      'jenisKelamin': jenisKelamin,
      'agama': agama,
      'noHandphone': noHandphone,
      'email': email,
      'alamat': alamat,
      'provinsi': provinsi,
      'kota': kota,
      'kodePos': kodePos,
    };
  }
}

class DataAkademik {
  final String asalSekolah;
  final String tahunLulus;
  final String jurusan;
  final String prodi;
  final String nilaiRataRata;

  DataAkademik({
    required this.asalSekolah,
    required this.tahunLulus,
    required this.jurusan,
    required this.prodi,
    required this.nilaiRataRata,
  });

  factory DataAkademik.fromJson(Map<String, dynamic> json) {
    return DataAkademik(
      asalSekolah: json['asalSekolah']?.toString() ?? '',
      tahunLulus: json['tahunLulus']?.toString() ?? '',
      jurusan: json['jurusan']?.toString() ?? '',
      prodi: json['prodi']?.toString() ?? '',
      nilaiRataRata: json['nilaiRataRata']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'asalSekolah': asalSekolah,
      'tahunLulus': tahunLulus,
      'jurusan': jurusan,
      'prodi': prodi,
      'nilaiRataRata': nilaiRataRata,
    };
  }
}

class DataOrangTua {
  final String namaAyah;
  final String nikAyah;
  final String pekerjaanAyah;
  final String noTlpAyah;
  final String alamatAyah;
  final String penghasilanAyah;
  final String namaIbu;
  final String nikIbu;
  final String pekerjaanIbu;
  final String noTlpIbu;
  final String alamatIbu;
  final String penghasilanIbu;

  DataOrangTua({
    required this.namaAyah,
    required this.nikAyah,
    required this.pekerjaanAyah,
    required this.noTlpAyah,
    required this.alamatAyah,
    required this.penghasilanAyah,
    required this.namaIbu,
    required this.nikIbu,
    required this.pekerjaanIbu,
    required this.noTlpIbu,
    required this.alamatIbu,
    required this.penghasilanIbu,
  });

  factory DataOrangTua.fromJson(Map<String, dynamic> json) {
    return DataOrangTua(
      namaAyah: json['namaAyah']?.toString() ?? '',
      nikAyah: json['nikAyah']?.toString() ?? '',
      pekerjaanAyah: json['pekerjaanAyah']?.toString() ?? '',
      noTlpAyah: json['noTlpAyah']?.toString() ?? '',
      alamatAyah: json['alamatAyah']?.toString() ?? '',
      penghasilanAyah: json['penghasilanAyah']?.toString() ?? '',
      namaIbu: json['namaIbu']?.toString() ?? '',
      nikIbu: json['nikIbu']?.toString() ?? '',
      pekerjaanIbu: json['pekerjaanIbu']?.toString() ?? '',
      noTlpIbu: json['noTlpIbu']?.toString() ?? '',
      alamatIbu: json['alamatIbu']?.toString() ?? '',
      penghasilanIbu: json['penghasilanIbu']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'namaAyah': namaAyah,
      'nikAyah': nikAyah,
      'pekerjaanAyah': pekerjaanAyah,
      'noTlpAyah': noTlpAyah,
      'alamatAyah': alamatAyah,
      'penghasilanAyah': penghasilanAyah,
      'namaIbu': namaIbu,
      'nikIbu': nikIbu,
      'pekerjaanIbu': pekerjaanIbu,
      'noTlpIbu': noTlpIbu,
      'alamatIbu': alamatIbu,
      'penghasilanIbu': penghasilanIbu,
    };
  }
}

// Model untuk tabel dokumen di database
class DokumenItem {
  final int idDokumen;
  final int idMahasiswa;
  final String jenisDokumen;
  final String namaFile;
  final String formatFile;
  final String pathFile;
  final String? tanggalUpload;
  final String statusVerifikasi; // 'Menunggu Verifikasi', 'Lulus Verifikasi', 'Ditolak Verifikasi'

  DokumenItem({
    required this.idDokumen,
    required this.idMahasiswa,
    required this.jenisDokumen,
    required this.namaFile,
    required this.formatFile,
    required this.pathFile,
    this.tanggalUpload,
    required this.statusVerifikasi,
  });

  factory DokumenItem.fromJson(Map<String, dynamic> json) {
    return DokumenItem(
      idDokumen: json['id_dokumen'] is int 
          ? json['id_dokumen'] 
          : (json['id_dokumen'] != null ? int.tryParse(json['id_dokumen'].toString()) ?? 0 : 0),
      idMahasiswa: json['id_mahasiswa'] is int 
          ? json['id_mahasiswa'] 
          : (json['id_mahasiswa'] != null ? int.tryParse(json['id_mahasiswa'].toString()) ?? 0 : 0),
      jenisDokumen: json['jenis_dokumen']?.toString() ?? '',
      namaFile: json['nama_file']?.toString() ?? '',
      formatFile: json['format_file']?.toString() ?? '',
      pathFile: json['path_file']?.toString() ?? '',
      tanggalUpload: json['tanggal_upload']?.toString(),
      statusVerifikasi: json['status_verifikasi']?.toString() ?? 'Menunggu Verifikasi',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_dokumen': idDokumen,
      'id_mahasiswa': idMahasiswa,
      'jenis_dokumen': jenisDokumen,
      'nama_file': namaFile,
      'format_file': formatFile,
      'path_file': pathFile,
      'tanggal_upload': tanggalUpload,
      'status_verifikasi': statusVerifikasi,
    };
  }
}

// Model untuk compatibility dengan struktur formData lama
class Dokumen {
  final String ktp;
  final String ijazah;
  final String akta;
  final String kk;
  final String foto;

  Dokumen({
    required this.ktp,
    required this.ijazah,
    required this.akta,
    required this.kk,
    required this.foto,
  });

  factory Dokumen.fromJson(Map<String, dynamic> json) {
    return Dokumen(
      ktp: json['ktp']?.toString() ?? '',
      ijazah: json['ijazah']?.toString() ?? '',
      akta: json['akta']?.toString() ?? '',
      kk: json['kk']?.toString() ?? '',
      foto: json['foto']?.toString() ?? '',
    );
  }

  // Factory untuk membuat Dokumen dari list DokumenItem
  factory Dokumen.fromDokumenItems(List<DokumenItem> dokumenItems) {
    String getStatus(String jenis) {
      final item = dokumenItems.firstWhere(
        (d) => _normalizeJenisDokumen(d.jenisDokumen) == jenis.toLowerCase(),
        orElse: () => DokumenItem(
          idDokumen: 0,
          idMahasiswa: 0,
          jenisDokumen: '',
          namaFile: '',
          formatFile: '',
          pathFile: '',
          statusVerifikasi: 'Belum Upload',
        ),
      );
      
      // Convert status_verifikasi ke format yang digunakan di UI
      if (item.statusVerifikasi == 'Lulus Verifikasi') {
        return 'Diterima';
      } else if (item.statusVerifikasi == 'Ditolak Verifikasi') {
        return 'Ditolak';
      } else if (item.statusVerifikasi == 'Menunggu Verifikasi') {
        return 'Sudah Upload';
      } else {
        return 'Belum Upload';
      }
    }

    return Dokumen(
      ktp: getStatus('ktp'),
      ijazah: getStatus('ijazah'),
      akta: getStatus('akta'),
      kk: getStatus('kk'),
      foto: getStatus('foto'),
    );
  }

  // Helper untuk normalize jenis dokumen
  static String _normalizeJenisDokumen(String jenis) {
    final jenisLower = jenis.toLowerCase();
    if (jenisLower.contains('ktp') || jenisLower.contains('kartu tanda penduduk')) {
      return 'ktp';
    } else if (jenisLower.contains('ijazah') || jenisLower.contains('skl')) {
      return 'ijazah';
    } else if (jenisLower.contains('akta')) {
      return 'akta';
    } else if (jenisLower.contains('kartu keluarga') || jenisLower.contains('kk')) {
      return 'kk';
    } else if (jenisLower.contains('foto') || jenisLower.contains('pas foto')) {
      return 'foto';
    }
    return jenisLower;
  }

  Map<String, dynamic> toJson() {
    return {
      'ktp': ktp,
      'ijazah': ijazah,
      'akta': akta,
      'kk': kk,
      'foto': foto,
    };
  }
}