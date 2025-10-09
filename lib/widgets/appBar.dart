import 'package:flutter/material.dart';
import '../scr/formulir_scr/formulir_main.dart';
import '../scr/profile_scr/profile_main.dart';
import '../scr/dashboard_scr.dart';
import '../scr/landing.dart';
import '../scr/setting_scr/setting.dart';
import '../scr/pengumuman/pengumuman.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showMenuButton;
  final bool showProfileMenu;
  final VoidCallback? onBackPressed;
  final VoidCallback? onMenuPressed;
  final List<Widget>? additionalActions;
  final String? currentPage; // Untuk mendeteksi halaman saat ini

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.showMenuButton = false,
    this.showProfileMenu = true,
    this.onBackPressed,
    this.onMenuPressed,
    this.additionalActions,
    this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF233746),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      leading: _buildLeading(context),
      automaticallyImplyLeading: false,
      actions: _buildActions(context),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (showBackButton) {
      return IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: onBackPressed ?? () => Navigator.pop(context),
      );
    } else if (showMenuButton) {
      return Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: onMenuPressed ?? () => Scaffold.of(context).openDrawer(),
        ),
      );
    }
    return null;
  }

  List<Widget> _buildActions(BuildContext context) {
    List<Widget> actions = [];

    // Tambahkan additional actions jika ada
    if (additionalActions != null) {
      actions.addAll(additionalActions!);
    }

    // Tambahkan profile menu jika diminta
    if (showProfileMenu) {
      actions.add(ProfileMenu(currentPage: currentPage));
    }

    return actions;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Widget PopupMenu untuk profil pengguna
class ProfileMenu extends StatelessWidget {
  final Function(int)? onSelected;
  final String? currentPage;

  const ProfileMenu({super.key, this.onSelected, this.currentPage});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.account_circle, color: Colors.white, size: 30),
      offset: const Offset(0, 55),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Aldi Mahendra',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                'Mahasiswa@example.com',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: 2,
          enabled: currentPage !=
              'profile', // Disabled jika sedang di halaman profil
          child: Row(
            children: [
              Icon(
                Icons.person_outline,
                size: 18,
                color: currentPage == 'profile'
                    ? Colors.grey.shade400
                    : Colors.black,
              ),
              const SizedBox(width: 8),
              Text(
                'Profil',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: currentPage == 'profile'
                      ? Colors.grey.shade400
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.red, size: 18),
              SizedBox(width: 8),
              Text('Keluar', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        if (onSelected != null) {
          onSelected!(value);
        } else {
          _handleMenuSelection(context, value);
        }
      },
    );
  }

  void _handleMenuSelection(BuildContext context, int value) {
    switch (value) {
      case 1:
        // Info akun (tidak perlu action)
        break;
      case 2:
        // Navigate ke profil (jika tidak sedang di halaman profil)
        if (currentPage != 'profile') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileMain()),
          );
        }
        break;
      case 3:
        // Logout - Navigate to landing page
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LandingPage()),
          (route) => false, // Remove all previous routes
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Logout berhasil')));
        break;
    }
  }
}

/// Drawer menu untuk navigasi sidebar
class AppDrawer extends StatelessWidget {
  final String? currentPage;

  const AppDrawer({super.key, this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan logo dan teks
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: const [
                  Icon(Icons.language, size: 30, color: Color(0xFF233746)),
                  SizedBox(width: 8),
                  Text(
                    'Portal Mahasiswa',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF233746),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Card mini info pengguna
            Container(
              width: double.infinity,
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Aldi Mahendra',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'NIM: 2024001645',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Menu navigasi
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _buildDrawerItem(
                    context,
                    icon: Icons.dashboard_outlined,
                    title: 'Dashboard',
                    bold: true,
                    isDisabled: currentPage == 'dashboard',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardPage(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.description_outlined,
                    title: 'Formulir Pendaftaran',
                    bold: true,
                    isDisabled: currentPage == 'formulir',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FormulirPendaftaranMain(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.notifications_outlined,
                    title: 'Pengumuman',
                    bold: true,
                    isDisabled: currentPage == 'pengumuman',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PengumumanPage(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    bold: true,
                    isDisabled: currentPage == 'settings',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool bold = false,
    bool isDisabled = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDisabled ? Colors.grey.shade400 : Colors.black87,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: isDisabled ? Colors.grey.shade400 : Colors.black,
        ),
      ),
      onTap: isDisabled ? null : onTap,
      enabled: !isDisabled,
    );
  }
}
