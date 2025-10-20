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
  List<Pengumuman> allPengumuman = [];
  List<Pengumuman> filteredPengumuman = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futurePengumuman = PengumumanService.getSemuaPengumuman();
    futurePengumuman.then((value) {
      setState(() {
        allPengumuman = value;
        filteredPengumuman = value;
      });
    });

    searchController.addListener(() {
      final query = searchController.text.toLowerCase();
      setState(() {
        filteredPengumuman = allPengumuman.where((p) {
          return p.judul.toLowerCase().contains(query);
        }).toList();
      });
    });
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
              controller: searchController,
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
              child: filteredPengumuman.isEmpty
                  ? const Center(
                      child: Text("Kata Kunci Yang di Cari Tidak ada"))
                  : ListView.builder(
                      itemCount: filteredPengumuman.length,
                      itemBuilder: (context, index) {
                        final item = filteredPengumuman[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPengumumanPage(item: item)),
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
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
