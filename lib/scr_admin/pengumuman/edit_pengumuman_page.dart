import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditPengumumanPage extends StatefulWidget {
  final Map<String, dynamic>? pengumuman;

  const EditPengumumanPage({
    super.key,
    this.pengumuman,
  });

  @override
  State<EditPengumumanPage> createState() => _EditPengumumanPageState();
}

class _EditPengumumanPageState extends State<EditPengumumanPage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  File? _selectedImage;
  String? _existingImagePath;

  // Warna yang digunakan (estimasi dari gambar)
  static const Color darkBlueBackground = Color(0xFF335368);
  static const Color formContainerColor = Color(0xFF2C3E50);
  static const Color inputFieldColor = Colors.white12;
  static const Color yellowAccent = Color(0xffE8E995);
  static const Color publishButtonColor = Colors.green;

  @override
  void initState() {
    super.initState();
    if (widget.pengumuman != null) {
      _judulController.text =
          widget.pengumuman!["judul"] ?? "Pendaftaran Beasiswa"; // Mock data
      _deskripsiController.text = widget.pengumuman!["deskripsi"] ??
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis."; // Mock data
      _existingImagePath = widget.pengumuman!["gambar"] ??
          'assets/mock_pamflet.jpg'; // Mock data
    } else {
      _judulController.text = "Pendaftaran Beasiswa"; // Default mock
      _deskripsiController.text =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis."; // Default mock
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
          _existingImagePath =
              null; // Hapus existing path jika memilih gambar baru
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
    Navigator.pop(context, true); // Tutup dialog setelah memilih
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
          _existingImagePath =
              null; // Hapus existing path jika memilih gambar baru
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
    Navigator.pop(context, true); // Tutup dialog setelah mengambil foto
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: formContainerColor,
          title: const Text(
            "Pilih Sumber Gambar",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "Pilih gambar dari galeri atau ambil dari kamera",
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: _takePhoto,
              child:
                  const Text("Kamera", style: TextStyle(color: yellowAccent)),
            ),
            TextButton(
              onPressed: _pickImage,
              child:
                  const Text("Galeri", style: TextStyle(color: yellowAccent)),
            ),
          ],
        );
      },
    );
  }

  // Future<void> _publishPengumuman() async {
  //   // Validasi input
  //   if (_judulController.text.isEmpty || _deskripsiController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Judul dan Deskripsi tidak boleh kosong!"),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }

  //   // Ambil ID pengumuman
  //   final idPengumuman = widget.pengumuman?["id_pengumuman"]?.toString() ?? "";

  //   if (idPengumuman.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("ID pengumuman tidak ditemukan!"),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }

  //   // Ambil gambar baru (base64) atau tetap gunakan gambar lama
  //   String base64Image = "";
  //   if (_selectedImage != null) {
  //     base64Image = base64Encode(_selectedImage!.readAsBytesSync());
  //   } else if (widget.pengumuman?["gambar"] != null &&
  //       widget.pengumuman!["gambar"].toString().isNotEmpty) {
  //     base64Image = widget.pengumuman!["gambar"];
  //   }

  //   // Kirim request ke backend
  //   try {
  //     final response = await http.post(
  //       Uri.parse("http://44.220.144.82/api/update_pengumuman_admin.php"),
  //       body: {
  //         "id_pengumuman": idPengumuman,
  //         "judul": _judulController.text,
  //         "deskripsi": _deskripsiController.text,
  //         "upload_gambar": base64Image,
  //       },
  //     );

  //     final result = jsonDecode(response.body);
  //     if (result["success"] == true) {
  //       // Jika sukses, kirim data balik ke halaman detail
  //       final updatedPengumuman = {
  //         "id_pengumuman": idPengumuman,
  //         "judul": _judulController.text,
  //         "deskripsi": _deskripsiController.text,
  //         "gambar": base64Image,
  //         "tanggal": DateTime.now().toIso8601String(),
  //       };

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(result["message"]),
  //           backgroundColor: Colors.green,
  //         ),
  //       );

  //       Navigator.pop(context, updatedPengumuman);
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(result["message"]),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("Terjadi kesalahan: $e"),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  Future<void> _publishPengumuman() async {
    // Validasi input
    if (_judulController.text.isEmpty || _deskripsiController.text.isEmpty) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Judul dan Deskripsi tidak boleh kosong!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Ambil ID pengumuman
    final idPengumuman = widget.pengumuman?["id_pengumuman"]?.toString() ?? "";

    if (idPengumuman.isEmpty) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("ID pengumuman tidak ditemukan!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Ambil gambar baru (base64) atau tetap gunakan gambar lama
    String base64Image = "";
    if (_selectedImage != null) {
      base64Image = base64Encode(_selectedImage!.readAsBytesSync());
    } else if (widget.pengumuman?["gambar"] != null &&
        widget.pengumuman!["gambar"].toString().isNotEmpty) {
      base64Image = widget.pengumuman!["gambar"];
    }

    try {
      final response = await http.post(
        Uri.parse("http://44.220.144.82/api/update_pengumuman_admin.php"),
        body: {
          "id_pengumuman": idPengumuman,
          "judul": _judulController.text,
          "deskripsi": _deskripsiController.text,
          "upload_gambar": base64Image,
        },
      );

      if (!context.mounted) return; // pastikan context masih aktif

      final result = jsonDecode(response.body);
      if (result["success"] == true) {
        final updatedPengumuman = {
          "id_pengumuman": idPengumuman,
          "judul": _judulController.text,
          "deskripsi": _deskripsiController.text,
          "gambar": base64Image,
          "tanggal": DateTime.now().toIso8601String(),
        };

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result["message"]),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context, updatedPengumuman);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result["message"]),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Terjadi kesalahan: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // void _publishPengumuman() {
  //   // Validasi input
  //   if (_judulController.text.isEmpty || _deskripsiController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Judul dan Deskripsi tidak boleh kosong!"),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }

  //   // Ambil tanggal lama agar tidak berubah
  //   final tanggalLama = widget.pengumuman?["tanggal"];

  //   // Ambil gambar yang dipakai (tetap jika tidak diganti)
  //   String gambarFinal = "";
  //   if (_selectedImage != null) {
  //     gambarFinal = base64Encode(_selectedImage!.readAsBytesSync());
  //   } else if (widget.pengumuman?["gambar"] != null &&
  //       widget.pengumuman!["gambar"].toString().isNotEmpty) {
  //     gambarFinal = widget.pengumuman!["gambar"];
  //   }

  //   // Siapkan data hasil edit
  //   final updatedPengumuman = {
  //     "judul": _judulController.text,
  //     "deskripsi": _deskripsiController.text,
  //     // "gambar": _selectedImage != null
  //     //     ? base64Encode(
  //     //         _selectedImage!.readAsBytesSync()) // Simpan sebagai base64
  //     //     : widget.pengumuman?["gambar"] ?? "",
  //     "gambar": gambarFinal,
  //     "tanggal": tanggalLama,
  //     // "tanggal": DateTime.now(), // Update tanggal terakhir diedit
  //   };

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text("Pengumuman berhasil diperbarui!"),
  //       backgroundColor: Colors.green,
  //     ),
  //   );
  //   // Navigator.pop(context);
  //   // Kembalikan hasil edit ke halaman sebelumnya
  //   Navigator.pop(context, updatedPengumuman);
  // }

  // Helper untuk mendapatkan nama file
  String get _fileName {
    if (_selectedImage != null) {
      return _selectedImage!.path.split('/').last;
    }
    if (_existingImagePath != null) {
      return _existingImagePath!.split('/').last;
    }
    return "Upload File/Gambar";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      appBar: AppBar(
        backgroundColor: darkBlueBackground,
        title: const Text(
          "Edit Pengumuman",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: yellowAccent,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: yellowAccent),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          // Kontainer Form Utama
          decoration: BoxDecoration(
            color: formContainerColor,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul
              const Text(
                "Judul",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _judulController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Masukkan judul pengumuman",
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: inputFieldColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Isi Pengumuman
              const Text(
                "Isi Pengumuman",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _deskripsiController,
                maxLines: 6,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Masukkan isi pengumuman",
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: inputFieldColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Upload Gambar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Upload File/Gambar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "(jika Ada)",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  // Tombol Choose File
                  ElevatedButton(
                    onPressed: _showImageSourceDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          formContainerColor, // Warna sama seperti kontainer form
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Choose File",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Placeholder/Nama File
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: inputFieldColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _fileName,
                        style: TextStyle(
                          color: (_selectedImage != null ||
                                  _existingImagePath != null)
                              ? Colors.white
                              : Colors.white70,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Preview Gambar
              if (_selectedImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                )
              else if (_existingImagePath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    _existingImagePath!,
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: inputFieldColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Icon(Icons.broken_image,
                              color: Colors.white70, size: 80),
                        ),
                      );
                    },
                  ),
                )
              else
                const SizedBox
                    .shrink(), // Menghilangkan placeholder default jika kosong

              const SizedBox(height: 30),

              // Tombol Publish (Tombol Review dihapus)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _publishPengumuman,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: publishButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Publish",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
