import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadDokumenPage extends StatefulWidget {
  const UploadDokumenPage({super.key});

  @override
  State<UploadDokumenPage> createState() => _UploadDokumenPageState();
}

class _UploadDokumenPageState extends State<UploadDokumenPage> {
  final ImagePicker _picker = ImagePicker();
  File? _ktpImage;
  File? _ijazahImage;
  File? _aktaImage;
  File? _kkImage;
  File? _pasFotoImage;

  // Method untuk mengambil gambar dari kamera
  Future<void> _pickImageFromCamera(String docType) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        setState(() {
          switch (docType) {
            case 'KTP':
              _ktpImage = File(image.path);
              break;
            case 'Ijazah':
              _ijazahImage = File(image.path);
              break;
            case 'Akta':
              _aktaImage = File(image.path);
              break;
            case 'KK':
              _kkImage = File(image.path);
              break;
            case 'Pas Foto':
              _pasFotoImage = File(image.path);
              break;
          }
        });

        // Tampilkan pesan sukses
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Foto $docType berhasil diambil'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        // Jika kamera tidak tersedia, tawarkan opsi galeri
        if (e.toString().contains('no_available_camera')) {
          _showCameraNotAvailableDialog(docType);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error mengambil foto: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  // Method untuk mengambil gambar dari galeri
  Future<void> _pickImageFromGallery(String docType) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        setState(() {
          switch (docType) {
            case 'KTP':
              _ktpImage = File(image.path);
              break;
            case 'Ijazah':
              _ijazahImage = File(image.path);
              break;
            case 'Akta':
              _aktaImage = File(image.path);
              break;
            case 'KK':
              _kkImage = File(image.path);
              break;
            case 'Pas Foto':
              _pasFotoImage = File(image.path);
              break;
          }
        });

        // Tampilkan pesan sukses
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Foto $docType berhasil dipilih dari galeri'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error memilih foto: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Dialog ketika kamera tidak tersedia
  void _showCameraNotAvailableDialog(String docType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kamera Tidak Tersedia'),
          content: const Text(
            'Kamera tidak tersedia pada device ini. Apakah Anda ingin memilih foto dari galeri?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImageFromGallery(docType);
              },
              child: const Text('Pilih dari Galeri'),
            ),
          ],
        );
      },
    );
  }

  // Method untuk menampilkan dialog pilihan sumber gambar
  void _showImageSourceDialog(String docType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Sumber Gambar'),
          content: Text('Dari mana Anda ingin mengambil foto $docType?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImageFromCamera(docType);
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 8),
                  Text('Kamera'),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImageFromGallery(docType);
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(width: 8),
                  Text('Galeri'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

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
              _uploadCard("KTP", _ktpImage),
              _uploadCard("Ijazah", _ijazahImage),
              _uploadCard("Akta", _aktaImage),
              _uploadCard("KK", _kkImage),
              _uploadCard("Pas Foto", _pasFotoImage),
            ],
          ),
        ),
      ),
    );
  }

  Widget _uploadCard(String title, File? image) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: image != null ? Colors.green.shade300 : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(8),
        color: image != null ? Colors.green.shade50 : Colors.white,
      ),
      child: Row(
        children: [
          Icon(
            image != null ? Icons.check_circle : Icons.insert_drive_file,
            color: image != null ? Colors.green : Colors.blue,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: image != null ? Colors.green.shade700 : Colors.black,
                  ),
                ),
                if (image != null)
                  Text(
                    image.path.split('/').last,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
              ],
            ),
          ),
          if (image != null) ...[
            // Preview gambar kecil
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.file(image, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 8),
          ],
          IconButton(
            onPressed: () {
              _showImageSourceDialog(title);
            },
            icon: Icon(
              image != null ? Icons.edit : Icons.upload,
              color: image != null ? Colors.orange : const Color(0xFF4F6C7A),
              size: 24,
            ),
            style: IconButton.styleFrom(
              backgroundColor:
                  image != null
                      ? Colors.orange.withOpacity(0.1)
                      : const Color(0xFF4F6C7A).withOpacity(0.1),
              padding: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
