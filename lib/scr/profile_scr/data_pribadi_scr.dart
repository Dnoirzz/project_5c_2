import 'package:flutter/material.dart';

class DataPribadiTab extends StatelessWidget {
  final Map<String, dynamic> dataPribadi; // ⬅️ data dari luar

  const DataPribadiTab({super.key, required this.dataPribadi});

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
          const Row(
            children: [
              Icon(Icons.person, color: Color(0xFF4F6C7A), size: 24),
              SizedBox(width: 8),
              Text(
                'Data Pribadi',
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
            'Informasi personal dan kontak',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          //  ambil dari map dataPribadi
          _buildInfoField('Nama Lengkap', dataPribadi['nama_lengkap'] ?? '-'),
          _buildInfoField('NIK', dataPribadi['nik'] ?? '-'),
          _buildInfoField('Tempat Lahir', dataPribadi['tempat_lahir'] ?? '-'),
          _buildInfoField('Tanggal Lahir', dataPribadi['tanggal_lahir'] ?? '-'),
          _buildInfoField('No. HP', dataPribadi['no_hp'] ?? '-'),
          _buildInfoField('Email', dataPribadi['email'] ?? '-'),
          _buildInfoField('Jenis Kelamin', dataPribadi['jenis_kelamin'] ?? '-'),
          _buildInfoField('Alamat', dataPribadi['alamat'] ?? '-'),
          _buildInfoField('Provinsi', dataPribadi['provinsi'] ?? '-'),
          _buildInfoField('Kabupaten/Kota', dataPribadi['kota'] ?? '-'),
          _buildInfoField('Kecamatan', dataPribadi['kecamatan'] ?? '-'),
          _buildInfoField('Kelurahan/Desa', dataPribadi['kelurahan'] ?? '-'),
          _buildInfoField('Kode Pos', dataPribadi['kode_pos'] ?? '-'),
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
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
