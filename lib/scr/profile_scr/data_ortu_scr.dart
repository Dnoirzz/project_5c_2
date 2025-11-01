import 'package:flutter/material.dart';

class DataOrtuTab extends StatelessWidget {
  final Map<String, dynamic> dataOrangTua;

  const DataOrtuTab({super.key, required this.dataOrangTua});

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
              Icon(Icons.school, color: Color(0xFF4F6C7A), size: 24),
              SizedBox(width: 8),
              Text(
                'Informasi Orang Tua',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          _buildSection('Data Ayah', [
            _buildInfoField('Nama Ayah', dataOrangTua['nama_ayah'] ?? '-'),
            _buildInfoField('NIK Ayah', dataOrangTua['nik_ayah'] ?? '-'),
            _buildInfoField(
                'Pekerjaan Ayah', dataOrangTua['pekerjaan_ayah'] ?? '-'),
            _buildInfoField('No. HP Ayah', dataOrangTua['nohp_ayah'] ?? '-'),
            _buildInfoField(
                'Penghasilan Ayah', dataOrangTua['penghasilan_ayah'] ?? '-'),
            _buildInfoField('Alamat Ayah', dataOrangTua['alamat_ayah'] ?? '-'),
          ]),
          const SizedBox(height: 20),
          _buildSection('Data Ibu', [
            _buildInfoField('Nama Ibu', dataOrangTua['nama_ibu'] ?? '-'),
            _buildInfoField('NIK Ibu', dataOrangTua['nik_ibu'] ?? '-'),
            _buildInfoField(
                'Pekerjaan Ibu', dataOrangTua['pekerjaan_ibu'] ?? '-'),
            _buildInfoField('No. HP Ibu', dataOrangTua['nohp_ibu'] ?? '-'),
            _buildInfoField(
                'Penghasilan Ibu', dataOrangTua['penghasilan_ibu'] ?? '-'),
            _buildInfoField('Alamat Ibu', dataOrangTua['alamat_ibu'] ?? '-'),
          ]),
        ],
      ),
    );
  }

  static Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  static Widget _buildInfoField(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
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
