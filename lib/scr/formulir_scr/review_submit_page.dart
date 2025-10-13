import 'package:flutter/material.dart';
import 'dart:io';

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

    if (!hasData) return Colors.grey;
    if (isComplete) return const Color(0xFF009137);
    if (isSaved && !isComplete) return Colors.amber;
    return Colors.amber;
  }

  bool _checkPageCompletion(int pageIndex) {
    final data = widget.formData[pageIndex] ?? {};

    switch (pageIndex) {
      case 0:
        return data['namaLengkap']?.isNotEmpty == true &&
            data['nik']?.isNotEmpty == true &&
            data['tempatLahir']?.isNotEmpty == true &&
            data['tanggalLahir'] != null &&
            data['jenisKelamin']?.isNotEmpty == true &&
            data['alamat']?.isNotEmpty == true &&
            data['province'] != null;
      case 1:
        return data['asalSekolah']?.isNotEmpty == true &&
            data['tahunLulus']?.isNotEmpty == true &&
            data['jurusan']?.isNotEmpty == true &&
            data['prodi']?.isNotEmpty == true;
      case 2:
        return data['namaAyah']?.isNotEmpty == true &&
            data['pekerjaanAyah']?.isNotEmpty == true &&
            data['namaIbu']?.isNotEmpty == true &&
            data['pekerjaanIbu']?.isNotEmpty == true;
      case 3:
        return data['ijazah']?.isNotEmpty == true &&
            data['kk']?.isNotEmpty == true &&
            data['akta']?.isNotEmpty == true &&
            data['foto']?.isNotEmpty == true;
      default:
        return false;
    }
  }

  String _getStatusText(int pageIndex) {
    bool hasData = widget.formData[pageIndex]?.isNotEmpty == true;
    bool isComplete = _checkPageCompletion(pageIndex);
    if (!hasData) return "Belum diisi";
    if (isComplete) return "Lengkap";
    return "Belum lengkap";
  }

  String _getDocumentUploadStatus() {
    final data = widget.formData[3] ?? {};
    int uploadedCount = 0;
    int totalDocs = 4;

    if (data['ijazah']?.isNotEmpty == true) uploadedCount++;
    if (data['kk']?.isNotEmpty == true) uploadedCount++;
    if (data['akta']?.isNotEmpty == true) uploadedCount++;
    if (data['foto']?.isNotEmpty == true) uploadedCount++;

    return "$uploadedCount dari $totalDocs dokumen diupload";
  }

  IconData _getIconForPage(int pageIndex) {
    bool isComplete = _checkPageCompletion(pageIndex);
    bool hasData = widget.formData[pageIndex]?.isNotEmpty == true;

    Map<int, IconData> pageIcons = {
      0: Icons.person,
      1: Icons.school,
      2: Icons.group,
      3: Icons.upload_file,
    };

    if (isComplete) return Icons.check_circle;
    if (!hasData) return Icons.radio_button_unchecked;
    return pageIcons[pageIndex] ?? Icons.radio_button_unchecked;
  }

  /// 🟢 FUNGSI UNTUK MENAMPILKAN GAMBAR DALAM POPUP
  void _showImagePopup(String imagePath, String title) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InteractiveViewer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Image.file(
                        File(imagePath),
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: 400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Ketuk di mana saja untuk menutup",
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 12),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailContent(int pageIndex) {
    final data = widget.formData[pageIndex] ?? {};

    switch (pageIndex) {
      // -------------------- DATA PRIBADI --------------------
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailItem("Nama Lengkap", data['namaLengkap'] ?? '-'),
            _detailItem("NIK", data['nik'] ?? '-'),
            _detailItem("Tempat Lahir", data['tempatLahir'] ?? '-'),
            _detailItem("Tanggal Lahir",
                data['tanggalLahir']?.toString().split('T').first ?? '-'),
            _detailItem("Jenis Kelamin", data['jenisKelamin'] ?? '-'),
            _detailItem("No. HP", data['noHp'] ?? '-'),
            _detailItem("Email", data['email'] ?? '-'),
            const SizedBox(height: 8),
            const Text("Alamat Lengkap",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF4F6C7A))),
            const SizedBox(height: 6),
            _detailItem("Alamat", data['alamat'] ?? '-'),
            _detailItem(
                "Provinsi", data['province']?['name']?.toString() ?? '-'),
            _detailItem(
                "Kabupaten/Kota", data['regency']?['name']?.toString() ?? '-'),
            _detailItem(
                "Kecamatan", data['district']?['name']?.toString() ?? '-'),
            _detailItem(
                "Kelurahan/Desa", data['village']?['name']?.toString() ?? '-'),
            _detailItem("Kode Pos", data['kodePos'] ?? '-'),
          ],
        );

      // -------------------- DATA AKADEMIK --------------------
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailItem("Asal Sekolah", data['asalSekolah'] ?? '-'),
            _detailItem("Tahun Lulus", data['tahunLulus'] ?? '-'),
            _detailItem("Nilai Rata-Rata", data['nilaiRata'] ?? '-'),
            _detailItem("Jurusan", data['jurusan'] ?? '-'),
            _detailItem("Program Studi", data['prodi'] ?? '-'),
          ],
        );

      // -------------------- DATA ORANG TUA --------------------
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Data Ayah",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF4F6C7A))),
            const SizedBox(height: 8),
            _detailItem("Nama Lengkap", data['namaAyah'] ?? '-'),
            _detailItem("Pekerjaan", data['pekerjaanAyah'] ?? '-'),
            _detailItem("No. Telepon", data['noTlpAyah'] ?? '-'),
            _detailItem("Alamat", data['alamatAyah'] ?? '-'),
            _detailItem("Penghasilan", data['penghasilanAyah'] ?? '-'),
            const SizedBox(height: 16),
            const Text("Data Ibu",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF4F6C7A))),
            const SizedBox(height: 8),
            _detailItem("Nama Lengkap", data['namaIbu'] ?? '-'),
            _detailItem("Pekerjaan", data['pekerjaanIbu'] ?? '-'),
            _detailItem("No. Telepon", data['noTlpIbu'] ?? '-'),
            _detailItem("Alamat", data['alamatIbu'] ?? '-'),
            _detailItem("Penghasilan", data['penghasilanIbu'] ?? '-'),
          ],
        );

      // -------------------- DOKUMEN --------------------
      case 3:
        final dokumenList = [
          {"label": "Ijazah/SKL", "key": "ijazah", "icon": Icons.school},
          {"label": "Kartu Keluarga", "key": "kk", "icon": Icons.people},
          {"label": "Akta Kelahiran", "key": "akta", "icon": Icons.description},
          {"label": "Pas Foto 3x4", "key": "foto", "icon": Icons.photo_camera},
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: dokumenList.map((dok) {
            String? path = data[dok['key']];
            bool uploaded = path?.isNotEmpty == true;

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: uploaded ? Colors.green.shade50 : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color:
                      uploaded ? Colors.green.shade300 : Colors.grey.shade300,
                ),
              ),
              child: Row(
                children: [
                  Icon(dok['icon'] as IconData,
                      color: uploaded ? const Color(0xFF009137) : Colors.grey,
                      size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      dok['label'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),

                  // 👁️ ICON PREVIEW GAMBAR
                  if (uploaded)
                    IconButton(
                      icon: const Icon(Icons.visibility, color: Colors.blue),
                      onPressed: () {
                        _showImagePopup(path!, dok['label'] as String);
                      },
                    ),

                  Icon(
                    uploaded ? Icons.check_circle : Icons.cancel,
                    color: uploaded
                        ? const Color(0xFF009137)
                        : Colors.grey.shade400,
                    size: 20,
                  ),
                ],
              ),
            );
          }).toList(),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _detailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 130,
              child: Text(label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey))),
          const Text(" : "),
          Expanded(
              child: Text(value,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Card(
          elevation: 2,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.reviews, color: Color(0xFF009137), size: 24),
                    SizedBox(width: 8),
                    Text("Review & Submit",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333))),
                  ],
                ),
                const SizedBox(height: 4),
                const Text("Periksa kembali data Anda sebelum mengirim",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 16),
                _reviewCard(0, "Data Pribadi", "Nama, NIK, dan alamat lengkap"),
                _reviewCard(
                    1, "Data Akademik", "Asal sekolah dan pilihan prodi"),
                _reviewCard(
                    2, "Data Orang Tua", "Informasi orang tua dan wali"),
                _reviewCard(3, "Dokumen", _getDocumentUploadStatus()),
              ],
            ),
          ),
        ),
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
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, 2),
              blurRadius: 4),
        ],
      ),
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
                  Icon(_getIconForPage(pageIndex),
                      color: statusColor, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(desc,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey)),
                        const SizedBox(height: 4),
                        Text(statusText,
                            style: TextStyle(
                                fontSize: 12,
                                color: statusColor,
                                fontWeight: FontWeight.w500)),
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
                            color: Colors.grey.withValues(alpha: 0.2)))),
                child: _buildDetailContent(pageIndex),
              ),
          ],
        ),
      ),
    );
  }
}
