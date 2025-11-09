import '../../models/pengumuman_models.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';
import 'dart:convert';

class DetailPengumumanPage extends StatelessWidget {
  final Pengumuman item;

  const DetailPengumumanPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 255, 255, 255), // warna utama halaman
      appBar: CustomAppBar(
        title: 'Detail Pengumuman',
        showBackButton: true,
        showProfileMenu: true,
        currentPage: 'pengumuman',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15), // jarak dari tepi layar
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255), // isi putih
              border: Border.all(
                color: const Color.fromARGB(
                    255, 207, 207, 207), // warna border abu
                width: 1,
              ),
              // borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16), // jarak dalam kontainer
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Judul
                  Text(
                    item.judul,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 🔹 Tanggal
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 14, color: Color(0xff947979)),
                      const SizedBox(width: 4),
                      Text(
                        item.tanggal,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xff947979),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 🔹 Gambar (kalau ada)
                  if (item.gambar.isNotEmpty)
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          base64Decode(item.gambar),
                          // width: double.infinity,
                          // height: 180,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image,
                                  size: 80, color: Colors.white54),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),

                  // 🔹 Isi / Deskripsi
                  Text(
                    item.isi,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Color.fromARGB(179, 0, 0, 0),
                      fontFamily: 'Cambria',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
