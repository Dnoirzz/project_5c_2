import 'package:flutter/material.dart';
import 'detail_pengumuman.dart';
import '../../widgets/appBar.dart';

class PengumumanPage extends StatelessWidget {
  const PengumumanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pengumumanList = [
      {
        'kategori': 'Pendaftaran',
        'judul': 'Batas Waktu Pendaftaran Diperpanjang',
        'tanggal': '25 Januari 2025 | 20:30',
        'deskripsi':
            'Batas waktu pendaftaran mahasiswa telah diperpanjang hingga 25 Januari 2025. Pastikan Anda melengkapi semua berkas yang diperlukan.'
      },
      {
        'kategori': 'Akademik',
        'judul': 'Jadwal Kuliah Semester Genap',
        'tanggal': '10 Februari 2025 | 08:00',
        'deskripsi':
            'Jadwal kuliah semester genap tahun ajaran 2024/2025 telah dirilis. Silakan cek portal akademik masing-masing.'
      },
      {
        'kategori': 'Umum',
        'judul': 'Pemeliharaan Sistem Akademik',
        'tanggal': '30 Januari 2025 | 22:00',
        'deskripsi':
            'Sistem akademik akan mengalami pemeliharaan rutin mulai pukul 22.00 WIB. Mohon maaf atas ketidaknyamanannya.'
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Pengumuman',
        showBackButton: true,
        showProfileMenu: true,
        currentPage: 'pengumuman',
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // 🔍 Hanya Search Field (kategori dihapus)
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // 📋 Daftar Pengumuman
            Expanded(
              child: ListView.builder(
                itemCount: pengumumanList.length,
                itemBuilder: (context, index) {
                  final item = pengumumanList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPengumumanPage(
                            kategori: item['kategori']!,
                            judul: item['judul']!,
                            tanggal: item['tanggal']!,
                            deskripsi: item['deskripsi']!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Label kategori
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                item['kategori']!,
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Judul
                            Text(
                              item['judul']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Tanggal
                            Row(
                              children: [
                                const Icon(Icons.calendar_today,
                                    size: 14, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  item['tanggal']!,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Deskripsi
                            Text(
                              item['deskripsi']!,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
