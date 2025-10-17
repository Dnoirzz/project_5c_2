import 'package:flutter/material.dart';
import '../../widgets/appBar.dart';

class DetailPengumumanPage extends StatelessWidget {
  final String judul;
  final String tanggal;
  final String deskripsi;
  final String? gambar;

  const DetailPengumumanPage({
    super.key,
    required this.judul,
    required this.tanggal,
    required this.deskripsi,
    this.gambar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detail Pengumuman',
        showBackButton: true,
        showProfileMenu: true,
        currentPage: 'pengumuman',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    tanggal,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 🖼️ Gambar hanya muncul kalau pengumuman punya gambar
              if (gambar != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    gambar!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 16),
              ],

              Text(
                deskripsi,
                style: const TextStyle(fontSize: 15, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PengumumanDetailPage extends StatelessWidget {
  final Map item;
  const PengumumanDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final String judul = item['judul'] ?? 'Pengumuman';
    final String deskripsi = item['deskripsi'] ?? '';
    final String tanggal = item['tanggal'] ?? (item['waktu'] ?? '');
    final String? gambar = item['gambar'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengumuman'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(judul,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 16, color: Colors.black54),
                  const SizedBox(width: 8),
                  Text(tanggal, style: const TextStyle(color: Colors.black54)),
                ],
              ),
              const SizedBox(height: 16),

              // 🖼️ Gambar hanya muncul kalau pengumuman punya gambar
              if (gambar != null && gambar.isNotEmpty) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    gambar,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 16),
              ],

              Text(deskripsi,
                  style: const TextStyle(fontSize: 15, height: 1.4)),
            ],
          ),
        ),
      ),
    );
  }
}
