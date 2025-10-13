import 'package:flutter/material.dart';
import 'package:project_5c_2/scr_admin/pengumuman/admin_pengumuman_page.dart'; // 🔥 Tambahkan ini

class Sidebar extends StatelessWidget {
  final String userName;
  final String currentPage;

  const Sidebar({
    super.key,
    this.userName = 'Sarah Elexandare',
    this.currentPage = 'Dashboard',
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF8FA3B8),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItemWithAsset(
                    context,
                    iconPath: 'assets/icons/dashboard_icon.png',
                    title: 'Dashboard',
                    isSelected: currentPage == 'Dashboard',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildDrawerItemWithAsset(
                    context,
                    iconPath: 'assets/icons/data_mahasiswa_icon.png',
                    title: 'Data Mahasiswa',
                    isSelected: currentPage == 'Data Mahasiswa',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: Hubungkan ke halaman data mahasiswa jika sudah ada
                    },
                  ),
                  _buildDrawerItemWithAsset(
                    context,
                    iconPath: 'assets/icons/pengumuman_icon.png',
                    title: 'Pengumuman',
                    isSelected: currentPage == 'Pengumuman',
                    onTap: () {
                      Navigator.pop(context);
                      // 🔥 Pindah ke halaman pengumuman admin
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminPengumumanPage(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItemWithAsset(
                    context,
                    iconPath: 'assets/icons/logout_icon.png',
                    title: 'Log Out',
                    isSelected: false,
                    onTap: () {
                      Navigator.pop(context);
                      _showLogoutDialog(context);
                    },
                  ),
                ],
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF6B8399),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome,',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            userName,
            style: const TextStyle(
              color: Colors.yellowAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItemWithAsset(
    BuildContext context, {
    required String iconPath,
    required String title,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white24 : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Image.asset(
          iconPath,
          width: 24,
          height: 24,
          color: isSelected ? Colors.white : const Color(0xFF364A63),
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              _getDefaultIcon(title),
              color: isSelected ? Colors.white : const Color(0xFF364A63),
              size: 24,
            );
          },
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF364A63),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  IconData _getDefaultIcon(String title) {
    switch (title) {
      case 'Dashboard':
        return Icons.home;
      case 'Data Mahasiswa':
        return Icons.description;
      case 'Pengumuman':
        return Icons.campaign;
      case 'Log Out':
        return Icons.logout;
      default:
        return Icons.menu;
    }
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF6B8399),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Admin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Admin@example.com',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Keluar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
