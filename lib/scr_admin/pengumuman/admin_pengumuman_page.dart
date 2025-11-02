// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:SPMB/models/pengumuman_models.dart';
import 'package:SPMB/services/pengumuman_services.dart';
import 'detail_pengumuman_page.dart';
import 'tambah_pengumuman_page.dart';
import 'edit_pengumuman_page.dart';

class AdminPengumumanPage extends StatefulWidget {
  const AdminPengumumanPage({super.key});

  @override
  State<AdminPengumumanPage> createState() => _AdminPengumumanPageState();
}

class _AdminPengumumanPageState extends State<AdminPengumumanPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Pengumuman> pengumumanList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPengumuman();
  }

  Future<void> _fetchPengumuman() async {
    try {
      final data = await PengumumanService.getSemuaPengumuman();
      setState(() {
        pengumumanList = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error ambil pengumuman: $e");
      setState(() => isLoading = false);
    }
  }

  List<Pengumuman> get filteredPengumuman {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) return pengumumanList;
    return pengumumanList
        .where((item) =>
            item.judul.toLowerCase().contains(query) ||
            item.isi.toLowerCase().contains(query))
        .toList();
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

  void _editPengumuman(int id) async {
    final pengumuman = pengumumanList.firstWhere((e) => e.id == id);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditPengumumanPage(
          pengumuman: {
            'id': pengumuman.id,
            'judul': pengumuman.judul,
            'deskripsi': pengumuman.isi,
            'gambar': pengumuman.gambar.isNotEmpty ? pengumuman.gambar : null,
          },
        ),
      ),
    );
    // if (result == true) _fetchPengumuman();
    if (result is Pengumuman) {
      setState(() {
        final index = pengumumanList.indexWhere((p) => p.id == result.id);
        if (index != -1) pengumumanList[index] = result;
      });
    }
  }

  void _tambahPengumuman() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TambahPengumumanPage()),
    );
    if (result == true) _fetchPengumuman();
  }

  // void _viewDetail(Pengumuman data) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => DetailPengumumanPage(pengumuman: data),
  //     ),
  //   );
  void _viewDetail(Pengumuman data) async {
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPengumumanPage(pengumuman: data),
      ),
    );

    if (updated != null && updated is Pengumuman) {
      setState(() {
        final index = pengumumanList.indexWhere((p) => p.id == updated.id);
        if (index != -1) pengumumanList[index] = updated;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF365368),
      appBar: AppBar(
        backgroundColor: const Color(0xFF365368),
        title: const Text(
          "PENGUMUMAN ADMIN",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xffE8E995)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xffE8E995)),
          onPressed: () => Navigator.pop(context, true),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xffE8E995)))
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Cari pengumuman...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.white54),
                      filled: true,
                      fillColor: Colors.white12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (v) => setState(() {}),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _tambahPengumuman,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Tambah",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: filteredPengumuman.isEmpty
                      ? const Center(
                          child: Text(
                            "Tidak ada pengumuman",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: filteredPengumuman.length,
                          itemBuilder: (context, index) {
                            final item = filteredPengumuman[index];
                            final tanggal = DateFormat('dd MMM yyyy')
                                .format(DateTime.parse(item.tanggal));
                            return GestureDetector(
                                onTap: () => _viewDetail(item),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF34495E),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  // ),
                                  // return Container(
                                  //   margin: const EdgeInsets.only(bottom: 12),
                                  //   padding: const EdgeInsets.all(12),
                                  //   decoration: BoxDecoration(
                                  //     color: const Color(0xFF34495E),
                                  //     borderRadius: BorderRadius.circular(12),
                                  //   ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                const Icon(Icons.calendar_month,
                                                    color: Color(0xff947979),
                                                    size: 14),
                                                const SizedBox(width: 6),
                                                Text(
                                                  tanggal,
                                                  style: const TextStyle(
                                                      color: Color(0xff947979),
                                                      fontSize: 11),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                _deletePengumuman(item.id),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: Image.asset(
                                                'assets/images/hapus.png',
                                                width: 18,
                                                height: 18,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Icon(
                                                      Icons.delete,
                                                      color: Colors.white70,
                                                      size: 18);
                                                },
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                _editPengumuman(item.id),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: Image.asset(
                                                'assets/images/Edit.png',
                                                width: 18,
                                                height: 18,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Icon(Icons.edit,
                                                      color: Colors.white70,
                                                      size: 18);
                                                },
                                              ),
                                            ),
                                          ),
                                          // IconButton(
                                          //   icon: const Icon(Icons.delete,
                                          //       color: Colors.red, size: 18),
                                          //   onPressed: () =>
                                          //       _deletePengumuman(item.id),
                                          // ),
                                          // IconButton(
                                          //   icon: const Icon(Icons.delete,
                                          //       color: Colors.red, size: 18),
                                          //   onPressed: () =>
                                          //       _deletePengumuman(item.id),
                                          // ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item.judul,
                                        style: const TextStyle(
                                          color: Color(0xffE8E995),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.isi,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12),
                                      ),
                                      const SizedBox(height: 8),
                                      if (item.gambar.isNotEmpty)
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.memory(
                                            base64Decode(item.gambar),
                                            fit: BoxFit.cover,
                                            height: 120,
                                            width: double.infinity,
                                            errorBuilder: (_, __, ___) =>
                                                const Icon(Icons.broken_image,
                                                    color: Colors.white54),
                                          ),
                                        ),
                                    ],
                                  ),
                                ));
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
