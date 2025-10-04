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
      // Scroll ke atas setelah berpindah halaman
      _scrollToTop();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
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
      ),
      drawer: const AppDrawer(),
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
                      if (_currentPage > 0)
                        GestureDetector(
                          onTap: _previousPage,
                          child: _secondaryButton("<   Sebelumnya"),
                        )
                      else
                        GestureDetector(
                          onTap: () {},
                          child: _secondaryButton("<   Sebelumnya"),
                        ),
                      // Tombol Simpan Draft
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Draft berhasil disimpan!"),
                            ),
                          );
                        },
                        child: _secondaryButtonWithIcon(
                          "Simpan Draft",
                          Icons.save_outlined,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap:
                          _currentPage < 4
                              ? _nextPage
                              : () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Formulir berhasil dikirim!"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:
                              _currentPage < 4
                                  ? Colors.black
                                  : const Color(0xFF009137),
                        ),
                        child: Text(
                          _currentPage < 4
                              ? "Selanjutnya   >"
                              : "Daftar Sekarang",
                          style: const TextStyle(color: Colors.white),
                        ),
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

  // Method untuk menampilkan konten berdasarkan halaman saat ini
  Widget _buildCurrentPageContent() {
    switch (_currentPage) {
      case 0:
        return const DataPribadiPage();
      case 1:
        return const DataAkademikPage();
      case 2:
        return const DataOrtuPage();
      case 3:
        return const UploadDokumenPage();
      case 4:
        return const ReviewSubmitPage();
      default:
        return const DataPribadiPage();
    }
  }

  // Tab Navigation Item
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
              color: active ? Colors.blue : Colors.grey.shade400,
              width: 2,
            ),
            color: Colors.white,
          ),
          child: Icon(
            icon,
            color: active ? Colors.blue : Colors.grey[600],
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
              color: active ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  // Button Helpers
  Widget _secondaryButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.grey.shade100,
      ),
      child: Text(text, style: const TextStyle(color: Colors.grey)),
    );
  }

  Widget _secondaryButtonWithIcon(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Row(
        children: [Icon(icon, size: 18), const SizedBox(width: 6), Text(text)],
      ),
    );
  }
}
