import 'package:flutter/material.dart';

class DataOrtuPage extends StatefulWidget {
  const DataOrtuPage({super.key});

  @override
  State<DataOrtuPage> createState() => _DataOrtuPageState();
}

class _DataOrtuPageState extends State<DataOrtuPage> {
  String? _selectedPenghasilanAyah;
  String? _selectedPenghasilanIbu;

  // TextEditingController untuk setiap field
  final TextEditingController _namaAyahController = TextEditingController();
  final TextEditingController _pekerjaanAyahController =
      TextEditingController();
  final TextEditingController _noTlpAyahController = TextEditingController();
  final TextEditingController _alamatAyahController = TextEditingController();

  final TextEditingController _namaIbuController = TextEditingController();
  final TextEditingController _pekerjaanIbuController = TextEditingController();
  final TextEditingController _noTlpIbuController = TextEditingController();
  final TextEditingController _alamatIbuController = TextEditingController();

  @override
  void dispose() {
    _namaAyahController.dispose();
    _pekerjaanAyahController.dispose();
    _noTlpAyahController.dispose();
    _alamatAyahController.dispose();

    _namaIbuController.dispose();
    _pekerjaanIbuController.dispose();
    _noTlpIbuController.dispose();
    _alamatIbuController.dispose();
    super.dispose();
  }

  List<String> _getPenghasilanList() {
    return [
      '<RP500.000',
      'RP500.000 - RP1000.000',
      'RP 1.000.000 - RP 3.000.000',
      'RP 3.000.000 - RP 5.000.000',
      'RP 5.000.000 - RP 10.000.000',
      'RP 10.000.000>',
    ];
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
                  Icon(Icons.family_restroom, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    "Data Orang Tua",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                "Informasi orang tua dan wali",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // Data Ayah
              const Text(
                "Data Ayah",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4F6C7A),
                ),
              ),
              const SizedBox(height: 12),

              // Nama Ayah
              _inputField(
                "Nama Ayah",
                "Masukkan nama ayah",
                controller: _namaAyahController,
              ),

              // Pekerjaan Ayah
              _inputField(
                "Pekerjaan Ayah",
                "Masukkan pekerjaan ayah",
                controller: _pekerjaanAyahController,
              ),

              // No. Telepon Ayah
              _inputField(
                "No. Telepon Ayah",
                "Masukkan nomor telepon ayah",
                controller: _noTlpAyahController,
                keyboardType: TextInputType.phone,
              ),

              // Penghasilan Ayah - Dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Penghasilan Ayah",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedPenghasilanAyah,
                    isExpanded: true,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Pilih range penghasilan",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF4F6C7A)),
                      ),
                    ),
                    items:
                        _getPenghasilanList().map((String penghasilan) {
                          return DropdownMenuItem<String>(
                            value: penghasilan,
                            child: Text(
                              penghasilan,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPenghasilanAyah = newValue;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Alamat Ayah
              _inputField(
                "Alamat Ayah",
                "Masukkan alamat ayah",
                controller: _alamatAyahController,
                maxLines: 3,
              ),

              const SizedBox(height: 20),

              // Data Ibu
              const Text(
                "Data Ibu",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4F6C7A),
                ),
              ),
              const SizedBox(height: 12),

              // Nama Ibu
              _inputField(
                "Nama Ibu",
                "Masukkan nama ibu",
                controller: _namaIbuController,
              ),

              // Pekerjaan Ibu
              _inputField(
                "Pekerjaan Ibu",
                "Masukkan pekerjaan ibu",
                controller: _pekerjaanIbuController,
              ),

              // No. Telepon Ibu
              _inputField(
                "No. Telepon Ibu",
                "Masukkan nomor telepon ibu",
                controller: _noTlpIbuController,
                keyboardType: TextInputType.phone,
              ),

              // Penghasilan Ibu - Dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Penghasilan Ibu",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedPenghasilanIbu,
                    isExpanded: true,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Pilih range penghasilan",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF4F6C7A)),
                      ),
                    ),
                    items:
                        _getPenghasilanList().map((String penghasilan) {
                          return DropdownMenuItem<String>(
                            value: penghasilan,
                            child: Text(
                              penghasilan,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPenghasilanIbu = newValue;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Alamat Ibu
              _inputField(
                "Alamat Ibu",
                "Masukkan alamat ibu",
                controller: _alamatIbuController,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(
    String label,
    String hint, {
    int maxLines = 1,
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF4F6C7A)),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
