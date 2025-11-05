import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/formulir_service.dart';

class DataAkademikPage extends StatefulWidget {
  final Map<String, dynamic>? savedData;
  final Function(Map<String, dynamic>) onDataChanged;
  final VoidCallback? onNext; // Tambahkan callback untuk next
  final VoidCallback? onPrevious; // Tambahkan callback untuk previous

  const DataAkademikPage({
    super.key,
    this.savedData,
    required this.onDataChanged,
    this.onNext,
    this.onPrevious,
  });

  @override
  State<DataAkademikPage> createState() => _DataAkademikPageState();
}

class _DataAkademikPageState extends State<DataAkademikPage> {
  String? _selectedTahunLulus;
  String? _selectedJurusan;
  String? _selectedProdi;

  final TextEditingController _asalSekolahController = TextEditingController();
  final TextEditingController _nilaiRataController = TextEditingController();

  void _notifyDataChanged() {
    Map<String, dynamic> data = {
      'asalSekolah': _asalSekolahController.text,
      'tahunLulus': _selectedTahunLulus,
      'nilaiRata': _nilaiRataController.text,
    };

    if (_selectedJurusan != null) {
      data['jurusan'] = _selectedJurusan;
    }
    if (_selectedProdi != null) {
      data['prodi'] = _selectedProdi;
    }

    widget.onDataChanged(data);
  }

  bool _isFormValid() {
    return _asalSekolahController.text.isNotEmpty &&
        _selectedTahunLulus != null &&
        _selectedJurusan != null &&
        _selectedProdi != null;
  }

  void _setupTextFieldListeners() {
    _asalSekolahController.addListener(_notifyDataChanged);
    _nilaiRataController.addListener(_notifyDataChanged);
  }

  Future<void> _submitData() async {
    if (!_isFormValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Harap isi semua data dengan lengkap")),
      );
      return;
    }

    // Ambil id_mahasiswa dari SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final idMahasiswa = prefs.getInt('id_mahasiswa') ?? 0;

    if (idMahasiswa == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                "ID Mahasiswa tidak ditemukan. Silakan isi Data Pribadi terlebih dahulu.")),
      );
      return;
    }

    // Siapkan data yang akan dikirim ke server
    final formData = {
      "asal_sekolah": _asalSekolahController.text,
      "tahun_lulus": _selectedTahunLulus,
      "nilai_rata_rata": _nilaiRataController.text,
      "jurusan": _selectedJurusan,
      "prodi": _selectedProdi,
    };

    // Tampilkan loading indikator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    // Kirim ke server via FormulirService
    final result = await FormulirService.uploadDataAkademik(formData);

    Navigator.pop(context); // Tutup loading

    if (result["status"] == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(" Data Akademik berhasil dikirim")),
      );
      if (widget.onNext != null)
        widget.onNext!(); // Lanjut ke halaman berikutnya
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(" Gagal kirim data: ${result["message"]}")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.savedData != null) {
      _asalSekolahController.text = widget.savedData?['asalSekolah'] ?? '';
      _selectedTahunLulus = widget.savedData?['tahunLulus'];
      _nilaiRataController.text = widget.savedData?['nilaiRata'] ?? '';
      _selectedJurusan = widget.savedData?['jurusan'];
      _selectedProdi = widget.savedData?['prodi'];
    }
    _setupTextFieldListeners();
  }

  @override
  void dispose() {
    _asalSekolahController.removeListener(_notifyDataChanged);
    _nilaiRataController.removeListener(_notifyDataChanged);
    _asalSekolahController.dispose();
    _nilaiRataController.dispose();
    super.dispose();
  }

  List<String> _getTahunLulusList() {
    final currentYear = DateTime.now().year;
    final List<String> years = [];
    for (int year = currentYear; year >= 2018; year--) {
      years.add(year.toString());
    }
    return years;
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
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                    "Masukkan Nama Sekolah",
                    controller: _asalSekolahController,
                  ),

                  // Tahun Lulus - Dropdown
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tahun Lulus",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedTahunLulus,
                        isExpanded: true,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Pilih tahun lulus",
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
                            borderSide:
                                const BorderSide(color: Color(0xFF4F6C7A)),
                          ),
                        ),
                        items: _getTahunLulusList().map((String tahun) {
                          return DropdownMenuItem<String>(
                            value: tahun,
                            child: Text(
                              tahun,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedTahunLulus = newValue;
                            _notifyDataChanged();
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Nilai Rata-rata
                  _inputField(
                    "Nilai Rata-rata",
                    "Masukkan nilai rata-rata",
                    controller: _nilaiRataController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),

                  // Jurusan yang Dipilih - Dropdown
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Jurusan yang Dipilih",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedJurusan,
                        isExpanded: true,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
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
                            borderSide:
                                const BorderSide(color: Color(0xFF4F6C7A)),
                          ),
                        ),
                        items: _getJurusanList().map((String jurusan) {
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
                            _selectedProdi = null;
                            _notifyDataChanged();
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Prodi yang Dipilih - Dropdown
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
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
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
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xFF4F6C7A),
                              ),
                            ),
                          ),
                          items: _getProdiList(_selectedJurusan)
                              .map((String prodi) {
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
                              _notifyDataChanged();
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

          // Navigation Buttons
          const SizedBox(height: 16),
          Row(
            children: [
              // Tombol Sebelumnya
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onPrevious,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 8),
                      Text("Sebelumnya"),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Tombol Selanjutnya
              Expanded(
                child: ElevatedButton(
                  onPressed: _isFormValid() ? _submitData : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid()
                        ? const Color(0xFF233746)
                        : Colors.grey.shade300,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: _isFormValid() ? 2 : 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Selanjutnya",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
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
