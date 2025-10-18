import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'tambah_pengumuman_page.dart';
import 'edit_pengumuman_page.dart';
import 'detail_pengumuman_page.dart';

class AdminPengumumanPage extends StatefulWidget {
  const AdminPengumumanPage({super.key});

  @override
  State<AdminPengumumanPage> createState() => _AdminPengumumanPageState();
}

class _AdminPengumumanPageState extends State<AdminPengumumanPage> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> pengumumanList = [
    {
      "judul": "Pengumuman Hari Libur",
      "deskripsi":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum.",
      "tanggal": DateTime(2025, 1, 25, 15, 30),
      "gambar": "assets/images/beasiswa.png",
    },
    {
      "judul": "Timeline Pendaftaran Beasiswa",
      "deskripsi":
          "Pendaftaran beasiswa dibuka kembali hingga akhir bulan ini. Segera lengkapi berkas kamu!",
      "tanggal": DateTime(2025, 1, 25, 15, 30),
      "gambar": "assets/images/beasiswa.jpg",
    },
    {
      "judul": "Timeline Pendaftaran Beasiswa",
      "deskripsi":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum.",
      "tanggal": DateTime(2025, 1, 25, 15, 30),
      "gambar": "assets/images/beasiswa.png",
    },
    {
      "judul": "Timeline Pendaftaran Beasiswa",
      "deskripsi":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum.",
      "tanggal": DateTime(2025, 1, 25, 15, 30),
      "gambar": "assets/images/beasiswa.png",
    },
    {
      "judul": "Timeline Pendaftaran Beasiswa",
      "deskripsi":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum.",
      "tanggal": DateTime(2025, 1, 25, 15, 30),
      "gambar": "assets/images/students.png",
    },
  ];

  List<Map<String, dynamic>> get filteredPengumuman {
    if (_searchController.text.isEmpty) {
      return pengumumanList;
    }
    return pengumumanList
        .where((item) =>
            item["judul"]
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            item["deskripsi"]
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
        .toList();
  }

  void _deletePengumuman(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C3C53),
        title: const Text(
          "Hapus Pengumuman",
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          "Apakah Anda yakin ingin menghapus pengumuman ini?",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                pengumumanList.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Pengumuman berhasil dihapus"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text("Hapus"),
          ),
        ],
      ),
    );
  }

  void _editPengumuman(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPengumumanPage(
          pengumuman: pengumumanList[index],
        ),
      ),
    ).then((value) {
      if (value != null) {
        setState(() {
          pengumumanList[index] = value;
        });
      }
    });
  }

  void _viewDetail(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPengumumanPage(
          pengumuman: pengumumanList[index],
        ),
      ),
    );
  }

  void _tambahPengumuman() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TambahPengumumanPage(),
      ),
    ).then((value) {
      if (value != null) {
        setState(() {
          pengumumanList.add(value);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF365368),
      appBar: AppBar(
        backgroundColor: const Color(0xFF365368),
        title: const Text(
          "PENGUMUMAN",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xffE8E995),
          ),
        ),
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.yellowAccent),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header dengan icon grid dan circle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF365368),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // child: const Icon(Icons.grid_3x3, color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search Here ...",
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          const SizedBox(height: 12),

          // Tombol Tambah
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _tambahPengumuman,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Tambah",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Daftar pengumuman
          Expanded(
            child: filteredPengumuman.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox,
                          size: 80,
                          color: Colors.white54,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Tidak ada pengumuman",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredPengumuman.length,
                    itemBuilder: (context, index) {
                      final realIndex =
                          pengumumanList.indexOf(filteredPengumuman[index]);
                      final item = filteredPengumuman[index];
                      final tanggalFormatted =
                          DateFormat('dd MMMM yyyy', 'id_ID')
                              .format(item['tanggal']);
                      final waktuFormatted =
                          DateFormat('HH:mm', 'id_ID').format(item['tanggal']);

                      return GestureDetector(
                        onTap: () => _viewDetail(realIndex),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF34495E),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Tanggal dan action buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Icon(Icons.calendar_month,
                                            color: Color(0xff947979), size: 14),
                                        const SizedBox(width: 6),
                                        Text(
                                          "$tanggalFormatted pukul $waktuFormatted",
                                          style: const TextStyle(
                                              color: Color(0xff947979),
                                              fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => _deletePengumuman(realIndex),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Image.asset(
                                        'assets/images/hapus.png',
                                        width: 18,
                                        height: 18,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(Icons.delete,
                                              color: Colors.white70, size: 18);
                                        },
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => _editPengumuman(realIndex),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Image.asset(
                                        'assets/images/Edit.png',
                                        width: 18,
                                        height: 18,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(Icons.edit,
                                              color: Colors.white70, size: 18);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Judul
                              Text(
                                item["judul"],
                                style: const TextStyle(
                                  color: Color(0xffE8E995),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Deskripsi
                              Text(
                                item["deskripsi"],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 12),
                              ),
                              const SizedBox(height: 8),

                              // Gambar (jika ada)
                              if (item["gambar"] != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    item["gambar"],
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 120,
                                        color: Colors.grey[700],
                                        child: const Center(
                                            child: Icon(Icons.broken_image,
                                                color: Colors.white70,
                                                size: 40)),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
