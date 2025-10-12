import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../models/pengumuman_model.dart';
import 'tambah_pengumuman_page.dart';
import 'edit_pengumuman_page.dart';
import 'detail_pengumuman_page.dart';

class AdminPengumumanPage extends StatefulWidget {
  const AdminPengumumanPage({super.key});

  @override
  State<AdminPengumumanPage> createState() => _AdminPengumumanPageState();
}

class _AdminPengumumanPageState extends State<AdminPengumumanPage> {
  final List<Pengumuman> _list = [
    Pengumuman(
      id: const Uuid().v4(),
      judul: 'Timeline Pendaftaran Beasiswa',
      isi:
          'Pendaftaran beasiswa dibuka kembali hingga akhir bulan ini. Segera lengkapi berkas kamu!',
      tanggal: DateFormat('d MMMM yyyy | HH:mm', 'id_ID').format(DateTime.now()),
      gambar: 'assets/beasiswa.jpg', // contoh gambar lokal
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2C47),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E2C47),
        title: const Text(
          'Pengumuman',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              final newItem = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TambahPengumumanPage()),
              );
              if (newItem != null && newItem is Pengumuman) {
                setState(() => _list.add(newItem));
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                hintText: "Search Here ...",
                hintStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, i) {
                  final item = _list[i];
                  return Card(
                    color: const Color(0xFF294066),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: item.gambar != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                item.gambar!,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(Icons.image_not_supported,
                              color: Colors.white70),
                      title: Text(item.judul,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        '${item.tanggal}\n${item.isi}',
                        style: const TextStyle(color: Colors.white70),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: PopupMenuButton(
                        color: Colors.white,
                        onSelected: (value) async {
                          if (value == 'edit') {
                            final updated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditPengumumanPage(pengumuman: {
                                  'id': item.id,
                                  'judul': item.judul,
                                  'isi': item.isi,
                                  'tanggal': item.tanggal,
                                  'gambar': item.gambar ?? '',
                                }),
                              ),
                            );
                            if (updated != null && updated is Pengumuman) {
                              setState(() {
                                final idx = _list.indexWhere((e) => e.id == item.id);
                                _list[idx] = updated;
                              });
                            }
                          } else if (value == 'delete') {
                            setState(() => _list.remove(item));
                          } else if (value == 'detail') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DetailPengumumanPage(pengumuman: {
                                        'id': item.id,
                                        'judul': item.judul,
                                        'isi': item.isi,
                                        'tanggal': item.tanggal,
                                        'gambar': item.gambar ?? '',
                                      })),
                            );
                          }
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(value: 'detail', child: Text('Lihat')),
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          PopupMenuItem(value: 'delete', child: Text('Hapus')),
                        ],
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
