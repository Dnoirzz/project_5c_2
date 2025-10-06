import 'package:flutter/material.dart';

class InformasiAkademikTab extends StatelessWidget {
  const InformasiAkademikTab({super.key});

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
              Icon(Icons.school, color: Color(0xFF4F6C7A), size: 24),
              SizedBox(width: 8),
              Text(
                'Informasi Akademik',
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
            'Data pendidikan dan program studi',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          // Content Fields - sesuai dengan formulir pendaftaran
          _buildInfoField('Asal Sekolah', 'SMA Negeri 1 Jakarta'),
          _buildInfoField('Tahun Lulus', '2024'),
          _buildInfoField('Nilai Rata-rata', '85.5'),
          _buildInfoField('Jurusan yang Dipilih', 'Teknik Elektro'),
          _buildInfoField('Prodi yang Dipilih', 'D3 - Teknik Listrik'),
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                decorationColor: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
