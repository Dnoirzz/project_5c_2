// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'dart:io';
// import 'dart:convert';
// import 'edit_pengumuman_page.dart';

// class DetailPengumumanPage extends StatefulWidget {
//   final Map<String, dynamic> pengumuman;

//   const DetailPengumumanPage({
//     super.key,
//     required this.pengumuman,
//   });

//   @override
//   State<DetailPengumumanPage> createState() => _DetailPengumumanPageState();
// }

// class _DetailPengumumanPageState extends State<DetailPengumumanPage> {
//   late Map<String, dynamic> _currentPengumuman;
//   // Variabel isFavorite tidak lagi diperlukan, dihapus
//   // bool isFavorite = false;

//   // void _onEditTapped() async{

//   //   // Simulasi aksi Edit
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     const SnackBar(content: Text("Aksi Edit dilakukan")),
//   //   );
//   // }
//   @override
//   void initState() {
//     super.initState();
//     _currentPengumuman = Map.from(widget.pengumuman);
//   }

//   void _onEditTapped() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) =>
//             EditPengumumanPage(pengumuman: _currentPengumuman),
//       ),
//     );

//     if (result != null) {
//       setState(() {
//         _currentPengumuman = Map.from(result);
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Pengumuman berhasil diperbarui!"),
//           backgroundColor: Colors.green,
//         ),
//       );
//       // Navigator.pop(context); // Kembali ke halaman sebelumnya
//     }
//   }

//   void _onDeleteTapped() {
//     // Simulasi aksi Delete
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Aksi Hapus dilakukan")),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final tanggalFormatted = DateFormat('dd MMMM yyyy', 'id_ID')
//     //     .format(widget.pengumuman['tanggal']);
//     // final waktuFormatted =
//     //     DateFormat('HH:mm', 'id_ID').format(widget.pengumuman['tanggal']);

//     // Ambil data tanggal dari pengumuman (bisa String atau DateTime)
//     final tanggalData = _currentPengumuman['tanggal'];

// // Pastikan dikonversi ke DateTime
//     // DateTime tanggal;
//     // if (tanggalData is String) {
//     //   try {
//     //     tanggal = DateTime.parse(tanggalData);
//     //   } catch (e) {
//     //     tanggal = DateTime.now(); // fallback jika parsing gagal
//     //   }
//     // } else if (tanggalData is DateTime) {
//     //   tanggal = tanggalData;
//     // } else {
//     //   tanggal = DateTime.now();
//     // }
//     DateTime tanggal;
//     if (tanggalData is DateTime) {
//       tanggal = tanggalData;
//     } else if (tanggalData is String) {
//       try {
//         tanggal = DateTime.tryParse(tanggalData) ?? DateTime.now();
//       } catch (_) {
//         tanggal = DateTime.now();
//       }
//     } else {
//       tanggal = DateTime.now();
//     }

// // Format tanggal dan waktu
//     final tanggalFormatted =
//         DateFormat('dd MMMM yyyy', 'id_ID').format(tanggal);
//     final waktuFormatted = DateFormat('HH:mm', 'id_ID').format(tanggal);

//     // Warna yang digunakan (sesuai tema biru tua/putih)
//     const Color darkBlueBackground = Color(0xFF2C3E50);
//     const Color containerBackground =
//         Color(0xFF34495E); // Untuk tombol back/action

//     return Scaffold(
//       backgroundColor: darkBlueBackground,
//       body: CustomScrollView(
//         slivers: [
//           // AppBar (hanya untuk tombol back dan aksi)
//           SliverAppBar(
//             expandedHeight: 0, // Dibuat minimal karena gambar dipindah
//             toolbarHeight: 60,
//             pinned: true,
//             backgroundColor: darkBlueBackground,
//             elevation: 0,
//             // Tombol Kembali (leading)
//             leading: Container(
//               margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
//               decoration: BoxDecoration(
//                 color: containerBackground,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: IconButton(
//                 icon: const Icon(Icons.arrow_back, color: Colors.white),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//             // Tombol Aksi (actions: Delete dan Edit)
//             actions: [
//               // Tombol Delete
//               Container(
//                 margin: const EdgeInsets.only(top: 10, bottom: 10),
//                 decoration: BoxDecoration(
//                   color: containerBackground,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.delete_outline, color: Colors.white),
//                   onPressed: _onDeleteTapped,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               // Tombol Edit
//               Container(
//                 margin: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
//                 decoration: BoxDecoration(
//                   color: containerBackground,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.edit_outlined, color: Colors.white),
//                   onPressed: _onEditTapped,
//                 ),
//               ),
//             ],
//           ),

//           // Konten detail (Judul, Tanggal, Gambar, Deskripsi)
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Tanggal dan waktu
//                   Row(
//                     children: [
//                       const Icon(Icons.calendar_month,
//                           color: Colors.white70, size: 16),
//                       const SizedBox(width: 8),
//                       Text(
//                         // Menggunakan format yang lebih ringkas seperti di gambar
//                         "$tanggalFormatted pukul $waktuFormatted",
//                         style: const TextStyle(
//                           color: Colors.white70,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),

//                   // Judul
//                   Text(
//                     _currentPengumuman["judul"],
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 24, // Sedikit lebih besar
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Gambar (dipindahkan ke sini)
//                   // if (widget.pengumuman["gambar"] != null)
//                   //   ClipRRect(
//                   //     borderRadius: BorderRadius.circular(12),
//                   //     child: Image.asset(
//                   //       widget.pengumuman["gambar"],
//                   if (_currentPengumuman["gambar"] != null &&
//                       _currentPengumuman["gambar"] != "")
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: Image.memory(
//                         base64Decode(_currentPengumuman["gambar"]),
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Container(
//                             height: 250, // Tinggi default jika gambar gagal
//                             decoration: BoxDecoration(
//                               color: Colors.grey[700],
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const Center(
//                               child: Icon(Icons.broken_image,
//                                   color: Colors.white70, size: 80),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   const SizedBox(height: 20),

//                   // Deskripsi
//                   Text(
//                     _currentPengumuman["deskripsi"],
//                     style: const TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                       height: 1.6,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   // SizedBox untuk menjaga jarak dari bawah
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:SPMB/models/pengumuman_models.dart';
import 'package:SPMB/services/pengumuman_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
// import '../models/pengumuman_model.dart';
// import '../services/pengumuman_service.dart';
import 'edit_pengumuman_page.dart';

class DetailPengumumanPage extends StatefulWidget {
  final Pengumuman pengumuman;

  const DetailPengumumanPage({super.key, required this.pengumuman});

  @override
  State<DetailPengumumanPage> createState() => _DetailPengumumanPageState();
}

class _DetailPengumumanPageState extends State<DetailPengumumanPage> {
  late Pengumuman _currentPengumuman;
  final _service = PengumumanService();

  @override
  void initState() {
    super.initState();
    _currentPengumuman = widget.pengumuman;
  }

  void _onEditTapped() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditPengumumanPage(pengumuman: _currentPengumuman),
      ),
    );

    if (result is Pengumuman) {
      setState(() => _currentPengumuman = result);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Pengumuman berhasil diperbarui!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _onDeleteTapped() async {
    try {
      await PengumumanService.deletePengumuman(_currentPengumuman.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Pengumuman berhasil dihapus!"),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.pop(context, true); // kembali ke list dengan status deleted
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal menghapus: $e"),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tanggalFormatted = DateFormat('dd MMMM yyyy', 'id_ID')
        .format(_currentPengumuman.tanggal as DateTime);
    final waktuFormatted = DateFormat('HH:mm', 'id_ID')
        .format(_currentPengumuman.tanggal as DateTime);

    const darkBlueBackground = Color(0xFF2C3E50);
    const containerBackground = Color(0xFF34495E);

    return Scaffold(
      backgroundColor: darkBlueBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 0,
            toolbarHeight: 60,
            pinned: true,
            backgroundColor: darkBlueBackground,
            elevation: 0,
            leading: Container(
              margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: containerBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: containerBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.white),
                  onPressed: _onDeleteTapped,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                margin: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: containerBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.edit_outlined, color: Colors.white),
                  onPressed: _onEditTapped,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_month,
                          color: Colors.white70, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        "$tanggalFormatted pukul $waktuFormatted",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _currentPengumuman.judul,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_currentPengumuman.gambar != null &&
                      _currentPengumuman.gambar!.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _buildImage(_currentPengumuman.gambar!),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    _currentPengumuman.isi,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String base64String) {
    try {
      return Image.memory(
        base64Decode(base64String),
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return _placeholderImage();
        },
      );
    } catch (e) {
      return _placeholderImage();
    }
  }

  Widget _placeholderImage() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Icon(Icons.broken_image, color: Colors.white70, size: 80),
      ),
    );
  }
}
