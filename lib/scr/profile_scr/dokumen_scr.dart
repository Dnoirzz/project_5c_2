import 'package:flutter/material.dart';

class DokumenTab extends StatelessWidget {
  const DokumenTab({super.key});

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
            color: Colors.black.withValues(alpha: 0.05),
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

          // Document List - sesuai dengan formulir pendaftaran
          _buildDocumentItem('KTP', 'ktp_aldi_mahendra.jpg', 'verified'),
          _buildDocumentItem('Ijazah', 'ijazah_sma_2024.pdf', 'verified'),
          _buildDocumentItem('Akta', 'akta_kelahiran_aldi.pdf', 'uploaded'),
          _buildDocumentItem('KK', 'kartu_keluarga_mahendra.pdf', 'uploaded'),
          _buildDocumentItem('Pas Foto', 'pas_foto_aldi_3x4.jpg', 'uploaded'),
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

    switch (status) {
      case 'verified':
        backgroundColor = Colors.green.shade50;
        borderColor = Colors.green.shade200;
        iconColor = Colors.green;
        iconData = Icons.check_circle;
        titleColor = Colors.green.shade700;
        showFilename = true;
        showViewButton = true;
        break;
      case 'uploaded':
        backgroundColor = Colors.orange.shade50;
        borderColor = Colors.orange.shade200;
        iconColor = Colors.orange;
        iconData = Icons.pending;
        titleColor = Colors.orange.shade700;
        showFilename = true;
        showViewButton = true;
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
              color: status == 'not_uploaded'
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
                  Text(
                    filename,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
              ],
            ),
          ),
          if (showViewButton)
            IconButton(
              onPressed: () {
                // TODO: Implement download/view functionality
                // Debug: View $filename
              },
              icon: const Icon(
                Icons.visibility,
                color: Color(0xFF4F6C7A),
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
