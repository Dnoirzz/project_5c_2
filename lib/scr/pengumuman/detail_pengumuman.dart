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
              // 🔹 Judul
              Text(
                item.judul,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // 🔹 Tanggal
              Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    item.tanggal,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 🔹 Gambar (kalau ada)
              Center(
                child: Image.memory(
                  width: 200,
                  height: 150,
                  base64Decode(item.gambar),
                  fit: BoxFit.cover,
                  // width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 80),
                ),
              ),
              const SizedBox(height: 16),

              // 🔹 Isi / Deskripsi
              Text(
                item.isi,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 20,
                  height: 1.5,
                  fontFamily: 'Cambria',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
