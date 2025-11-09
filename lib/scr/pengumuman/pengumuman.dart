import 'dart:convert';
import '../../models/pengumuman_models.dart';
import '../../services/pengumuman_services.dart';
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    futurePengumuman = PengumumanService.getSemuaPengumuman();
    futurePengumuman.then((value) {
      setState(() {
        allPengumuman = value;
        filteredPengumuman = value;
        isLoading = false;
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
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  // TextField(
                  //   controller: searchController,
                  //   decoration: InputDecoration(
                  //     prefixIcon: const Icon(Icons.search),
                  //     hintText: 'Search',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // warna background textfield
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.black.withOpacity(0.2), // warna bayangan
                          spreadRadius: 1, // seberapa lebar menyebar
                          blurRadius: 3, // seberapa lembut blur
                          offset: const Offset(0, 3), // posisi bayangan (x, y)
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search',
                        border: InputBorder.none, // hilangkan border bawaan
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: filteredPengumuman.isEmpty
                        ? const Center(child: Text('No pengumuman found'))
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
                                  color: Colors.white,
                                  elevation: 4, // efek shadow
                                  margin: const EdgeInsets.only(bottom: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(
                                      color: Color.fromARGB(255, 207, 207,
                                          207), // warna border abu
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (item.gambar.isNotEmpty)
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Center(
                                                child: Image.memory(
                                                  width: 200,
                                                  height: 150,
                                                  base64Decode(item.gambar),
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
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
                                                  fontSize: 12,
                                                  color: Colors.grey),
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