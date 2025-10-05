import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DokumenTab extends StatefulWidget {
  const DokumenTab({super.key});

  @override
  State<DokumenTab> createState() => _DokumenTabState();
}

class _DokumenTabState extends State<DokumenTab> {
  final ImagePicker _picker = ImagePicker();
  File? _ktpImage;

  // Method untuk mengambil gambar dari kamera
  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        setState(() {
          _ktpImage = File(image.path);
        });

        // Tampilkan pesan sukses
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Foto KTP berhasil diambil'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        // Jika kamera tidak tersedia, tawarkan opsi galeri
        if (e.toString().contains('no_available_camera')) {
          _showCameraNotAvailableDialog();
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
  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        setState(() {
          _ktpImage = File(image.path);
        });

        // Tampilkan pesan sukses
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Foto KTP berhasil dipilih dari galeri'),
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
  void _showCameraNotAvailableDialog() {
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
                _pickImageFromGallery();
              },
              child: const Text('Pilih dari Galeri'),
            ),
          ],
        );
      },
    );
  }

  // Method untuk menampilkan dialog pilihan sumber gambar
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Sumber Gambar'),
          content: const Text('Dari mana Anda ingin mengambil foto KTP?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImageFromCamera();
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
                _pickImageFromGallery();
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
          // Header
          const Row(
            children: [
              Icon(Icons.folder, color: Color(0xFF4F6C7A), size: 24),
              SizedBox(width: 8),
              Text(
                'Dokumen',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Dokumen yang telah diupload',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          // Document List
          _buildDocumentItem('Ijazah/SKL', 'ijazah_2024.pdf', 'verified'),
          _buildDocumentItem(
            'Kartu Keluarga',
            'kartu_keluarga.pdf',
            'verified',
          ),
          _buildDocumentItem(
            'Akta Kelahiran',
            'akta_kelahiran.pdf',
            'uploaded',
          ),
          _buildDocumentItem('Pas Foto 3x4', 'pas_foto.jpg', 'uploaded'),
          _buildDocumentItem(
            'KTP',
            _ktpImage?.path.split('/').last ?? '',
            _ktpImage != null ? 'uploaded' : 'not_uploaded',
          ),
          _buildDocumentItem('Transkrip Nilai', '', 'not_uploaded'),
        ],
      ),
    );
  }

  Widget _buildDocumentItem(String title, String filename, String status) {
    // Determine colors and icon based on status
    Color backgroundColor;
    Color borderColor;
    Color iconColor;
    IconData iconData;
    Color titleColor;
    bool showFilename;
    bool showViewButton;
    bool showUploadButton;

    switch (status) {
      case 'verified':
        backgroundColor = Colors.green.shade50;
        borderColor = Colors.green.shade200;
        iconColor = Colors.green;
        iconData = Icons.check_circle;
        titleColor = Colors.green.shade700;
        showFilename = true;
        showViewButton = true;
        showUploadButton = true;
        break;
      case 'uploaded':
        backgroundColor = Colors.orange.shade50;
        borderColor = Colors.orange.shade200;
        iconColor = Colors.orange;
        iconData = Icons.pending;
        titleColor = Colors.orange.shade700;
        showFilename = true;
        showViewButton = true;
        showUploadButton = true;
        break;
      case 'not_uploaded':
      default:
        backgroundColor = Colors.grey.shade50;
        borderColor = Colors.grey.shade300;
        iconColor = Colors.grey.shade600;
        iconData = Icons.pending;
        titleColor = Colors.grey.shade700;
        showFilename = false;
        showViewButton = false;
        showUploadButton = true;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color:
                  status == 'not_uploaded'
                      ? Colors.grey.shade200
                      : Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 20),
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
                    color: titleColor,
                  ),
                ),
                if (showFilename)
                  Row(
                    children: [
                      if (title == 'KTP' && _ktpImage != null) ...[
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.file(_ktpImage!, fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Expanded(
                        child: Text(
                          filename,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (showViewButton && showUploadButton)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    // TODO: Implement download/view functionality
                    print('View $filename');
                  },
                  icon: const Icon(
                    Icons.visibility,
                    color: Color(0xFF4F6C7A),
                    size: 20,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Implement upload/re-upload functionality
                    print('Upload $title');
                  },
                  icon: const Icon(
                    Icons.upload,
                    color: Color(0xFF4F6C7A),
                    size: 20,
                  ),
                ),
              ],
            )
          else if (showUploadButton)
            IconButton(
              onPressed: () {
                if (title == 'KTP') {
                  _showImageSourceDialog();
                } else {
                  // TODO: Implement upload functionality for other documents
                  print('Upload $title');
                }
              },
              icon: const Icon(
                Icons.upload,
                color: Color(0xFF4F6C7A),
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
