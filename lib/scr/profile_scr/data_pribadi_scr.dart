import 'package:flutter/material.dart';

class DataPribadiTab extends StatelessWidget {
  const DataPribadiTab({super.key});

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

          // Content Fields - sesuai dengan formulir pendaftaran
          _buildInfoField('Nama Lengkap', 'Aldi Mahendra'),
          _buildInfoField('NIK', '1234567890123456'),
          _buildInfoField('Tempat Lahir', 'Pontianak'),
          _buildInfoField('Tanggal Lahir', '15 Januari 2005'),
          _buildInfoField('No. HP', '081234567890'),
          _buildInfoField('Email', 'aldi.mahendra@email.com'),
          _buildInfoField('Jenis Kelamin', 'Laki-laki'),
          _buildInfoField('Alamat', 'Jl. KOYOSO No. 123'),
          _buildInfoField('Provinsi', 'Kalimantan Barat'),
          _buildInfoField('Kabupaten/Kota', 'Kota Pontianak'),
          _buildInfoField('Kecamatan', 'Pontianak Selatan'),
          _buildInfoField('Kelurahan/Desa', 'Benua Melayu Laut'),
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
