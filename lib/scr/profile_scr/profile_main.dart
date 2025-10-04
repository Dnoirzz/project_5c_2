import 'package:flutter/material.dart';
import '../../widgets/appBar.dart';
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

  final List<String> _tabTitles = [
    'Data Pribadi',
    'Informasi Akademik',
    'Data Orang tua',
    'Dokumen',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        // Update state ketika tab berubah
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: CustomAppBar(
        title: 'Profil Saya',
        showMenuButton: true,
        showProfileMenu: true,
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Profil User
            _buildProfileHeader(),

            // Tab Navigation
            _buildTabNavigation(),

            // Tab Content
            _buildCurrentTabContent(),
          ],
        ),
      ),
    );
  }

  // Method untuk menampilkan konten berdasarkan tab yang aktif
  Widget _buildCurrentTabContent() {
    switch (_tabController.index) {
      case 0:
        return const DataPribadiTab();
      case 1:
        return const InformasiAkademikTab();
      case 2:
        return const DataOrtuTab();
      case 3:
        return const DokumenTab();
      default:
        return const InformasiAkademikTab();
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
          // Main content row
          Row(
            children: [
              // Avatar dengan multiple rings seperti gambar
              Container(
                width: 80,
                height: 80,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer ring (light gray)
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFD3D3D3),
                          width: 2,
                        ),
                      ),
                    ),
                    // Middle ring (darker gray)
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C7A89),
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Inner icon
                    const Icon(
                      Icons.person,
                      size: 40,
                      color: Color(0xFFD3D3D3),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // Info User
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Aldi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                      ),
                    ),
                    const Text(
                      'Mahendra',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'NIM:2024001645',
                      style: TextStyle(
                        color: Color(0xFFA9A9A9),
                        fontSize: 14,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Status Badge positioned at top-right
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
                'Status: menunggu Verifikasi',
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
          _tabItem(Icons.person, "Data Pribadi", _tabController.index == 0),
          _tabItem(
            Icons.school,
            "Informasi Akademik",
            _tabController.index == 1,
          ),
          _tabItem(
            Icons.family_restroom,
            "Data Orang tua",
            _tabController.index == 2,
          ),
          _tabItem(Icons.folder, "Dokumen", _tabController.index == 3),
        ],
      ),
    );
  }

  // Tab Navigation Item
  Widget _tabItem(IconData icon, String title, bool active) {
    return GestureDetector(
      onTap: () {
        int index = _tabTitles.indexOf(title);
        if (index != -1) {
          _tabController.animateTo(index);
        }
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
            height: 32, // Fixed height untuk konsistensi
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: active ? Colors.black : Colors.grey,
                height: 1.2, // Line height untuk spacing yang konsisten
              ),
            ),
          ),
        ],
      ),
    );
  }
}
