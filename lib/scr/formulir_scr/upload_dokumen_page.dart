import 'package:flutter/material.dart';

class UploadDokumenPage extends StatelessWidget {
  const UploadDokumenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.upload_file, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    "Upload Dokumen",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                "Upload dokumen yang diperlukan",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              _uploadCard("Ijazah/SKL"),
              _uploadCard("Kartu Keluarga"),
              _uploadCard("Akta Kelahiran"),
              _uploadCard("Pas Foto 3x4"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _uploadCard(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.insert_drive_file, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 14))),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement upload functionality
              print("Upload $title");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F6C7A),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text("Upload", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
