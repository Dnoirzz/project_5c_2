import 'package:flutter/material.dart';
import '../pages/dashboard_page.dart';
import '../pages/mahasiswa_page.dart';
import '../pages/pengumuman_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF47607A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF3E556C)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome,", style: TextStyle(color: Colors.white70, fontSize: 14)),
                SizedBox(height: 4),
                Text("Sarah Elexandare",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text("Dashboard", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DashboardPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.people, color: Colors.white),
            title: const Text("Data Mahasiswa", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MahasiswaPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.campaign, color: Colors.white),
            title: const Text("Pengumuman", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PengumumanPage()),
              );
            },
          ),
          const Spacer(),
          const Divider(color: Colors.white24),
          ListTile(
            leading: const CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white,
              child: Text("A", style: TextStyle(color: Colors.black)),
            ),
            title: const Text("Admin", style: TextStyle(color: Colors.white)),
            subtitle: const Text("Admin@example.com",
                style: TextStyle(color: Colors.white54, fontSize: 12)),
            trailing: IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                Navigator.pop(context); // log out logic nanti
              },
            ),
          ),
        ],
      ),
    );
  }
}
