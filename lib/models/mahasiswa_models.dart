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
      id: json['id'] ?? 0,
      idMahasiswa: json['id_mahasiswa']?.toString() ?? '',
      nama: json['nama'] ?? '',
      prodi: json['prodi'] ?? '',
      kodeProdi: json['kode_prodi'] ?? '',
      jurusan: json['jurusan'] ?? '',
      kodeJurusan: json['kode_jurusan'] ?? '',
      status: json['status'] ?? 'Belum Terverifikasi',
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
      name: json['name'] ?? '',
      hasSubDetail: json['hasSubDetail'] ?? false,
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
      namaLengkap: json['namaLengkap'] ?? '',
      nik: json['nik'] ?? '',
      tempatLahir: json['tempatLahir'] ?? '',
      tanggalLahir: json['tanggalLahir'] ?? '',
      jenisKelamin: json['jenisKelamin'] ?? '',
      agama: json['agama'] ?? '',
      noHandphone: json['noHandphone'] ?? '',
      email: json['email'] ?? '',
      alamat: json['alamat'] ?? '',
      provinsi: json['provinsi'] ?? '',
      kota: json['kota'] ?? '',
      kodePos: json['kodePos'] ?? '',
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
      asalSekolah: json['asalSekolah'] ?? '',
      tahunLulus: json['tahunLulus'] ?? '',
      jurusan: json['jurusan'] ?? '',
      prodi: json['prodi'] ?? '',
      nilaiRataRata: json['nilaiRataRata'] ?? '',
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
      namaAyah: json['namaAyah'] ?? '',
      nikAyah: json['nikAyah'] ?? '',
      pekerjaanAyah: json['pekerjaanAyah'] ?? '',
      noTlpAyah: json['noTlpAyah'] ?? '',
      alamatAyah: json['alamatAyah'] ?? '',
      penghasilanAyah: json['penghasilanAyah'] ?? '',
      namaIbu: json['namaIbu'] ?? '',
      nikIbu: json['nikIbu'] ?? '',
      pekerjaanIbu: json['pekerjaanIbu'] ?? '',
      noTlpIbu: json['noTlpIbu'] ?? '',
      alamatIbu: json['alamatIbu'] ?? '',
      penghasilanIbu: json['penghasilanIbu'] ?? '',
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
      ktp: json['ktp'] ?? '',
      ijazah: json['ijazah'] ?? '',
      akta: json['akta'] ?? '',
      kk: json['kk'] ?? '',
      foto: json['foto'] ?? '',
    );
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