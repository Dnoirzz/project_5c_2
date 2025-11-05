// ignore_for_file: use_build_context_synchronously

import 'package:SPMB/models/pengumuman_models.dart';
import 'package:SPMB/services/pengumuman_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'edit_pengumuman_page.dart';

class DetailPengumumanPage extends StatefulWidget {
  final Pengumuman pengumuman;

  const DetailPengumumanPage({super.key, required this.pengumuman});

  @override
  State<DetailPengumumanPage> createState() => _DetailPengumumanPageState();
}

class _DetailPengumumanPageState extends State<DetailPengumumanPage> {
  late Pengumuman _currentPengumuman;
  List<Pengumuman> pengumumanList = [];

  @override
  void initState() {
    super.initState();
    _currentPengumuman = widget.pengumuman;
  }

  void _viewDetail(Pengumuman data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPengumumanPage(pengumuman: data),
      ),
    );
  }

  Future<void> _deletePengumuman(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Yakin ingin menghapus pengumuman ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final success = await PengumumanService.deletePengumuman(id);
      if (success) {
        setState(() {
          pengumumanList.removeWhere((item) => item.id == id);
        });
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pengumuman berhasil dihapus')),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal menghapus pengumuman')),
          );
        }
      }
    }
  }

  void _editPengumuman() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditPengumumanPage(
          pengumuman: {
            'id': _currentPengumuman.id,
            'judul': _currentPengumuman.judul,
            'deskripsi': _currentPengumuman.isi,
            'gambar': _currentPengumuman.gambar,
          },
        ),
      ),
    );

    if (result != null && result is Pengumuman) {
      setState(() => _currentPengumuman = result);
      Navigator.pop(context, result); // kirim kembali ke Admin
    }
  }

  @override
  Widget build(BuildContext context) {
    final tanggalFormatted = DateFormat('dd MMMM yyyy', 'id_ID')
        .format(DateTime.parse(_currentPengumuman.tanggal));
    final waktuFormatted = DateFormat('HH:mm', 'id_ID')
        .format(DateTime.parse(_currentPengumuman.tanggal));

    const darkBlueBackground = Color(0xFF2C3E50);
    // const containerBackground = Color(0xFF34495E);
    return Scaffold(
      backgroundColor: darkBlueBackground,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10), // radius untuk semua sisi
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xff1E2A38),
            ),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 0,
                  toolbarHeight: 60,
                  pinned: true,
                  backgroundColor: const Color(0xff1E2A38),
                  elevation: 0,
                  leading: IconButton(
                    icon:
                        const Icon(Icons.arrow_back, color: Color(0xffE8E995)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () => _deletePengumuman(_currentPengumuman.id),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Image.asset(
                          'assets/images/hapus.png',
                          width: 18,
                          height: 18,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.delete,
                                color: Colors.white70, size: 20);
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _editPengumuman,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Image.asset(
                          'assets/images/Edit.png',
                          width: 18,
                          height: 18,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.edit,
                                color: Colors.white70, size: 20);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_month,
                                color: Color(0xff947979), size: 16),
                            const SizedBox(width: 8),
                            Text(
                              "$tanggalFormatted pukul $waktuFormatted",
                              style: const TextStyle(
                                color: Color(0xff947979),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _currentPengumuman.judul,
                          style: const TextStyle(
                            color: Color(0xffE8E995),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (_currentPengumuman.gambar.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: _buildImage(_currentPengumuman.gambar),
                          ),
                        const SizedBox(height: 20),
                        Text(
                          _currentPengumuman.isi,
                          textAlign: TextAlign.justify,
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
          ),
        ),
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
