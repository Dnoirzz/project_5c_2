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

    setState(() {});
    await _fetchDataMahasiswa();
  }

  Future<void> _fetchDataMahasiswa() async {
    try {
      final data =
          await dataMahasiswaService.getDataMahasiswaByEmail(userEmail);

      setState(() {
        _dataMahasiswa = data;
      });

      if (_dataMahasiswa != null) {
        await _fetchDataAkademik(_dataMahasiswa!.idMahasiswa);
        await _fetchDataOrangTua(_dataMahasiswa!.idMahasiswa);
        await _fetchDataDokumen(_dataMahasiswa!.idMahasiswa);
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        errorMessage = e.toString();
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
                      _buildCurrentTabContent(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildCurrentTabContent() {
    if (_dataMahasiswa == null) {
      return const Center(child: Text('Data tidak ditemukan'));
    }

    switch (_tabController.index) {
      case 0:
        return DataPribadiTab(
          dataPribadi: {
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
            ? const Center(child: Text('Data akademik belum tersedia'))
            : InformasiAkademikTab(dataAkademik: {
                'asal_sekolah': _dataAkademik![0].asalSekolah,
                'tahun_lulus': _dataAkademik![0].tahunLulus,
                'nilai_rata_rata': _dataAkademik![0].nilaiRataRata,
                'nama_jurusan': _dataAkademik![0].namaJurusan,
                'nama_prodi': _dataAkademik![0].namaProdi,
              });

      case 2:
        if (_dataOrangtua == null) {
          return const Center(child: Text('Data orang tua belum tersedia'));
        }
        return DataOrtuTab(dataOrangTua: {
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
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFF0E68C),
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: const Color(0xFFBDB76B), width: 1),
              ),
              child: const Text(
                'Status: Menunggu Verifikasi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
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
