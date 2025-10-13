import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPengumumanPage extends StatefulWidget {
  final Map<String, dynamic> pengumuman;

  const DetailPengumumanPage({
    super.key,
    required this.pengumuman,
  });

  @override
  State<DetailPengumumanPage> createState() => _DetailPengumumanPageState();
}

class _DetailPengumumanPageState extends State<DetailPengumumanPage> {
  // Variabel isFavorite tidak lagi diperlukan, dihapus
  // bool isFavorite = false;

  void _onEditTapped() {
    // Simulasi aksi Edit
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Aksi Edit dilakukan")),
    );
  }

  void _onDeleteTapped() {
    // Simulasi aksi Delete
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Aksi Hapus dilakukan")),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pastikan locale Indonesia telah diinisialisasi di main.dart,
    // atau gunakan fungsi toLocale('id') jika tersedia pada Date/DateTime object.
    final tanggalFormatted =
        DateFormat('dd MMMM yyyy', 'id_ID').format(widget.pengumuman['tanggal']);
    final waktuFormatted =
        DateFormat('HH:mm', 'id_ID').format(widget.pengumuman['tanggal']);

    // Warna yang digunakan (sesuai tema biru tua/putih)
    const Color darkBlueBackground = Color(0xFF2C3E50);
    const Color containerBackground = Color(0xFF34495E); // Untuk tombol back/action

    return Scaffold(
      backgroundColor: darkBlueBackground,
      body: CustomScrollView(
        slivers: [
          // AppBar (hanya untuk tombol back dan aksi)
          SliverAppBar(
            expandedHeight: 0, // Dibuat minimal karena gambar dipindah
            toolbarHeight: 60,
            pinned: true,
            backgroundColor: darkBlueBackground,
            elevation: 0,
            // Tombol Kembali (leading)
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
            // Tombol Aksi (actions: Delete dan Edit)
            actions: [
              // Tombol Delete
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
              // Tombol Edit
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

          // Konten detail (Judul, Tanggal, Gambar, Deskripsi)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tanggal dan waktu
                  Row(
                    children: [
                      const Icon(Icons.calendar_month,
                          color: Colors.white70, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        // Menggunakan format yang lebih ringkas seperti di gambar
                        "$tanggalFormatted pukul $waktuFormatted",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Judul
                  Text(
                    widget.pengumuman["judul"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24, // Sedikit lebih besar
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Gambar (dipindahkan ke sini)
                  if (widget.pengumuman["gambar"] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        widget.pengumuman["gambar"],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 250, // Tinggi default jika gambar gagal
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Icon(Icons.broken_image,
                                  color: Colors.white70, size: 80),
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 20),

                  // Deskripsi
                  Text(
                    widget.pengumuman["deskripsi"],
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // SizedBox untuk menjaga jarak dari bawah
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
