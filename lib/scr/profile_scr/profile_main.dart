// ignore_for_file: avoid_print, deprecated_member_use

import 'package:SPMB/models/dataDokumen_models.dart';
import 'package:SPMB/models/dataOrangTua_models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/app_bar.dart';
import '../../models/dataPribadi_models.dart';
import '../../models/dataAkademik_models.dart';
import '../../services/profile_services.dart';
// import '../../services/dataAkademik_services.dart';

import 'data_pribadi_scr.dart';
import 'informasi_akademik_scr.dart';
import 'data_ortu_scr.dart';
import 'dokumen_scr.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({super.key});

  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String userName = '';
  String userEmail = '';

  DataMahasiswa? _dataMahasiswa;
  List<DataAkademik>? _dataAkademik;
  List<DataOrangtua>? _dataOrangtua;
  List<DataDokumen>? _dataDokumen;
  List<DataDokumen> dokumenUser = [];
  String statusText = 'Anda Belum Melakukan Pendaftaran';
  Color statusColor = const Color.fromARGB(255, 231, 231, 230);
  bool _isLoading = true;
  String? errorMessage;

  final List<String> _tabTitles = [
    'Data Pribadi',
    'Informasi Akademik',
    'Data Orang Tua',
    'Dokumen',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('user_nama_lengkap') ?? 'User';
    userEmail = prefs.getString('user_email') ?? 'email@example.com';

    // setState(() {});

    try {
      // Ambil data mahasiswa dulu
      final dataMahasiswa =
          await dataMahasiswaService.getDataMahasiswaByEmail(userEmail);

      // Ambil dokumen mahasiswa
      dokumenUser = await dataMahasiswaService
          .getDataDokumenByIdMahasiswa(dataMahasiswa.idMahasiswa);

      // Debug: lihat isi dokumen dan statusnya
      dokumenUser.forEach((d) {
        print(
            'Dokumen: ${d.jenisDokumen}, status raw: "${d.statusVerifikasi}"');
      });

      // Hitung status dokumen
      final status = getStatusDokumen(dokumenUser);
      setState(() {
        statusText = status['status'];
        statusColor = status['color'];
      });
    } catch (e) {
      print("Error load dokumen: $e");
    }
    await _fetchDataMahasiswa();
  }

  Map<String, dynamic> getStatusDokumen(List<DataDokumen> dokumenList) {
    if (dokumenList.any((d) =>
        d.statusVerifikasi.trim().toLowerCase() == 'ditolak verifikasi')) {
      return {'status': 'Tolak Verifikasi', 'color': Colors.red};
    } else if (dokumenList.every(
        (d) => d.statusVerifikasi.trim().toLowerCase() == 'lulus verifikasi')) {
      return {'status': 'Verifikasi', 'color': Colors.green};
    } else {
      return {'status': 'Menunggu Verifikasi', 'color': Colors.yellow.shade700};
    }
  }

  // Future<void> _fetchDataMahasiswa() async {
  //   try {
  //     final data =
  //         await dataMahasiswaService.getDataMahasiswaByEmail(userEmail);

  //     setState(() {
  //       _dataMahasiswa = data;
  //     });

  //     if (_dataMahasiswa != null) {
  //       await _fetchDataAkademik(_dataMahasiswa!.idMahasiswa);
  //       await _fetchDataOrangTua(_dataMahasiswa!.idMahasiswa);
  //       await _fetchDataDokumen(_dataMahasiswa!.idMahasiswa);
  //     }

  //     setState(() {
  //       _isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _isLoading = false;
  //       errorMessage = e.toString();
  //     });
  //   }
  // }

  Future<void> _fetchDataMahasiswa() async {
    try {
      final data =
          await dataMahasiswaService.getDataMahasiswaByEmail(userEmail);
      print("✅ Data Mahasiswa Ditemukan: ${data.idMahasiswa}");

      setState(() {
        _dataMahasiswa = data;
      });

      if (_dataMahasiswa != null) {
        await _fetchDataAkademik(_dataMahasiswa!.idMahasiswa);
        await _fetchDataOrangTua(_dataMahasiswa!.idMahasiswa);
        await _fetchDataDokumen(_dataMahasiswa!.idMahasiswa);
      }
    } catch (e) {
      // Jika data tidak ditemukan, kosongkan tanpa menampilkan error di layar
      if (e.toString().contains("Data mahasiswa tidak ditemukan")) {
        setState(() {
          _dataMahasiswa = null;
          _dataAkademik = [];
          _dataOrangtua = [];
          _dataDokumen = [];
          errorMessage = null;
        });
      } else {
        setState(() {
          errorMessage = e.toString();
        });
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchDataAkademik(int idMahasiswa) async {
    try {
      final data =
          await dataMahasiswaService.getDataAkademikByIdMahasiswa(idMahasiswa);
      setState(() {
        _dataAkademik = data;
      });
    } catch (e) {
      print('Error ambil data akademik: $e');
    }
  }

  Future<void> _fetchDataOrangTua(int idMahasiswa) async {
    try {
      final data =
          await dataMahasiswaService.getDataOrangTuaByIdMahasiswa(idMahasiswa);
      setState(() {
        _dataOrangtua = data;
      });
    } catch (e) {
      print('Error ambil data orang tua: $e');
    }
  }

  Future<void> _fetchDataDokumen(int idMahasiswa) async {
    try {
      final data =
          await dataMahasiswaService.getDataDokumenByIdMahasiswa(idMahasiswa);
      setState(() {
        _dataDokumen = data;
      });
    } catch (e) {
      print('Error ambil data dokumen: $e');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Profil Saya',
        showMenuButton: true,
        showProfileMenu: true,
        currentPage: 'profile',
      ),
      drawer: const AppDrawer(currentPage: 'profile'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildProfileHeader(),
                      _buildTabNavigation(),
                      if (errorMessage != null)
                        const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Data belum tersedia. Silakan lengkapi pendaftaran Anda.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      _buildCurrentTabContent(),
                      // _buildCurrentTabContent(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildCurrentTabContent() {
    switch (_tabController.index) {
      case 0:
        // case 0:
        //   if (_dataMahasiswa == null) {
        //     return const Center(
        //       child: Padding(
        //         padding: EdgeInsets.all(16),
        //         child: Text(
        //           'Data pribadi belum tersedia karena kamu belum melakukan pendaftaran.',
        //           textAlign: TextAlign.center,
        //           style: TextStyle(color: Colors.grey),
        //         ),
        //       ),
        //     );
        //   }

        // return DataPribadiTab(
        //   dataPribadi: {
        //     'nama_lengkap': _dataMahasiswa!.namaLengkap,
        //     'nik': _dataMahasiswa!.nik,
        //     'tempat_lahir': _dataMahasiswa!.tempatLahir,
        //     'tanggal_lahir': _dataMahasiswa!.tanggalLahir,
        //     'jenis_kelamin': _dataMahasiswa!.jenisKelamin,
        //     'agama': _dataMahasiswa!.agama,
        //     'no_hp': _dataMahasiswa!.noHp,
        //     'email': _dataMahasiswa!.email,
        //     'alamat': _dataMahasiswa!.alamatMahasiswa,
        //     'provinsi': _dataMahasiswa!.namaProvinsi,
        //     'kota': _dataMahasiswa!.namaKabupaten,
        //     'kecamatan': _dataMahasiswa!.namaKecamatan,
        //     'kelurahan': _dataMahasiswa!.namaKelurahan,
        //     'kode_pos': _dataMahasiswa!.kodePos,
        //   },
        // );

        // dataPribadi:
        // _dataMahasiswa == null
        //     ? {
        //         'nama_lengkap': '',
        //         'nik': '',
        //         'tempat_lahir': '',
        //         'tanggal_lahir': '',
        //         'jenis_kelamin': '',
        //         'agama': '',
        //         'no_hp': '',
        //         'email': '',
        //         'alamat': '',
        //         'provinsi': '',
        //         'kota': '',
        //         'kecamatan': '',
        //         'kelurahan': '',
        //         'kode_pos': '',
        //       }
        //     : (
        //         dataPribadi: {
        //           'nama_lengkap': _dataMahasiswa!.namaLengkap,
        //           'nik': _dataMahasiswa!.nik,
        //           'tempat_lahir': _dataMahasiswa!.tempatLahir,
        //           'tanggal_lahir': _dataMahasiswa!.tanggalLahir,
        //           'jenis_kelamin': _dataMahasiswa!.jenisKelamin,
        //           'agama': _dataMahasiswa!.agama,
        //           'no_hp': _dataMahasiswa!.noHp,
        //           'email': _dataMahasiswa!.email,
        //           'alamat': _dataMahasiswa!.alamatMahasiswa,
        //           'provinsi': _dataMahasiswa!.namaProvinsi,
        //           'kota': _dataMahasiswa!.namaKabupaten,
        //           'kecamatan': _dataMahasiswa!.namaKecamatan,
        //           'kelurahan': _dataMahasiswa!.namaKelurahan,
        //           'kode_pos': _dataMahasiswa!.kodePos,
        //         },
        //       );
        return DataPribadiTab(
          dataPribadi: _dataMahasiswa == null
              ? {
                  'nama_lengkap': '',
                  'nik': '',
                  'tempat_lahir': '',
                  'tanggal_lahir': '',
                  'jenis_kelamin': '',
                  'agama': '',
                  'no_hp': '',
                  'email': '',
                  'alamat': '',
                  'provinsi': '',
                  'kota': '',
                  'kecamatan': '',
                  'kelurahan': '',
                  'kode_pos': '',
                }
              : {
                  'nama_lengkap': _dataMahasiswa!.namaLengkap,
                  'nik': _dataMahasiswa!.nik,
                  'tempat_lahir': _dataMahasiswa!.tempatLahir,
                  'tanggal_lahir': _dataMahasiswa!.tanggalLahir,
                  'jenis_kelamin': _dataMahasiswa!.jenisKelamin,
                  'agama': _dataMahasiswa!.agama,
                  'no_hp': _dataMahasiswa!.noHp,
                  'email': _dataMahasiswa!.email,
                  'alamat': _dataMahasiswa!.alamatMahasiswa,
                  'provinsi': _dataMahasiswa!.namaProvinsi,
                  'kota': _dataMahasiswa!.namaKabupaten,
                  'kecamatan': _dataMahasiswa!.namaKecamatan,
                  'kelurahan': _dataMahasiswa!.namaKelurahan,
                  'kode_pos': _dataMahasiswa!.kodePos,
                },
        );
      case 1:
        return _dataAkademik == null || _dataAkademik!.isEmpty
            ? InformasiAkademikTab(dataAkademik: {
                'asal_sekolah': '',
                'tahun_lulus': '',
                'nilai_rata_rata': '',
                'nama_jurusan': '',
                'nama_prodi': '',
              })
            : InformasiAkademikTab(dataAkademik: {
                'asal_sekolah': _dataAkademik![0].asalSekolah,
                'tahun_lulus': _dataAkademik![0].tahunLulus,
                'nilai_rata_rata': _dataAkademik![0].nilaiRataRata,
                'nama_jurusan': _dataAkademik![0].namaJurusan,
                'nama_prodi': _dataAkademik![0].namaProdi,
              });

      case 2:
        return _dataOrangtua == null || _dataOrangtua!.isEmpty
            ? DataOrtuTab(dataOrangTua: {
                'nama_ayah': '',
                'nik_ayah': '',
                'pekerjaan_ayah': '',
                'nohp_ayah': '',
                'penghasilan_ayah': '',
                'alamat_ayah': '',
                'nama_ibu': '',
                'nik_ibu': '',
                'pekerjaan_ibu': '',
                'nohp_ibu': '',
                'penghasilan_ibu': '',
                'alamat_ibu': '',
              })
            : DataOrtuTab(dataOrangTua: {
                'nama_ayah': _dataOrangtua![0].namaAyah,
                'nik_ayah': _dataOrangtua![0].nikAyah,
                'pekerjaan_ayah': _dataOrangtua![0].pekerjaanAyah,
                'nohp_ayah': _dataOrangtua![0].noHpAyah,
                'penghasilan_ayah': _dataOrangtua![0].penghasilanAyah,
                'alamat_ayah': _dataOrangtua![0].alamatAyah,
                'nama_ibu': _dataOrangtua![0].namaIbu,
                'nik_ibu': _dataOrangtua![0].nikIbu,
                'pekerjaan_ibu': _dataOrangtua![0].pekerjaanIbu,
                'nohp_ibu': _dataOrangtua![0].noHpIbu,
                'penghasilan_ibu': _dataOrangtua![0].penghasilanIbu,
                'alamat_ibu': _dataOrangtua![0].alamatIbu,
              });

      case 3:
        // return const DokumenTab();
        return DokumenTab(dataDokumen: _dataDokumen ?? []);

      default:
        return const SizedBox();
    }
  }

  Widget _buildProfileHeader() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF263D4A),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[300]!, width: 2),
                ),
                child: const CircleAvatar(
                  backgroundColor: Color(0xFF6C7A89),
                  child: Icon(Icons.person, size: 40, color: Colors.white70),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      userEmail,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              //   decoration: BoxDecoration(
              //     color: const Color(0xFFF0E68C),
              //     borderRadius: BorderRadius.circular(3),
              //     border: Border.all(color: const Color(0xFFBDB76B), width: 1),
              //   ),
              //   child: Text(
              //     'Status: $statusText', // 'Status: Menunggu Verifikasi',
              //     style: const TextStyle(
              //       color: Colors.black,
              //       fontSize: 9,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
              // ),
              // Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Status: $statusText',
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabNavigation() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _tabItem(Icons.person, "Data Pribadi", 0),
          _tabItem(Icons.school, "Informasi Akademik", 1),
          _tabItem(Icons.family_restroom, "Data Orang Tua", 2),
          _tabItem(Icons.folder, "Dokumen", 3),
        ],
      ),
    );
  }

  Widget _tabItem(IconData icon, String title, int index) {
    bool active = _tabController.index == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _tabController.animateTo(index);
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: active ? const Color(0xFF4F6C7A) : Colors.grey.shade400,
                width: 2,
              ),
              color: Colors.white,
            ),
            child: Icon(
              icon,
              color: active ? const Color(0xFF4F6C7A) : Colors.grey[600],
              size: 20,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 60,
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: active ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
