import 'package:flutter/material.dart';

class DataOrtuTab extends StatelessWidget {
  const DataOrtuTab({super.key});

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
              Icon(Icons.family_restroom, color: Color(0xFF4F6C7A), size: 24),
              SizedBox(width: 8),
              Text(
                'Data Orang Tua',
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
            'Informasi orang tua dan wali',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          // Data Ayah
          const Text(
            'Data Ayah',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4F6C7A),
            ),
          ),
          const SizedBox(height: 12),
          _buildInfoField('Nama Ayah', 'Budi Pratama'),
          _buildInfoField('NIK Ayah', '3201234567890123'),
          _buildInfoField('Pekerjaan Ayah', 'PNS'),
          _buildInfoField('No. Telepon Ayah', '081234567891'),
          _buildInfoField('Penghasilan Ayah', 'RP 5.000.000 - RP 10.000.000'),
          _buildInfoField('Alamat Ayah', 'Jl. Merdeka No. 45, Jakarta Selatan'),

          const SizedBox(height: 20),

          // Data Ibu
          const Text(
            'Data Ibu',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4F6C7A),
            ),
          ),
          const SizedBox(height: 12),
          _buildInfoField('Nama Ibu', 'Siti Rahayu'),
          _buildInfoField('NIK Ibu', '3201234567890124'),
          _buildInfoField('Pekerjaan Ibu', 'Ibu Rumah Tangga'),
          _buildInfoField('No. Telepon Ibu', '081234567892'),
          _buildInfoField('Penghasilan Ibu', '<RP500.000'),
          _buildInfoField('Alamat Ibu', 'Jl. Merdeka No. 45, Jakarta Selatan'),
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
