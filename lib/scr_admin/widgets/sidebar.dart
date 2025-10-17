import 'package:flutter/material.dart';
import '../management_form.dart';


class Sidebar extends StatefulWidget {
  final String userName;
  final String currentPage;

  const Sidebar({
    super.key,
    this.userName = 'Sarah Elexandare',
    this.currentPage = 'Dashboard',
  });

  @override
  State<Sidebar> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<Sidebar> {
  bool isDataMahasiswaExpanded = false;

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
                    isSelected: widget.currentPage == 'Dashboard',
                    onTap: () {
                      Navigator.pop(context);
                      // Sudah di halaman Dashboard
                    },
                  ),
                  _buildDrawerItemWithSubmenu(
                    context,
                    iconPath: 'assets/icons/data_mahasiswa_icon.png',
                    title: 'Data Mahasiswa',
                    isSelected: widget.currentPage == 'Data Mahasiswa',
                    isExpanded: isDataMahasiswaExpanded,
                    onTap: () {

                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FormManagementPage(),
                        ),
                      );
                    },
                    submenuItems: [
                      _buildSubmenuItem(
                        context,
                        title: 'Teknik Elektro',
                        onTap: () {
                          Navigator.pop(context);
                          // Navigate to Teknik Elektro page
                        },
                      ),
                      _buildSubmenuItem(
                        context,
                        title: 'Teknik Mesin',
                        onTap: () {
                          Navigator.pop(context);
                          // Navigate to Teknik Mesin page
                        },
                      ),
                      _buildSubmenuItem(
                        context,
                        title: 'Akuntansi',
                        onTap: () {
                          Navigator.pop(context);
                          // Navigate to Akuntansi page
                        },
                      ),
                      _buildSubmenuItem(
                        context,
                        title: 'Teknologi Pertanian',
                        onTap: () {
                          Navigator.pop(context);
                          // Navigate to Teknologi Pertanian page
                        },
                      ),
                    ],
                  ),
                  _buildDrawerItemWithAsset(
                    context,
                    iconPath: 'assets/icons/pengumuman_icon.png',
                    title: 'Pengumuman',
                    isSelected: widget.currentPage == 'Pengumuman',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Pengumuman page
                      // Navigator.pushNamed(context, '/pengumuman');
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
            widget.userName,
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

  Widget _buildDrawerItemWithSubmenu(
    BuildContext context, {
    required String iconPath,
    required String title,
    bool isSelected = false,
    bool isExpanded = false,
    required VoidCallback onTap,
    required List<Widget> submenuItems,
  }) {
    return Column(
      children: [
        Container(
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
            trailing: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: isSelected ? Colors.white : const Color(0xFF364A63),
            ),
            onTap: onTap,
          ),
        ),
        AnimatedCrossFade(
          firstChild: Container(),
          secondChild: Container(
            margin: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: submenuItems,
            ),
          ),
          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }

  Widget _buildSubmenuItem(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.yellowAccent.withOpacity(0.3),
      splashColor: Colors.yellowAccent.withOpacity(0.5),
      highlightColor: Colors.yellowAccent.withOpacity(0.2),
      child: Container(
        padding: const EdgeInsets.only(left: 56, right: 16, top: 12, bottom: 12),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.yellowAccent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF364A63),
                fontSize: 14,
              ),
            ),
          ],
        ),
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
              Navigator.pop(context); // Return to login/previous page
            },
            child: const Text('Keluar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
