import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';
import 'data_pribadi_page.dart';
import 'data_akademik_page.dart';
import 'data_ortu_page.dart';
import 'upload_dokumen_page.dart';
import 'review_submit_page.dart';
import '../../services/local_storage_service.dart';
import '../../services/formulir_service.dart';

class FormulirPendaftaranMain extends StatefulWidget {
  const FormulirPendaftaranMain({super.key});

  @override
  State<FormulirPendaftaranMain> createState() =>
      _FormulirPendaftaranMainState();
}

class _FormulirPendaftaranMainState extends State<FormulirPendaftaranMain> {
  int _currentPage = 0;
  final ScrollController _scrollController = ScrollController();

  // Track which pages have been saved
  final Map<int, bool> _pagesSaved = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
  };

  // Store form data for each page
  final Map<int, Map<String, dynamic>> _formData = {};

  @override
  void initState() {
    super.initState();
    // Initialize form data for each page
    for (int i = 0; i < 5; i++) {
      _formData[i] = {};
    }

    //  LOAD DRAFT DARI FILE JSON SAAT BUKA FORMULIR
    _loadLocalDrafts();
  }

  // FUNGSI LOAD DRAFT DARI FILE JSON
  Future<void> _loadLocalDrafts() async {
    int userId = 1;

    final drafts = await LocalStorageService.loadAllDraftsLocal(userId: userId);

    if (drafts.isNotEmpty && mounted) {
      setState(() {
        drafts.forEach((pageNum, data) {
          _formData[pageNum] = data;
          _pagesSaved[pageNum] = true;
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.folder_open, color: Colors.white),
              SizedBox(width: 8),
              Text('Draft berhasil dimuat dari penyimpanan lokal'),
            ],
          ),
          backgroundColor: Colors.blue,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // Check if all required fields are filled for the current page
  bool _checkRequiredFields(Map<String, dynamic> data) {
    switch (_currentPage) {
      case 0: // Data Pribadi
        return data['namaLengkap']?.isNotEmpty == true &&
            data['nik']?.isNotEmpty == true &&
            data['tempatLahir']?.isNotEmpty == true &&
            data['tanggalLahir'] != null &&
            data['jenisKelamin']?.isNotEmpty == true &&
            data['alamat']?.isNotEmpty == true &&
            data['province'] != null;

      case 1: // Data Akademik
        return data['asalSekolah']?.isNotEmpty == true &&
            data['tahunLulus']?.isNotEmpty == true &&
            data['jurusan']?.isNotEmpty == true &&
            data['prodi']?.isNotEmpty == true;

      case 2: // Data Orang Tua
        return data['namaAyah']?.isNotEmpty == true &&
            data['pekerjaanAyah']?.isNotEmpty == true &&
            data['namaIbu']?.isNotEmpty == true &&
            data['pekerjaanIbu']?.isNotEmpty == true;

      case 3: // Upload Dokumen
        return data['ijazah'] != null &&
            data['kk'] != null &&
            data['akta'] != null &&
            data['foto'] != null;

      default:
        return false;
    }
  }

  // Check if any field is filled for the current page (for draft saving)
  bool _checkAnyFieldFilled(Map<String, dynamic> data) {
    switch (_currentPage) {
      case 0: // Data Pribadi
        return data['namaLengkap']?.isNotEmpty == true ||
            data['nik']?.isNotEmpty == true ||
            data['tempatLahir']?.isNotEmpty == true ||
            data['tanggalLahir'] != null ||
            data['jenisKelamin']?.isNotEmpty == true ||
            data['alamat']?.isNotEmpty == true ||
            data['province'] != null;

      case 1: // Data Akademik
        return data['asalSekolah']?.isNotEmpty == true ||
            data['tahunLulus']?.isNotEmpty == true ||
            data['jurusan']?.isNotEmpty == true ||
            data['prodi']?.isNotEmpty == true;

      case 2: // Data Orang Tua
        return data['namaAyah']?.isNotEmpty == true ||
            data['pekerjaanAyah']?.isNotEmpty == true ||
            data['namaIbu']?.isNotEmpty == true ||
            data['pekerjaanIbu']?.isNotEmpty == true ||
            data['noTlpAyah']?.isNotEmpty == true ||
            data['alamatAyah']?.isNotEmpty == true ||
            data['penghasilanAyah']?.isNotEmpty == true ||
            data['noTlpIbu']?.isNotEmpty == true ||
            data['alamatIbu']?.isNotEmpty == true ||
            data['penghasilanIbu']?.isNotEmpty == true;

      case 3: // Upload Dokumen
        return data['uploaded'] == true ||
            data['ijazah'] != null ||
            data['akta'] != null ||
            data['kk'] != null ||
            data['foto'] != null;

      default:
        return false;
    }
  }

  void _handlePageDataChanged(Map<String, dynamic> newData) {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            final existingData =
                Map<String, dynamic>.from(_formData[_currentPage] ?? {});
            bool hasSignificantChanges = false;

            if (existingData.isEmpty && newData.isNotEmpty) {
              hasSignificantChanges = true;
            } else if (existingData.length != newData.length) {
              hasSignificantChanges = true;
            } else {
              for (var key in newData.keys) {
                if (existingData[key] != newData[key]) {
                  hasSignificantChanges = true;
                  break;
                }
              }
            }

            Map<String, dynamic> dataCopy = {};
            newData.forEach((key, value) {
              dataCopy[key] = value;
            });
            _formData[_currentPage] = dataCopy;

            bool allFieldsFilled = _checkRequiredFields(dataCopy);

            if (allFieldsFilled) {
              _pagesSaved[_currentPage] = true;
            } else {
              if (hasSignificantChanges) {
                _pagesSaved[_currentPage] = false;
              }
            }

            if (_pagesSaved[_currentPage] == true && !hasSignificantChanges) {
              _pagesSaved[_currentPage] = true;
            }
          });
        }
      });
    }
  }

  void _saveDraft() async {
    bool anyFieldFilled =
        _formData.values.any((pageData) => pageData.isNotEmpty);
    if (!anyFieldFilled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak ada data untuk disimpan'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      int userId = 1; // TODO: Ganti dengan user ID yang login

      final result = await LocalStorageService.saveDraftLocal(
        userId: userId,
        pageNumber: _currentPage,
        formData: _formData[_currentPage] ?? {},
      );

      if (mounted) Navigator.pop(context);

      if (result['status'] == 'success') {
        setState(() {
          _pagesSaved[_currentPage] = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.save, color: Colors.white),
                SizedBox(width: 8),
                Text('Draft seluruh halaman berhasil disimpan!'),
              ],
            ),
            backgroundColor: Color(0xFF009137),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${result['message']}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  final List<String> _stepTitles = [
    'Data Pribadi',
    'Data Akademik',
    'Data Orang Tua',
    'Upload Dokumen',
    'Review & Submit',
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 4) {
      bool canProceed = _pagesSaved[_currentPage] == true ||
          (_formData[_currentPage]?.isNotEmpty == true &&
              _formData[_currentPage] == _formData[_currentPage]);

      if (canProceed) {
        setState(() {
          _currentPage++;

          if (_formData[_currentPage]?.isNotEmpty == true) {
            _pagesSaved[_currentPage] = true;
          }
        });
        _scrollToTop();
      }
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        if (_formData[_currentPage]?.isNotEmpty == true) {
          Map<String, dynamic> currentPageData = {};
          _formData[_currentPage]!.forEach((key, value) {
            currentPageData[key] = value;
          });
          _formData[_currentPage] = currentPageData;
          if (_pagesSaved[_currentPage] == true) {
            _pagesSaved[_currentPage] = true;
          }
        }

        _currentPage--;

        if (_formData[_currentPage]?.isNotEmpty == true) {
          Map<String, dynamic> prevPageData = {};
          _formData[_currentPage]!.forEach((key, value) {
            prevPageData[key] = value;
          });
          _formData[_currentPage] = prevPageData;
          if (_pagesSaved[_currentPage] == true) {
            _pagesSaved[_currentPage] = true;
          }
        }
      });

      _scrollToTop();
    }
  }

  Future<void> _uploadFinal() async {
    // Tampilkan indikator loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // 🔹 Kirim data ke server lewat service
      final result = await FormulirService.uploadFinal(allFormData: _formData);

      // Tutup loading dialog
      if (mounted) Navigator.pop(context);

      // 🔹 Tampilkan hasil dari server
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Upload gagal'),
          backgroundColor:
              result['status'] == 'success' ? Colors.green : Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );

      // 🔹 Jika berhasil, arahkan ke Dashboard
      if (result['status'] == 'success') {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/dashboard', // pastikan rute dashboard ada di MaterialApp
          (route) => false,
        );
      }
    } catch (e) {
      // Tutup loading kalau error
      if (mounted) Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan saat upload: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ✅ Tambahan: fungsi untuk memperbarui data form tiap halaman berdasarkan index
  void _handlePageDataChangedByIndex(
      int pageIndex, Map<String, dynamic> newData) {
    setState(() {
      _formData[pageIndex] = newData;
    });
  }

  void _scrollToTop() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: CustomAppBar(
        title: 'Formulir Pendaftaran',
        showMenuButton: true,
        showProfileMenu: true,
        currentPage: 'formulir',
      ),
      drawer: const AppDrawer(currentPage: 'formulir'),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Header Box
            Container(
              color: const Color(0xFF2C3E50),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4F6C7A),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            "Formulir Pendaftaran Mahasiswa Baru",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${_currentPage + 1} dari 5",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _stepTitles[_currentPage],
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tab Navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _tabItem(Icons.person, "Data Pribadi", _currentPage == 0),
                    _tabItem(Icons.school, "Data Akademik", _currentPage == 1),
                    _tabItem(Icons.group, "Data Orang Tua", _currentPage == 2),
                    _tabItem(
                        Icons.upload_file, "Upload Dokumen", _currentPage == 3),
                    _tabItem(Icons.check_circle, "Review & Submit",
                        _currentPage == 4),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Current Page Content
            _buildCurrentPageContent(),

            // Bottom Navigation Bar
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tombol Sebelumnya
                      SizedBox(
                        width: 140,
                        child: ElevatedButton(
                          onPressed: _currentPage > 0 ? _previousPage : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("< Sebelumnya"),
                        ),
                      ),

                      // Tombol Simpan Draft (tidak ditampilkan di halaman review)
                      if (_currentPage != 4)
                        ElevatedButton.icon(
                          onPressed: _checkAnyFieldFilled(
                                      _formData[_currentPage] ?? {}) ||
                                  _pagesSaved[_currentPage] == true
                              ? _saveDraft
                              : null,
                          icon: Icon(
                            Icons.save_outlined,
                            color: (_checkAnyFieldFilled(
                                        _formData[_currentPage] ?? {}) ||
                                    _pagesSaved[_currentPage] == true)
                                ? (_pagesSaved[_currentPage] == true
                                    ? Colors.white
                                    : const Color(0xFF233746))
                                : Colors.grey.shade400,
                          ),
                          label: Text(
                            "Simpan Draft",
                            style: TextStyle(
                              color: (_checkAnyFieldFilled(
                                          _formData[_currentPage] ?? {}) ||
                                      _pagesSaved[_currentPage] == true)
                                  ? (_pagesSaved[_currentPage] == true
                                      ? Colors.white
                                      : const Color(0xFF233746))
                                  : Colors.grey.shade400,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _pagesSaved[_currentPage] == true
                                ? const Color(0xFF009137)
                                : (_checkAnyFieldFilled(
                                        _formData[_currentPage] ?? {})
                                    ? Colors.white
                                    : Colors.grey.shade100),
                            elevation: 0,
                            side: BorderSide(
                              color: _pagesSaved[_currentPage] == true
                                  ? const Color(0xFF009137)
                                  : (_checkAnyFieldFilled(
                                          _formData[_currentPage] ?? {})
                                      ? const Color(0xFF233746)
                                      : Colors.grey.shade300),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 140,
                      child: ElevatedButton(
                        onPressed: _currentPage < 4
                            ? (_pagesSaved[_currentPage] == true
                                ? _nextPage
                                : null)
                            : () {
                                // 👇 KONFIRMASI UPLOAD KE DATABASE
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      title: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.cloud_upload,
                                              color: Color(0xFF009137)),
                                          SizedBox(width: 8),
                                          Flexible(
                                            child: Text(
                                              'Konfirmasi Upload',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: const Text(
                                        'Data akan dikirim ke database server. Pastikan semua data sudah benar dan lengkap. Lanjutkan?',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text('Batal'),
                                            ),
                                            const SizedBox(width: 8),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                _uploadFinal();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFF009137),
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: const Text('Upload'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _currentPage < 4
                              ? (_checkRequiredFields(
                                          _formData[_currentPage] ?? {}) ||
                                      _pagesSaved[_currentPage] == true
                                  ? const Color(0xFF233746)
                                  : Colors.grey.shade300)
                              : const Color(0xFF009137),
                          foregroundColor: Colors.white,
                          elevation: _currentPage < 4
                              ? (_checkRequiredFields(
                                          _formData[_currentPage] ?? {}) ||
                                      _pagesSaved[_currentPage] == true
                                  ? 2
                                  : 0)
                              : 3,
                          shadowColor: _currentPage < 4
                              ? (_checkRequiredFields(
                                          _formData[_currentPage] ?? {}) ||
                                      _pagesSaved[_currentPage] == true
                                  ? const Color(0xFF233746)
                                      .withValues(alpha: 0.3)
                                  : Colors.transparent)
                              : const Color(0xFF009137).withValues(alpha: 0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                        ),
                        child: Text(_currentPage < 4
                            ? "Selanjutnya >"
                            : "Upload Sekarang"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _navigateToPage(int pageIndex) {
    if (pageIndex != _currentPage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _currentPage = pageIndex;
          });
          _scrollToTop();
        }
      });
    }
  }

  Widget _buildCurrentPageContent() {
    switch (_currentPage) {
      case 0:
        return DataPribadiPage(
          savedData: _formData[0],
          onDataChanged: (data) => _handlePageDataChangedByIndex(0, data),
        );
      case 1:
        return DataAkademikPage(
          savedData: _formData[1],
          onDataChanged: (data) => _handlePageDataChangedByIndex(1, data),
        );
      case 2:
        return DataOrtuPage(
          savedData: _formData[2],
          onDataChanged: (data) => _handlePageDataChangedByIndex(2, data),
        );
      case 3:
        return UploadDokumenPage(
          savedData: _formData[3],
          onDataChanged: (data) => _handlePageDataChangedByIndex(3, data),
        );
      case 4:
        return ReviewSubmitPage(
          formData: _formData,
          pagesSaved: _pagesSaved,
          onPageEdit: _navigateToPage,
        );
      default:
        return DataPribadiPage(
          savedData: _formData[0],
          onDataChanged: (data) => _handlePageDataChangedByIndex(0, data),
        );
    }
  }

  Widget _tabItem(IconData icon, String title, bool active) {
    return Column(
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
            color: active ? const Color(0xFFE8F0F3) : Colors.white,
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
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: active ? const Color(0xFF4F6C7A) : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
