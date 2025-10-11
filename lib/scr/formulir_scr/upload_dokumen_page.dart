import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadDokumenPage extends StatefulWidget {
  final Map<String, dynamic>? savedData;
  final Function(Map<String, dynamic>)? onDataChanged;

  const UploadDokumenPage({
    super.key,
    this.savedData,
    this.onDataChanged,
  });

  @override
  State<UploadDokumenPage> createState() => _UploadDokumenPageState();
}

class _UploadDokumenPageState extends State<UploadDokumenPage> {
  final ImagePicker _picker = ImagePicker();

  Map<String, File?> _images = {
    'Ijazah/SKL': null,
    'Kartu Keluarga': null,
    'Akta Kelahiran': null,
    'Pas Foto 3x4': null,
  };

  Map<String, DateTime?> _uploadDates = {
    'Ijazah/SKL': null,
    'Kartu Keluarga': null,
    'Akta Kelahiran': null,
    'Pas Foto 3x4': null,
  };

  @override
  void initState() {
    super.initState();
    // Load saved data if available
    if (widget.savedData != null) {
      _loadSavedData();
    }
  }

  @override
  void didUpdateWidget(UploadDokumenPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reload data if savedData changes
    if (widget.savedData != oldWidget.savedData) {
      _loadSavedData();
    }
  }

  void _loadSavedData() {
    if (widget.savedData == null) return;

    final data = widget.savedData!;

    // Load images from saved paths
    setState(() {
      if (data['ijazah']?.isNotEmpty == true) {
        _images['Ijazah/SKL'] = File(data['ijazah']);
        _uploadDates['Ijazah/SKL'] =
            DateTime.now(); // Or save actual date if needed
      }

      if (data['kk']?.isNotEmpty == true) {
        _images['Kartu Keluarga'] = File(data['kk']);
        _uploadDates['Kartu Keluarga'] = DateTime.now();
      }

      if (data['akta']?.isNotEmpty == true) {
        _images['Akta Kelahiran'] = File(data['akta']);
        _uploadDates['Akta Kelahiran'] = DateTime.now();
      }

      if (data['foto']?.isNotEmpty == true) {
        _images['Pas Foto 3x4'] = File(data['foto']);
        _uploadDates['Pas Foto 3x4'] = DateTime.now();
      }
    });
  }

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
          _images[docType] = File(image.path);
          _uploadDates[docType] = DateTime.now();
        });

        // Notify parent about the change
        _notifyDataChanged();

        // Tampilkan pesan sukses
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Foto $docType berhasil diambil'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error mengambil foto: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _notifyDataChanged() {
    if (widget.onDataChanged != null) {
      // Check if at least one document is uploaded
      bool hasUpload = _images.values.any((file) => file != null);

      widget.onDataChanged!({
        'uploaded': hasUpload,
        'ijazah': _images['Ijazah/SKL']?.path,
        'kk': _images['Kartu Keluarga']?.path,
        'akta': _images['Akta Kelahiran']?.path,
        'foto': _images['Pas Foto 3x4']?.path,
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Ags',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];
    return 'Upload ${date.day} ${months[date.month - 1]}, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
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
              // Header
              const Row(
                children: [
                  Icon(Icons.upload_file, color: Colors.blue, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Upload Dokumen",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                "Upload berkas pendaftaran",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // Info card
              const SizedBox(height: 16),

              // Upload cards
              ..._images.keys.map((docType) => _buildDocumentCard(docType)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentCard(String docType) {
    final image = _images[docType];
    final uploadDate = _uploadDates[docType];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Camera icon and title
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Icon(
              Icons.camera_alt_outlined,
              color: Colors.grey.shade600,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),

          // Document title
          Text(
            docType,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          // Upload date (if exists)
          if (uploadDate != null) ...[
            const SizedBox(height: 4),
            Text(
              _formatDate(uploadDate),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Ambil foto button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _pickImageFromCamera(docType),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    image != null ? Colors.green.shade50 : Colors.white,
                foregroundColor: image != null
                    ? Colors.green.shade700
                    : const Color(0xFF4F6C7A),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: image != null
                        ? Colors.green.shade300
                        : Colors.grey.shade300,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    image != null ? Icons.check_circle : Icons.camera_alt,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    image != null ? 'Foto sudah diambil' : 'Ambil foto',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Preview gambar (jika ada)
          if (image != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                image,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
