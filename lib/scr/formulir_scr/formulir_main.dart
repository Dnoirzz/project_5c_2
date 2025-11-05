import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';
import 'data_pribadi_page.dart';
import 'data_akademik_page.dart';
import 'data_ortu_page.dart';
import 'upload_dokumen_page.dart';
import 'review_submit_page.dart';
import '../dashboard_scr.dart';

class FormulirPendaftaranMain extends StatefulWidget {
  const FormulirPendaftaranMain({super.key});

  @override
  State<FormulirPendaftaranMain> createState() =>
      _FormulirPendaftaranMainState();
}

class _FormulirPendaftaranMainState extends State<FormulirPendaftaranMain> {
  int _currentPage = 0;
  final ScrollController _scrollController = ScrollController();

  // Store form data for each page
  final Map<int, Map<String, dynamic>> _formData = {
    0: {},
    1: {},
    2: {},
    3: {},
    4: {},
  };

  void _handlePageDataChanged(Map<String, dynamic> newData) {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _formData[_currentPage] = Map<String, dynamic>.from(newData);
          });
        }
      });
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
      setState(() {
        _currentPage++;
      });
      _scrollToTop();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _scrollToTop();
    }
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

  void _submitForm() {
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
              Icon(Icons.check_circle, color: Color(0xFF009137)),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Batal'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    
                    // TODO: Simpan data ke database di sini
                    // Contoh:
                    // await saveToDatabase(_formData);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle, color: Colors.white),
                            SizedBox(width: 8),
                            Text("Formulir berhasil dikirim!"),
                          ],
                        ),
                        backgroundColor: Color(0xFF009137),
                        duration: Duration(seconds: 3),
                      ),
                    );
                    
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const DashboardPage(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009137),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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
                    _tabItem(Icons.upload_file, "Upload Dokumen", _currentPage == 3),
                    _tabItem(Icons.check_circle, "Review & Submit", _currentPage == 4),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Content
            _buildCurrentPageContent(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPageContent() {
    switch (_currentPage) {
      case 0:
        return DataPribadiPage(
          savedData: _formData[0],
          onDataChanged: _handlePageDataChanged,
          onNext: _nextPage,
        );
      case 1:
        return DataAkademikPage(
          savedData: _formData[1],
          onDataChanged: _handlePageDataChanged,
          onNext: _nextPage,
          onPrevious: _previousPage,
        );
      case 2:
        return DataOrtuPage(
          savedData: _formData[2],
          onDataChanged: _handlePageDataChanged,
          onNext: _nextPage,
          onPrevious: _previousPage,
        );
      case 3:
        return UploadDokumenPage(
          savedData: _formData[3],
          onDataChanged: _handlePageDataChanged,
          onNext: _nextPage,
          onPrevious: _previousPage,
        );
      case 4:
        return Column(
          children: [
            ReviewSubmitPage(
              formData: _formData,
              pagesSaved: {0: true, 1: true, 2: true, 3: true, 4: true},
              onPageEdit: _navigateToPage,
            ),
            // Submit Button
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _previousPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(width: 8),
                          Text("Sebelumnya"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF009137),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.send),
                          SizedBox(width: 8),
                          Text(
                            "Daftar Sekarang",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      default:
        return DataPribadiPage(
          savedData: _formData[0],
          onDataChanged: _handlePageDataChanged,
          onNext: _nextPage,
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