// ignore_for_file: unnecessary_to_list_in_spreads, deprecated_member_use
import 'package:flutter/material.dart';
import '../../models/dataDokumen_models.dart';

class DokumenTab extends StatelessWidget {
  final List<DataDokumen> dataDokumen;
  const DokumenTab({super.key, required this.dataDokumen});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF4F6C7A), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.folder, color: Color(0xFF4F6C7A), size: 24),
              SizedBox(width: 8),
              Text(
                'Dokumen',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text('Dokumen yang telah diupload',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 20),
          if (dataDokumen.isEmpty)
            const Center(child: Text('Belum ada dokumen diupload'))
          else
            ...dataDokumen.map((doc) {
              final status = doc.statusVerifikasi.toLowerCase();
              final isVerified = status == 'verifikasi';

              return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        isVerified ? Colors.green.shade50 : Colors.red.shade50,
                    border: Border.all(
                      color: isVerified
                          ? Colors.green.shade300
                          : Colors.red.shade300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(children: [
                    Icon(
                      isVerified ? Icons.check_circle : Icons.cancel,
                      color: isVerified ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doc.jenisDokumen,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isVerified
                                      ? Colors.green.shade800
                                      : Colors.red.shade800)),
                          Text(doc.namaFile,
                              style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.visibility,
                          color: Color(0xFF4F6C7A)),
                      onPressed: () {
                        final String baseUrl = "http://44.220.144.82/api/";
                        final String filePath =
                            doc.pathFile.replaceAll(r"\", "/");
                        final String fullUrl = baseUrl + filePath;

                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(doc.jenisDokumen),
                            content: Image.network(
                              fullUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Text("Gagal memuat gambar");
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Tutup"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ]));
            }).toList(),
        ],
      ),
    );
  }
}