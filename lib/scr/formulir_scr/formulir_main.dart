import 'package:flutter/material.dart';
import '../../widgets/appBar.dart';
import 'data_pribadi_page.dart';
import 'data_akademik_page.dart';
import 'data_ortu_page.dart';
import 'upload_dokumen_page.dart';
import 'review_submit_page.dart';

/// Main Formulir Pendaftaran dengan konten terpisah
/// Hanya konten yang berubah, AppBar dan header tetap
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
  Map<int, bool> _pagesSaved = {
    0: false,
    1: false,
    2: false,
    3: false, // Upload dokumen page
    4: false, // Review page
  };

  // Store form data for each page
  Map<int, Map<String, dynamic>> _formData = {};
  @override
  void initState() {
    super.initState();
    // Initialize form data for each page
    for (int i = 0; i < 5; i++) {
      _formData[i] = {};
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
        return data['uploaded'] == true;

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
            data['ktp'] != null ||
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
      // Use addPostFrameCallback to avoid setState during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            final existingData =
                Map<String, dynamic>.from(_formData[_currentPage] ?? {});
            bool hasSignificantChanges = false;

            // Deep comparison of old and new data
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

            // Create a deep copy of the new data
            Map<String, dynamic> dataCopy = {};
            newData.forEach((key, value) {
              dataCopy[key] = value;
            });
            _formData[_currentPage] = dataCopy;

            // Check if all required fields are filled
            bool allFieldsFilled = _checkRequiredFields(dataCopy);

            // Auto-save if all required fields are filled
            if (allFieldsFilled) {
              _pagesSaved[_currentPage] = true;
            } else {
              // Only mark as unsaved if there are actual changes
              if (hasSignificantChanges) {
                _pagesSaved[_currentPage] = false;
              }
            }

            // Keep saved state if previously saved and no changes
            if (_pagesSaved[_currentPage] == true && !hasSignificantChanges) {
              _pagesSaved[_currentPage] = true;
            }
          });
        }
      });
    }
  }

  void _saveDraft() {
    setState(() {
      // For all pages including document upload
      if (_formData[_currentPage]?.isNotEmpty == true) {
        // Create a deep copy of the current data to ensure it's preserved
        Map<String, dynamic> dataCopy = {};
        _formData[_currentPage]!.forEach((key, value) {
          dataCopy[key] = value;
        });
        _formData[_currentPage] = dataCopy;
        _pagesSaved[_currentPage] = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Draft berhasil disimpan!"),
        backgroundColor: Color(0xFF009137),
      ),
    );
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
    // Allow moving forward if:
    // 1. Current page is saved, or
    // 2. Current page has data and was previously saved
    if (_currentPage < 4) {
      bool canProceed = _pagesSaved[_currentPage] == true ||
          (_formData[_currentPage]?.isNotEmpty == true &&
              _formData[_currentPage] == _formData[_currentPage]);

      if (canProceed) {
        setState(() {
          _currentPage++;

          // When moving to a new page, if it has saved data, mark it as saved
          if (_formData[_currentPage]?.isNotEmpty == true) {
            _pagesSaved[_currentPage] = true;
          }
        });
        // Scroll ke atas setelah berpindah halaman
        _scrollToTop();
      }
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        // Store the current page's state before moving
        if (_formData[_currentPage]?.isNotEmpty == true) {
          Map<String, dynamic> currentPageData = {};
          _formData[_currentPage]!.forEach((key, value) {
            currentPageData[key] = value;
          });
          // Save the current page's data and state
          _formData[_currentPage] = currentPageData;
          // Only preserve saved state if it was explicitly saved
          if (_pagesSaved[_currentPage] == true) {
            _pagesSaved[_currentPage] = true;
          }
        }

        // Move to previous page
        _currentPage--;

        // Restore previous page's state
        if (_formData[_currentPage]?.isNotEmpty == true) {
          Map<String, dynamic> prevPageData = {};
          _formData[_currentPage]!.forEach((key, value) {
            prevPageData[key] = value;
          });
          _formData[_currentPage] = prevPageData;
          // If this page was previously saved, restore that state
          if (_pagesSaved[_currentPage] == true) {
            _pagesSaved[_currentPage] = true;
          }
        }
      });

      // Scroll ke atas setelah berpindah halaman
      _scrollToTop();
    }
  }

  void _scrollToTop() {
    // Delay kecil untuk memastikan widget sudah di-render
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
            // ========== HEADER BOX (TIDAK BERUBAH) ==========
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
                      color: Colors.black.withOpacity(0.25),
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

            // ========== TAB NAVIGATION (TIDAK BERUBAH) ==========
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
                      color: Colors.black.withOpacity(0.08),
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
                      Icons.upload_file,
                      "Upload Dokumen",
                      _currentPage == 3,
                    ),
                    _tabItem(
                      Icons.check_circle,
                      "Review & Submit",
                      _currentPage == 4,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ========== KONTEN (YANG BERUBAH) ==========
            // Ganti PageView dengan Column yang dapat di-scroll
            _buildCurrentPageContent(),

            // ========== BOTTOM NAVIGATION BAR (SEKARANG BISA DI-SCROLL) ==========
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
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
                      Container(
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

                      // Tombol Simpan Draft
                      Container(
                        child: ElevatedButton.icon(
                          // Only allow saving draft if there's any data filled
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 140,
                      child: ElevatedButton(
                        onPressed: _currentPage < 4
                            ? (_checkRequiredFields(
                                        _formData[_currentPage] ?? {}) ||
                                    _pagesSaved[_currentPage] == true
                                ? _nextPage
                                : null)
                            : () {
                                // Show confirmation dialog before submitting
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      title: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.check_circle,
                                              color: Color(0xFF009137)),
                                          SizedBox(width: 8),
                                          Flexible(
                                            child: Text(
                                              'Konfirmasi Pendaftaran',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: Text(
                                        'Apakah Anda yakin ingin mengirim formulir pendaftaran? Pastikan semua data sudah benar dan lengkap.',
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
                                            SizedBox(width: 8),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(Icons.check_circle,
                                                            color:
                                                                Colors.white),
                                                        SizedBox(width: 8),
                                                        Text(
                                                            "Formulir berhasil dikirim!"),
                                                      ],
                                                    ),
                                                    backgroundColor:
                                                        Color(0xFF009137),
                                                    duration:
                                                        Duration(seconds: 3),
                                                  ),
                                                );
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
                                              child: const Text('Kirim'),
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
                                  ? const Color(0xFF233746).withOpacity(0.3)
                                  : Colors.transparent)
                              : const Color(0xFF009137).withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                        ),
                        child: Text(_currentPage < 4
                            ? "Selanjutnya >"
                            : "Daftar Sekarang"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Extra space at bottom
          ],
        ),
      ),
    );
  }

  // Method untuk navigasi langsung ke halaman tertentu
  void _navigateToPage(int pageIndex) {
    if (pageIndex != _currentPage) {
      // Use addPostFrameCallback to avoid setState during build
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

  // Method untuk menampilkan konten berdasarkan halaman saat ini
  Widget _buildCurrentPageContent() {
    switch (_currentPage) {
      case 0:
        return DataPribadiPage(
          savedData: _formData[0],
          onDataChanged: _handlePageDataChanged,
        );
      case 1:
        return DataAkademikPage(
          savedData: _formData[1],
          onDataChanged: _handlePageDataChanged,
        );
      case 2:
        return DataOrtuPage(
          savedData: _formData[2],
          onDataChanged: _handlePageDataChanged,
        );
      case 3:
        return UploadDokumenPage(
          savedData: _formData[3],
          onDataChanged: _handlePageDataChanged,
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
          onDataChanged: _handlePageDataChanged,
        );
    }
  }

  // Tab Navigation Item (simple progress indicator)
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
