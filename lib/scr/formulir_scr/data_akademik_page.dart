import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataAkademikPage extends StatefulWidget {
  const DataAkademikPage({super.key});

  @override
  State<DataAkademikPage> createState() => _DataAkademikPageState();
}

class _DataAkademikPageState extends State<DataAkademikPage> {
  DateTime? _tahunLulus;
  String? _selectedJurusan;
  String? _selectedProdi;

  // TextEditingController untuk setiap field
  final TextEditingController _asalSekolahController = TextEditingController();
  final TextEditingController _nilaiRataController = TextEditingController();

  @override
  void dispose() {
    _asalSekolahController.dispose();
    _nilaiRataController.dispose();
    super.dispose();
  }

  Future<void> _pickTahunLulus() async {
    final currentYear = DateTime.now().year;
    final picked = await showDatePicker(
      context: context,
      initialDate: _tahunLulus ?? DateTime(currentYear - 1),
      firstDate: DateTime(1950), // Tahun minimal 1950
      lastDate: DateTime(currentYear), // Tidak bisa pilih tahun masa depan
      initialDatePickerMode: DatePickerMode.year, // ✅ Hanya tampilkan tahun
    );
    if (picked != null) {
      setState(() => _tahunLulus = picked);
    }
  }

  String _formatTahunLulus() {
    if (_tahunLulus == null) return "Pilih tahun lulus";
    return DateFormat('yyyy').format(_tahunLulus!);
  }

  List<String> _getJurusanList() {
    return ['Teknik Elektro', 'Teknik Sipil', 'Akuntansi'];
  }

  List<String> _getProdiList(String? jurusan) {
    switch (jurusan) {
      case 'Teknik Elektro':
        return [
          'D3 - Teknik Listrik',
          'D3 - Teknik Informatika',
          'D4 - Teknik Rekayasa Sistem Elektronika',
        ];
      case 'Teknik Sipil':
        return [
          'D3 - Teknik Sipil',
          'D4 - Teknologi Rekayasa Kontruksi Jalan & Jembatan',
          'D4 - Perencanaan Perumahan & Permukiman',
        ];
      case 'Akuntansi':
        return ['Akuntansi', 'Manajemen', 'Keuangan'];
      default:
        return [];
    }
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
                  Icon(Icons.school, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    "Data Akademik",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                "Informasi pendidikan dan akademik",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // Asal Sekolah
              _inputField(
                "Asal Sekolah",
                "Masukkan nama sekolah asal",
                controller: _asalSekolahController,
              ),

              // Tahun Lulus Picker
              InkWell(
                onTap: _pickTahunLulus,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Tahun Lulus",
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF4F6C7A)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatTahunLulus(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(Icons.calendar_today, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Nilai Rata-rata
              _inputField(
                "Nilai Rata-rata",
                "Masukkan nilai rata-rata",
                controller: _nilaiRataController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),

              // Jurusan yang Dipilih - Dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Jurusan yang Dipilih",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedJurusan,
                    isExpanded: true,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Pilih jurusan",
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
                        _getJurusanList().map((String jurusan) {
                          return DropdownMenuItem<String>(
                            value: jurusan,
                            child: Text(
                              jurusan,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedJurusan = newValue;
                        // Reset prodi ketika jurusan berubah
                        _selectedProdi = null;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Prodi yang Dipilih - Dropdown (hanya tampil jika jurusan sudah dipilih)
              if (_selectedJurusan != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Prodi yang Dipilih",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedProdi,
                      isExpanded: true,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Pilih program studi",
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
                          borderSide: const BorderSide(
                            color: Color(0xFF4F6C7A),
                          ),
                        ),
                      ),
                      items:
                          _getProdiList(_selectedJurusan).map((String prodi) {
                            return DropdownMenuItem<String>(
                              value: prodi,
                              child: Text(
                                prodi,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedProdi = newValue;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
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
