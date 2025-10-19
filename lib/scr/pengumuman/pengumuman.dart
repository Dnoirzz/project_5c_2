// import 'package:flutter/material.dart';
// import 'detail_pengumuman.dart';
// import '../../widgets/app_bar.dart';

// // Tambahkan/eksport variabel pengumumanList sehingga bisa digunakan dari file lain
// const List<Map<String, String>> pengumumanList = [
//   {
//     'kategori': 'Pendaftaran',
//     'judul': 'Batas Waktu Pendaftaran Diperpanjang',
//     'tanggal': '25 Januari 2025 | 20:30',
//     'deskripsi':
//         'Batas waktu pendaftaran maksimal 25 Januari 2025. Pastikan Anda melengkapi semua berkas.',
//     'gambar': 'assets/images/pengumuman.jpg',
//   },
//   {
//     'kategori': 'Akademik',
//     'judul': 'Jadwal Kuliah Semester Genap',
//     'tanggal': '10 Februari 2025 | 08:00',
//     'deskripsi':
//         'Jadwal kuliah semester genap tahun ajaran 2024/2025 telah dirilis. Silakan cek portal akademik masing-masing.',
//   },
// ];

// class PengumumanPage extends StatelessWidget {
//   const PengumumanPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Pengumuman',
//         showBackButton: true,
//         showProfileMenu: true,
//         currentPage: 'pengumuman',
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             // 🔍 Search Field
//             TextField(
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.search),
//                 hintText: 'Search',
//                 contentPadding: const EdgeInsets.symmetric(vertical: 0),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),

//             // 📋 Daftar Pengumuman
//             Expanded(
//               child: ListView.builder(
//                 itemCount: pengumumanList.length,
//                 itemBuilder: (context, index) {
//                   final item = pengumumanList[index];

//                   return InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => DetailPengumumanPage(
//                             judul: item['judul']!,
//                             tanggal: item['tanggal']!,
//                             deskripsi: item['deskripsi']!,
//                             gambar: item['gambar'], // dikirim ke halaman detail
//                           ),
//                         ),
//                       );
//                     },
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       margin: const EdgeInsets.only(bottom: 12),
//                       elevation: 2,
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Judul
//                             Text(
//                               item['judul']!,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 4),

//                             // Tanggal
//                             Row(
//                               children: [
//                                 const Icon(Icons.calendar_today,
//                                     size: 14, color: Colors.grey),
//                                 const SizedBox(width: 4),
//                                 Text(
//                                   item['tanggal']!,
//                                   style: const TextStyle(
//                                       fontSize: 12, color: Colors.grey),
//                                 ),
//                               ],
//                             ),

//                             const SizedBox(height: 8),

//                             // Deskripsi ringkas
//                             Text(
//                               item['deskripsi']!,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: const TextStyle(fontSize: 13),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:SPMB/models/pengumuman_models.dart';
import 'package:SPMB/services/pengumuman_services.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';
import 'detail_pengumuman.dart';

class PengumumanPage extends StatefulWidget {
  const PengumumanPage({super.key});

  @override
  State<PengumumanPage> createState() => _PengumumanPageState();
}

class _PengumumanPageState extends State<PengumumanPage> {
  late Future<List<Pengumuman>> futurePengumuman;

  @override
  void initState() {
    super.initState();
    futurePengumuman = PengumumanService.getAllPengumuman();
  }

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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Pengumuman>>(
                future: futurePengumuman,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Belum ada pengumuman"));
                  }

                  final data = snapshot.data!;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => DetailPengumumanPage(
                          //       judul: item.judul,
                          //       tanggal: item.tanggal,
                          //       deskripsi: item.isi,
                          //       gambar: item.gambar,
                          //     ),
                          //   ),
                          // );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailPengumumanPage(pengumuman: item),
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
                                if (item.gambar.isNotEmpty)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.memory(
                                      base64Decode(item.gambar),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                Text(
                                  item.judul,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        size: 14, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      item.tanggal,
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item.isi,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
