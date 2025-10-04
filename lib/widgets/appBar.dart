import 'package:flutter/material.dart';
import '../scr/formulir_scr/formulir_main.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showMenuButton;
  final bool showProfileMenu;
  final VoidCallback? onBackPressed;
  final VoidCallback? onMenuPressed;
  final List<Widget>? additionalActions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.showMenuButton = false,
    this.showProfileMenu = true,
    this.onBackPressed,
    this.onMenuPressed,
    this.additionalActions,
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
        builder:
            (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed:
                  onMenuPressed ?? () => Scaffold.of(context).openDrawer(),
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
      actions.add(ProfileMenu());
    }

    return actions;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Widget PopupMenu untuk profil pengguna
class ProfileMenu extends StatelessWidget {
  final Function(int)? onSelected;

  const ProfileMenu({super.key, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.account_circle, color: Colors.white, size: 30),
      offset: const Offset(0, 55),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder:
          (context) => [
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
            const PopupMenuItem(
              value: 2,
              child: Row(
                children: [
                  Icon(Icons.person_outline, size: 18),
                  SizedBox(width: 8),
                  Text('Profil', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 3,
              child: Row(
                children: [
                  Icon(Icons.settings_outlined, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Settings',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 4,
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
        // Navigate ke profil
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const ProfilPage()),
        // );
        break;
      case 3:
        // Navigate ke settings
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fitur Settings akan segera hadir')),
        );
        break;
      case 4:
        // Logout
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Logout berhasil')));
        // TODO: Implement actual logout logic
        break;
    }
  }
}

/// Drawer menu untuk navigasi sidebar
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

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
                    onTap: () => Navigator.pop(context),
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.description_outlined,
                    title: 'Formulir Pendaftaran',
                    bold: true,
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
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur Pengumuman akan segera hadir'),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.help_outline,
                    title: 'Bantuan',
                    bold: true,
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur Bantuan akan segera hadir'),
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
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: Colors.black,
        ),
      ),
      onTap: onTap,
    );
  }
}
