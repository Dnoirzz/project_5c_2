import 'package:flutter/material.dart';

class ReviewSubmitPage extends StatefulWidget {
  final Map<int, Map<String, dynamic>> formData;
  final Map<int, bool> pagesSaved;
  final Function(int) onPageEdit;

  const ReviewSubmitPage({
    super.key,
    required this.formData,
    required this.pagesSaved,
    required this.onPageEdit,
  });

  @override
  State<ReviewSubmitPage> createState() => _ReviewSubmitPageState();
}

class _ReviewSubmitPageState extends State<ReviewSubmitPage> {
  Map<int, bool> expandedStates = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      expandedStates[i] = false;
    }
  }

  Color _getStatusColor(int pageIndex) {
    bool hasData = widget.formData[pageIndex]?.isNotEmpty == true;
    bool isSaved = widget.pagesSaved[pageIndex] == true;
    bool isComplete = _checkPageCompletion(pageIndex);

    if (!hasData) {
      return Colors.grey; // Belum diisi
    } else if (isSaved && !isComplete) {
      return Colors.amber; // Simpan draft, belum lengkap
    } else if (isComplete) {
      return const Color(0xFF009137); // Lengkap
    } else {
      return Colors.grey; // Default
    }
  }

  bool _checkPageCompletion(int pageIndex) {
    final data = widget.formData[pageIndex] ?? {};

    switch (pageIndex) {
      case 0: // Data Pribadi
        return data['namaLengkap']?.isNotEmpty == true &&
            data['nik']?.isNotEmpty == true &&
            data['tempatLahir']?.isNotEmpty == true &&
            data['tanggalLahir'] != null &&
            data['jenisKelamin']?.isNotEmpty == true &&
            data['alamat']?.isNotEmpty == true &&
            data['province'] != null;

      case 1: // Data Akademik
        return data['asalSekolah']?.isNotEmpty == true &&
            data['tahunLulus']?.isNotEmpty == true &&
            data['jurusan']?.isNotEmpty == true &&
            data['prodi']?.isNotEmpty == true;

      case 2: // Data Orang Tua
        return data['namaAyah']?.isNotEmpty == true &&
            data['pekerjaanAyah']?.isNotEmpty == true &&
            data['namaIbu']?.isNotEmpty == true &&
            data['pekerjaanIbu']?.isNotEmpty == true;

      case 3: // Upload Dokumen
        return data['uploaded'] == true;

      default:
        return false;
    }
  }

  String _getStatusText(int pageIndex) {
    bool hasData = widget.formData[pageIndex]?.isNotEmpty == true;
    bool isSaved = widget.pagesSaved[pageIndex] == true;
    bool isComplete = _checkPageCompletion(pageIndex);

    if (!hasData) {
      return "Belum diisi";
    } else if (isSaved && !isComplete) {
      return "Draft tersimpan";
    } else if (isComplete) {
      return "Lengkap";
    } else {
      return "Belum lengkap";
    }
  }

  Widget _buildDetailContent(int pageIndex) {
    final data = widget.formData[pageIndex] ?? {};

    switch (pageIndex) {
      case 0: // Data Pribadi
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailItem("Nama Lengkap", data['namaLengkap'] ?? '-'),
            _detailItem("NIK", data['nik'] ?? '-'),
            _detailItem("Tempat Lahir", data['tempatLahir'] ?? '-'),
            _detailItem(
                "Tanggal Lahir", data['tanggalLahir']?.toString() ?? '-'),
            _detailItem("Jenis Kelamin", data['jenisKelamin'] ?? '-'),
            _detailItem("Alamat", data['alamat'] ?? '-'),
            _detailItem("Provinsi", data['province']?.toString() ?? '-'),
          ],
        );
      case 1: // Data Akademik
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailItem("Asal Sekolah", data['asalSekolah'] ?? '-'),
            _detailItem("Tahun Lulus", data['tahunLulus'] ?? '-'),
            _detailItem("Jurusan", data['jurusan'] ?? '-'),
            _detailItem("Program Studi", data['prodi'] ?? '-'),
          ],
        );
      case 2: // Data Orang Tua
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Data Ayah section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Data Ayah",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F6C7A),
                  ),
                ),
                const SizedBox(height: 8),
                _detailItem("Nama Lengkap", data['namaAyah'] ?? '-'),
                _detailItem("Pekerjaan", data['pekerjaanAyah'] ?? '-'),
                _detailItem("No. Telepon", data['noTlpAyah'] ?? '-'),
                _detailItem("Alamat", data['alamatAyah'] ?? '-'),
                _detailItem("Penghasilan", data['penghasilanAyah'] ?? '-'),
              ],
            ),
            const SizedBox(height: 16),
            
            // Data Ibu section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Data Ibu",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F6C7A),
                  ),
                ),
                const SizedBox(height: 8),
                _detailItem("Nama Lengkap", data['namaIbu'] ?? '-'),
                _detailItem("Pekerjaan", data['pekerjaanIbu'] ?? '-'),
                _detailItem("No. Telepon", data['noTlpIbu'] ?? '-'),
                _detailItem("Alamat", data['alamatIbu'] ?? '-'),
                _detailItem("Penghasilan", data['penghasilanIbu'] ?? '-'),
              ],
            ),
          ],
        );
      case 3: // Upload Dokumen
        final dokumenList = [
          {"label": "KTP", "key": "ktp", "icon": Icons.credit_card},
          {"label": "Kartu Keluarga", "key": "kk", "icon": Icons.people},
          {"label": "Ijazah", "key": "ijazah", "icon": Icons.school},
          {"label": "Pas Foto", "key": "foto", "icon": Icons.photo_camera},
          {"label": "SKHUN", "key": "skhun", "icon": Icons.description},
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailItem(
                "Status",
                data['uploaded'] == true
                    ? 'Dokumen telah diupload'
                    : 'Belum upload dokumen'),
            const SizedBox(height: 8),
            for (var dok in dokumenList)
              Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Icon(dok["icon"] as IconData,
                      color: data[dok["key"]] != null
                          ? const Color(0xFF009137)
                          : Colors.grey),
                  title: Text(
                    dok["label"] as String,
                    style: const TextStyle(fontSize: 13),
                  ),
                  trailing: data[dok["key"]] != null
                      ? IconButton(
                          icon: const Icon(Icons.visibility, size: 20),
                          onPressed: () {
                            // Show document preview dialog
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Preview ${dok["label"]}"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: data[dok["key"]] != null
                                          ? Image.network(
                                              data[dok["key"]] as String,
                                              fit: BoxFit.contain,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  const Center(
                                                      child: Text(
                                                          "Gagal memuat dokumen")),
                                            )
                                          : const Center(
                                              child: Text(
                                                  "Dokumen tidak tersedia")),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Tutup"),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : const Icon(Icons.visibility_off,
                          size: 20, color: Colors.grey),
                ),
              ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _detailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          const Text(" : "),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _reviewCard(0, "Data Pribadi", "Nama, NIK, dan informasi lainnya"),
          _reviewCard(1, "Data Akademik", "Asal sekolah dan pilihan prodi"),
          _reviewCard(2, "Data Orang Tua", "Informasi orang tua dan wali"),
          _reviewCard(3, "Dokumen", "Dokumen telah diupload"),
        ],
      ),
    );
  }

  Widget _reviewCard(int pageIndex, String title, String desc) {
    Color statusColor = _getStatusColor(pageIndex);
    String statusText = _getStatusText(pageIndex);
    bool isExpanded = expandedStates[pageIndex] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              expandedStates[pageIndex] = !isExpanded;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      _checkPageCompletion(pageIndex)
                          ? Icons.check_circle
                          : widget.pagesSaved[pageIndex] == true
                              ? Icons.save
                              : Icons.radio_button_unchecked,
                      color: statusColor,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            desc,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            statusText,
                            style: TextStyle(
                              fontSize: 12,
                              color: statusColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.black54,
                      size: 24,
                    ),
                  ],
                ),
              ),
              if (isExpanded)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(56, 0, 16, 16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                  ),
                  child: _buildDetailContent(pageIndex),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
