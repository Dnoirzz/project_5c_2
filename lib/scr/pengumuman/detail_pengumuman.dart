import 'package:flutter/material.dart';
import '../../widgets/appBar.dart';

class DetailPengumumanPage extends StatelessWidget {
  final String kategori;
  final String judul;
  final String tanggal;
  final String deskripsi;

  const DetailPengumumanPage({
    super.key,
    required this.kategori,
    required this.judul,
    required this.tanggal,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Pengumuman',
        showBackButton: true,
        showProfileMenu: true,
        currentPage: 'pengumuman',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label kategori
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  kategori,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Judul
              Text(
                judul,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              // Tanggal
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

              const SizedBox(height: 12),

              // Deskripsi utama
              Text(
                deskripsi,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),

              const SizedBox(height: 12),

              // Tambahan teks dummy untuk isi panjang
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                "Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, "
                "metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum "
                "tellus elit sed risus. Maecenas eget condimentum velit.",
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
