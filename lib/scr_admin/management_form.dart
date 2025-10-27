import 'package:flutter/material.dart';

class FormManagementPage extends StatefulWidget {
  const FormManagementPage({super.key});

  @override
  State<FormManagementPage> createState() => _FormManagementPageState();
}

class _FormManagementPageState extends State<FormManagementPage> {
  String activeTab = 'semua';
  String searchQuery = '';
  Set<int> expandedRows = {};
  Map<String, bool> expandedDetails = {};

  // Dropdown states
  String selectedJurusan = 'Jurusan Akutansi';
  String? selectedProdi;

  // Pagination states
  int currentPage = 1;
  int itemsPerPage = 20;

  // List of jurusan options
  final List<String> jurusanList = [
    'Jurusan Akutansi',
    'Jurusan Elektro',
    'Jurusan Teknik Listrik',
    'Jurusan Teknik Informatika',
  ];

  // List of prodi options for each jurusan
  final Map<String, List<String>> prodiByJurusan = {
    'Jurusan Akutansi': ['D4-ASP', 'D3-Akuntansi'],
    'Jurusan Elektro': [
      'D3-Teknik Listrik',
      'D4-Teknologi Rekayasa Sistem Elektronika'
    ],
    'Jurusan Teknik Listrik': ['D3-Teknik Listrik', 'D4-Teknik Listrik'],
    'Jurusan Teknik Informatika': ['D3-TIF', 'D4-TIF'],
  };

  final List<Map<String, dynamic>> formData = [
    {
      'id': 1,
      'nama': 'M.Zaky Pratama',
      'prodi': 'D4-ASP',
      'status': 'Belum Terverifikasi',
      'details': [
        {'name': 'Data', 'hasSubDetail': false},
        {'name': 'Data Pribadi', 'hasSubDetail': true},
        {'name': 'Data Akademik', 'hasSubDetail': true},
        {'name': 'Data Orang Tua', 'hasSubDetail': true},
        {'name': 'Dokumen', 'hasSubDetail': true},
      ],
      'formData': {
        'dataPribadi': {
          'namaLengkap': 'Muhammad Zaky Pratama',
          'nik': '1234567890123456',
          'tempatLahir': 'Jakarta',
          'tanggalLahir': '2000-01-15',
          'jenisKelamin': 'Laki-laki',
          'agama': 'Islam',
          'noHandphone': '081234567890',
          'email': 'zaky.pratama@email.com',
          'alamat': 'Jl. Sudirman No. 123',
          'provinsi': 'DKI Jakarta',
          'kota': 'Jakarta Selatan',
          'kodePos': '12190',
        },
        'dataAkademik': {
          'asalSekolah': 'SMAN 1 Jakarta',
          'tahunLulus': '2023',
          'jurusan': 'IPA',
          'prodi': 'D4-ASP',
          'nilaiRataRata': '85.5',
        },
        'dataOrangTua': {
          'namaAyah': 'Budi Pratama',
          'nikAyah': '3201234567890001',
          'pekerjaanAyah': 'Karyawan Swasta',
          'noTlpAyah': '081234567891',
          'alamatAyah': 'Jl. Sudirman No. 123',
          'penghasilanAyah': 'Rp 5.000.000',
          'namaIbu': 'Siti Aminah',
          'nikIbu': '3201234567890002',
          'pekerjaanIbu': 'Ibu Rumah Tangga',
          'noTlpIbu': '081234567892',
          'alamatIbu': 'Jl. Sudirman No. 123',
          'penghasilanIbu': 'Rp 2.000.000',
        },
        'dokumen': {
          'ktp': 'Sudah Upload',
          'ijazah': 'Sudah Upload',
          'akta': 'Sudah Upload',
          'kk': 'Sudah Upload',
          'foto': 'Sudah Upload',
        },
      },
    },
    {
      'id': 2,
      'nama': 'M.Pahmi',
      'prodi': 'D3-TIF',
      'status': 'Terverifikasi',
      'details': [
        {'name': 'Data', 'hasSubDetail': false},
        {'name': 'Data Pribadi', 'hasSubDetail': true},
        {'name': 'Data Orang Tua', 'hasSubDetail': true},
        {'name': 'Data Akademik', 'hasSubDetail': true},
        {'name': 'Dokumen', 'hasSubDetail': true},
      ],
      'formData': {
        'dataPribadi': {
          'namaLengkap': 'Muhammad Pahmi',
          'nik': '2345678901234567',
          'tempatLahir': 'Bandung',
          'tanggalLahir': '2001-05-20',
          'jenisKelamin': 'Laki-laki',
          'agama': 'Islam',
          'noHandphone': '081234567893',
          'email': 'pahmi@email.com',
          'alamat': 'Jl. Gatot Subroto No. 456',
          'provinsi': 'Jawa Barat',
          'kota': 'Bandung',
          'kodePos': '40111',
        },
        'dataAkademik': {
          'asalSekolah': 'SMAN 2 Bandung',
          'tahunLulus': '2022',
          'jurusan': 'IPA',
          'prodi': 'D3-TIF',
          'nilaiRataRata': '88.0',
        },
        'dataOrangTua': {
          'namaAyah': 'Ahmad Pahmi',
          'nikAyah': '3273123456789003',
          'pekerjaanAyah': 'PNS',
          'noTlpAyah': '081234567894',
          'alamatAyah': 'Jl. Gatot Subroto No. 456',
          'penghasilanAyah': 'Rp 7.000.000',
          'namaIbu': 'Rina Sari',
          'nikIbu': '3273123456789004',
          'pekerjaanIbu': 'Guru',
          'noTlpIbu': '081234567895',
          'alamatIbu': 'Jl. Gatot Subroto No. 456',
          'penghasilanIbu': 'Rp 4.000.000',
        },
        'dokumen': {
          'ktp': 'Sudah Upload',
          'ijazah': 'Sudah Upload',
          'akta': 'Sudah Upload',
          'kk': 'Sudah Upload',
          'foto': 'Sudah Upload',
        },
      },
    },
    {
      'id': 3,
      'nama': 'M.Pahmi',
      'prodi': 'D3-TIF',
      'status': 'Terverifikasi',
      'details': []
    },
    {
      'id': 4,
      'nama': 'M.Pahmi',
      'prodi': 'D3-TIF',
      'status': 'Terverifikasi',
      'details': []
    },
    {
      'id': 5,
      'nama': 'M.Pahmi',
      'prodi': 'D3-TIF',
      'status': 'Terverifikasi',
      'details': []
    },
    {
      'id': 6,
      'nama': 'M.Pahmi',
      'prodi': 'D3-TIF',
      'status': 'Terverifikasi',
      'details': []
    },
  ];

  List<Map<String, dynamic>> get filteredData {
    return formData.where((item) {
      final matchesSearch = item['nama']
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
      final matchesTab = activeTab == 'semua' ||
          (activeTab == 'terverifikasi' && item['status'] == 'Terverifikasi') ||
          (activeTab == 'belum' && item['status'] == 'Belum Terverifikasi');
      final matchesProdi =
          selectedProdi == null || item['prodi'] == selectedProdi;
      return matchesSearch && matchesTab && matchesProdi;
    }).toList();
  }

  // Get paginated data
  List<Map<String, dynamic>> get paginatedData {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    final data = filteredData;

    if (startIndex >= data.length) {
      return [];
    }

    return data.sublist(
      startIndex,
      endIndex > data.length ? data.length : endIndex,
    );
  }

  // Get total pages
  int get totalPages {
    return (filteredData.length / itemsPerPage).ceil();
  }

  // Change page
  void changePage(int page) {
    setState(() {
      if (page >= 1 && page <= totalPages) {
        currentPage = page;
      }
    });
  }

  void toggleRow(int id) {
    setState(() {
      if (expandedRows.contains(id)) {
        expandedRows.remove(id);
      } else {
        expandedRows.add(id);
      }
    });
  }

  void toggleDetail(String key) {
    setState(() {
      expandedDetails[key] = !(expandedDetails[key] ?? false);
    });
  }

  // Reset to page 1 when filter changes
  void resetPagination() {
    setState(() {
      currentPage = 1;
    });
  }

  Widget _buildFormDetailSection(
      String sectionName, Map<String, dynamic> item) {
    final formData = item['formData'] ?? {};
    Map<String, dynamic> sectionData = {};

    // Get section data based on section name
    switch (sectionName) {
      case 'Data Pribadi':
        sectionData = formData['dataPribadi'] ?? {};
        break;
      case 'Data Akademik':
        sectionData = formData['dataAkademik'] ?? {};
        break;
      case 'Data Orang Tua':
        sectionData = formData['dataOrangTua'] ?? {};
        break;
      case 'Dokumen':
        sectionData = formData['dokumen'] ?? {};
        break;
    }

    // Define field mappings for each section
    Map<String, String> fieldMappings = {};
    switch (sectionName) {
      case 'Data Pribadi':
        fieldMappings = {
          'namaLengkap': 'Nama Lengkap',
          'nik': 'NIK',
          'tempatLahir': 'Tempat Tanggal Lahir',
          'tanggalLahir': 'Tanggal Lahir',
          'jenisKelamin': 'Jenis Kelamin',
          'agama': 'Agama',
          'noHandphone': 'No Handphone',
          'email': 'Email',
          'alamat': 'Alamat',
          'provinsi': 'Provinsi',
          'kota': 'Kota',
          'kodePos': 'Kode Pos',
        };
        break;
      case 'Data Akademik':
        fieldMappings = {
          'asalSekolah': 'Asal Sekolah',
          'tahunLulus': 'Tahun Lulus',
          'jurusan': 'Jurusan',
          'prodi': 'Program Studi',
          'nilaiRataRata': 'Nilai Rata-rata',
        };
        break;
      case 'Data Orang Tua':
        fieldMappings = {
          'namaAyah': 'Nama Ayah',
          'nikAyah': 'NIK Ayah',
          'pekerjaanAyah': 'Pekerjaan Ayah',
          'noTlpAyah': 'No Telepon Ayah',
          'alamatAyah': 'Alamat Ayah',
          'penghasilanAyah': 'Penghasilan Ayah',
          'namaIbu': 'Nama Ibu',
          'nikIbu': 'NIK Ibu',
          'pekerjaanIbu': 'Pekerjaan Ibu',
          'noTlpIbu': 'No Telepon Ibu',
          'alamatIbu': 'Alamat Ibu',
          'penghasilanIbu': 'Penghasilan Ibu',
        };
        break;
      case 'Dokumen':
        fieldMappings = {
          'ktp': 'KTP',
          'ijazah': 'Ijazah',
          'akta': 'Akta Kelahiran',
          'kk': 'Kartu Keluarga',
          'foto': 'Foto',
        };
        break;
    }

    return Container(
      margin: const EdgeInsets.only(left: 0, top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fieldMappings.entries.map((entry) {
          final fieldKey = entry.key;
          final fieldLabel = entry.value;
          final fieldValue = sectionData[fieldKey] ?? '';

          // Special handling for "Tempat Tanggal Lahir"
          String displayValue = fieldValue;
          if (fieldKey == 'tempatLahir' &&
              sectionData['tanggalLahir'] != null) {
            displayValue =
                '${sectionData['tempatLahir']}, ${sectionData['tanggalLahir']}';
          }

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 160,
                  child: Text(
                    fieldLabel,
                    style: const TextStyle(
                      color: Color(0xFF163042),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    displayValue,
                    style: const TextStyle(
                      color: Color(0xFF163042),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                if (sectionName == 'Dokumen')
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: IconButton(
                      icon: const Icon(
                        Icons.visibility,
                        color: Color(0xFF3B82F6),
                        size: 20,
                      ),
                      onPressed: () =>
                          _showDocumentViewer(fieldLabel, fieldKey, item),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showDocumentViewer(String documentName, String documentType,
      Map<String, dynamic> studentData) {
    final formData = studentData['formData'] ?? {};
    final dataPribadi = formData['dataPribadi'] ?? {};
    final dataOrangTua = formData['dataOrangTua'] ?? {};

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getDocumentIcon(documentType),
                        color: const Color(0xFF3B82F6),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lihat Dokumen',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF163042),
                            ),
                          ),
                          Text(
                            documentName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                      color: const Color(0xFF6B7280),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Document Image Preview
                        Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _getDocumentIcon(documentType),
                                size: 80,
                                color: const Color(0xFF9CA3AF),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Preview $documentName',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF374151),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Foto dokumen ${documentName.toLowerCase()}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981)
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF10B981),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Dokumen Tersedia',
                                      style: TextStyle(
                                        color: Color(0xFF10B981),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Additional Information based on document type
                        if (documentType.toLowerCase() == 'ktp')
                          _buildKTPInfo(dataPribadi)
                        else if (documentType.toLowerCase() == 'kk')
                          _buildKKInfo(dataPribadi, dataOrangTua),
                        // Ijazah, Akta, dan Foto tidak menampilkan informasi tambahan
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Dokumen $documentName ditolak'),
                              backgroundColor: const Color(0xFFEF4444),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEF4444),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.close, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Tolak',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Dokumen $documentName diterima'),
                              backgroundColor: const Color(0xFF10B981),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Terima',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(
            ': ',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF6B7280),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF163042),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build KTP Information
  Widget _buildKTPInfo(Map<String, dynamic> dataPribadi) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.badge,
                  color: Color(0xFF3B82F6),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Informasi KTP',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF163042),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Nama Lengkap', dataPribadi['namaLengkap'] ?? '-'),
          _buildInfoRow('NIK', dataPribadi['nik'] ?? '-'),
          _buildInfoRow(
            'Tempat, Tgl Lahir',
            '${dataPribadi['tempatLahir'] ?? '-'}, ${dataPribadi['tanggalLahir'] ?? '-'}',
          ),
          _buildInfoRow('Jenis Kelamin', dataPribadi['jenisKelamin'] ?? '-'),
          _buildInfoRow('Alamat', dataPribadi['alamat'] ?? '-'),
          _buildInfoRow('Agama', dataPribadi['agama'] ?? '-'),
        ],
      ),
    );
  }

  // Build KK (Kartu Keluarga) Information
  Widget _buildKKInfo(
      Map<String, dynamic> dataPribadi, Map<String, dynamic> dataOrangTua) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.family_restroom,
                  color: Color(0xFF10B981),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Informasi Kartu Keluarga',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF163042),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Nama Siswa', dataPribadi['namaLengkap'] ?? '-'),
          const SizedBox(height: 12),
          const Text(
            'Data Orang Tua:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF163042),
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoRow('Nama Ayah', dataOrangTua['namaAyah'] ?? '-'),
          _buildInfoRow('NIK Ayah', dataOrangTua['nikAyah'] ?? '-'),
          _buildInfoRow('Pekerjaan Ayah', dataOrangTua['pekerjaanAyah'] ?? '-'),
          const SizedBox(height: 8),
          _buildInfoRow('Nama Ibu', dataOrangTua['namaIbu'] ?? '-'),
          _buildInfoRow('NIK Ibu', dataOrangTua['nikIbu'] ?? '-'),
          _buildInfoRow('Pekerjaan Ibu', dataOrangTua['pekerjaanIbu'] ?? '-'),
        ],
      ),
    );
  }

  IconData _getDocumentIcon(String documentType) {
    switch (documentType.toLowerCase()) {
      case 'foto':
        return Icons.photo;
      case 'ijazah':
        return Icons.school;
      case 'ktp':
        return Icons.badge;
      case 'skhu':
        return Icons.description;
      default:
        return Icons.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF475569),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Data Mahasiswa',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF475569),
              Color(0xFF64748B),
              Color(0xFF475569),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with Dropdown
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(0, 100, 116, 139),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedJurusan,
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: Color(0xFFFDE047)),
                            dropdownColor: const Color(0xFF475569),
                            style: const TextStyle(
                              color: Color(0xFFFDE047),
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                            items: jurusanList.map((String jurusan) {
                              return DropdownMenuItem<String>(
                                value: jurusan,
                                child: Text(jurusan),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedJurusan = newValue!;
                                selectedProdi =
                                    null; // Reset prodi when jurusan changes
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Search Bar (full width)
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search Here ....',
                      hintStyle: TextStyle(color: Color(0xFF64748B)),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      suffixIcon: Icon(Icons.search, color: Color(0xFF64748B)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Tabs with animated indicator
                Stack(
                  children: [
                    // Tab buttons
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildTab('semua', 'Semua'),
                          const SizedBox(width: 12),
                          _buildTab('terverifikasi', 'Terverifikasi'),
                          const SizedBox(width: 12),
                          _buildTab('belum', 'Belum Terverifikasi'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Prodi Filter Dropdown below navigation
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(0, 100, 116, 139),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedProdi,
                            isExpanded: true,
                            hint: const Text(
                              'Pilih Prodi',
                              style: TextStyle(
                                  color: Color(0xFFCBD5E1), fontSize: 13),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: Colors.white),
                            dropdownColor: const Color(0xFF475569),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            items: [
                              const DropdownMenuItem<String>(
                                value: null,
                                child: Text('Semua Prodi',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              ...?prodiByJurusan[selectedJurusan]
                                  ?.map((String prodi) {
                                return DropdownMenuItem<String>(
                                  value: prodi,
                                  child: Text(prodi),
                                );
                              }).toList(),
                            ],
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedProdi = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Show entries
                Align(
                  alignment: Alignment.centerRight,
                  // child: RichText(
                  //   text: const TextSpan(
                  //     style: TextStyle(color: Colors.white, fontSize: 12),
                  //     children: [
                  //       TextSpan(text: 'Show '),
                  //       WidgetSpan(
                  //         child: Padding(
                  //           padding: EdgeInsets.symmetric(horizontal: 4),
                  //           child: Text(
                  //             '10',
                  //             style: TextStyle(
                  //               backgroundColor: Colors.white,
                  //               color: Color(0xFF475569),
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),
                const SizedBox(height: 8),

                // Table with Fixed Header
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        // Fixed Table Header
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: const BoxDecoration(
                            color: Color(0xFF0F172A),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40,
                                child: Text(
                                  'No',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Nama',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Prodi',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Status',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Scrollable Table Body
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children:
                                  filteredData.asMap().entries.map((entry) {
                                final index = entry.key;
                                final item = entry.value;
                                final isExpanded =
                                    expandedRows.contains(item['id']);

                                return Column(
                                  children: [
                                    // Main Row
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF5F5F5),
                                        border: const Border(
                                          bottom: BorderSide(
                                            color: Color(0xFFE0E0E0),
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 40,
                                            child: Text(
                                              '${index + 1}',
                                              style: const TextStyle(
                                                color: Color(0xFF163042),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              item['nama'],
                                              style: const TextStyle(
                                                color: Color(0xFF163042),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              item['prodi'],
                                              style: const TextStyle(
                                                color: Color(0xFF163042),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    item['status'],
                                                    style: TextStyle(
                                                      color: item['status'] ==
                                                              'Terverifikasi'
                                                          ? const Color(
                                                              0xFF4ADE80)
                                                          : const Color(
                                                              0xFFEF4444),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                IconButton(
                                                  icon: Icon(
                                                    isExpanded
                                                        ? Icons
                                                            .keyboard_arrow_up
                                                        : Icons
                                                            .keyboard_arrow_down,
                                                    color:
                                                        const Color(0xFF6366F1),
                                                    size: 20,
                                                  ),
                                                  onPressed: () =>
                                                      toggleRow(item['id']),
                                                  padding: EdgeInsets.zero,
                                                  constraints:
                                                      const BoxConstraints(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Expanded Details
                                    if (isExpanded &&
                                        (item['details'] as List).isNotEmpty)
                                      Container(
                                        color: const Color(0xFFEEEEEE),
                                        padding: const EdgeInsets.only(
                                            left: 56,
                                            right: 16,
                                            top: 8,
                                            bottom: 8),
                                        child: Column(
                                          children: (item['details'] as List)
                                              .map<Widget>((detail) {
                                            final detailKey =
                                                '${item['id']}_${detail['name']}';
                                            final isDetailExpanded =
                                                expandedDetails[detailKey] ??
                                                    false;

                                            return Column(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        color:
                                                            Color(0xFFE0E0E0),
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          detail['name'],
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF163042),
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          if (!detail[
                                                              'hasSubDetail'])
                                                            const Text(
                                                              'Action',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF3B82F6),
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          if (detail[
                                                              'hasSubDetail'])
                                                            IconButton(
                                                              icon: Icon(
                                                                isDetailExpanded
                                                                    ? Icons
                                                                        .keyboard_arrow_up
                                                                    : Icons
                                                                        .keyboard_arrow_down,
                                                                color: const Color(
                                                                    0xFF163042),
                                                                size: 20,
                                                              ),
                                                              onPressed: () =>
                                                                  toggleDetail(
                                                                      detailKey),
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              constraints:
                                                                  const BoxConstraints(),
                                                            ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Sub-detail content (when expanded)
                                                if (isDetailExpanded &&
                                                    detail['hasSubDetail'])
                                                  _buildFormDetailSection(
                                                      detail['name'], item),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Footer Pagination
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      child: Text(
                        'Showing 1 to 6 entries',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            _buildPaginationButton('Previous', false),
                            const SizedBox(width: 4),
                            _buildPaginationButton('1', true),
                            const SizedBox(width: 4),
                            _buildPaginationButton('2', false),
                            const SizedBox(width: 4),
                            _buildPaginationButton('Next', false),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String value, String label) {
    final isActive = activeTab == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          activeTab = value;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : const Color(0xFFCBD5E1),
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: 3,
            width: isActive ? 60 : 0,
            decoration: BoxDecoration(
              color: const Color(0xFFFDE047),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationButton(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF3B82F6) : const Color(0xFF475569),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
