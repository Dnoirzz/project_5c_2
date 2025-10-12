import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TambahPengumumanPage extends StatefulWidget {
  const TambahPengumumanPage({super.key});

  @override
  State<TambahPengumumanPage> createState() => _TambahPengumumanPageState();
}

class _TambahPengumumanPageState extends State<TambahPengumumanPage> {
  final _judulController = TextEditingController();
  final _isiController = TextEditingController();
  final uuid = const Uuid();

  void _publish() {
    if (_judulController.text.isEmpty || _isiController.text.isEmpty) return;

    final newItem = {
      'id': uuid.v4(),
      'judul': _judulController.text,
      'tanggal': '12 Oktober 2025 | 13:30',
      'isi': _isiController.text,
      'gambar': 'assets/beasiswa.jpg',
    };

    Navigator.pop(context, newItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E3A5F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A5F),
        title: const Text('Tambah Pengumuman', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _judulController,
              decoration: const InputDecoration(
                labelText: 'Judul Pengumuman',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _isiController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Isi Pengumuman',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _publish,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Publish'),
            )
          ],
        ),
      ),
    );
  }
}
