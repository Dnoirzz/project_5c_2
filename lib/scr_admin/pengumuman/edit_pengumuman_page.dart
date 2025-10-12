import 'package:flutter/material.dart';

class EditPengumumanPage extends StatefulWidget {
  final Map<String, String> pengumuman;

  const EditPengumumanPage({super.key, required this.pengumuman});

  @override
  State<EditPengumumanPage> createState() => _EditPengumumanPageState();
}

class _EditPengumumanPageState extends State<EditPengumumanPage> {
  late TextEditingController _judulController;
  late TextEditingController _isiController;

  @override
  void initState() {
    super.initState();
    _judulController = TextEditingController(text: widget.pengumuman['judul']);
    _isiController = TextEditingController(text: widget.pengumuman['isi']);
  }

  void _simpanEdit() {
    Navigator.pop(context, {
      'id': widget.pengumuman['id'],
      'judul': _judulController.text,
      'tanggal': widget.pengumuman['tanggal'],
      'isi': _isiController.text,
      'gambar': widget.pengumuman['gambar'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E3A5F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A5F),
        title: const Text('Edit Pengumuman', style: TextStyle(color: Colors.white)),
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
              onPressed: _simpanEdit,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
