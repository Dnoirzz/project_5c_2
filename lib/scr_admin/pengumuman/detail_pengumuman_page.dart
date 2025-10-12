import 'package:flutter/material.dart';

class DetailPengumumanPage extends StatelessWidget {
  final Map<String, String> pengumuman;

  const DetailPengumumanPage({super.key, required this.pengumuman});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E3A5F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A5F),
        title: const Text('Detail Pengumuman', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pengumuman['judul']!,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(pengumuman['tanggal']!, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 12),
                if (pengumuman['gambar'] != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(pengumuman['gambar']!),
                  ),
                const SizedBox(height: 12),
                Text(pengumuman['isi']!, textAlign: TextAlign.justify),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
