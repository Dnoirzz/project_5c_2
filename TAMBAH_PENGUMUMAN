import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TambahPengumumanPage extends StatefulWidget {
  const TambahPengumumanPage({super.key});

  @override
  State<TambahPengumumanPage> createState() => _TambahPengumumanPageState();
}

class _TambahPengumumanPageState extends State<TambahPengumumanPage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  File? _selectedImage;

  final picker = ImagePicker();
  final String apiUrl = "http://44.220.144.82/api/tambah_pengumuman.php";

  // @override
  // void dispose() {
  //   _judulController.dispose();
  //   _deskripsiController.dispose();
  //   super.dispose();
  // }

  // Future<void> _pickImageFromGallery() async {
  //   try {
  //     final XFile? pickedFile = await _imagePicker.pickImage(
  //       source: ImageSource.gallery,
  //     );
  //     if (pickedFile != null) {
  //       setState(() {
  //         _selectedImage = File(pickedFile.path);
  //       });
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Error: $e")),
  //     );
  //   }
  // }
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _publishPengumuman() async {
    if (_judulController.text.isEmpty || _deskripsiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Judul dan Deskripsi wajib diisi!")),
      );
      return;
    }

    String? base64Image;
    if (_selectedImage != null) {
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          "judul": _judulController.text,
          "deskripsi": _deskripsiController.text,
          "upload_gambar": base64Image ?? "",
        },
      );

      final data = jsonDecode(response.body);
      if (data["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pengumuman berhasil ditambahkan!")),
        );
        Navigator.pop(context, true); // kembali dan trigger refresh
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal: ${data["message"]}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    }
  }

  // Future<void> _publishPengumuman() async {
  //   if (_judulController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //           content: Text("Judul tidak boleh kosong!"),
  //           backgroundColor: Colors.red),
  //     );
  //     return;
  //   }

  //   if (_deskripsiController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //           content: Text("Deskripsi tidak boleh kosong!"),
  //           backgroundColor: Colors.red),
  //     );
  //     return;
  //   }

  //   String? base64Image;
  //   if (_selectedImage != null) {
  //     List<int> imageBytes = await _selectedImage!.readAsBytes();
  //     base64Image = base64Encode(imageBytes);
  //   }

  //   final url = Uri.parse("http://44.220.144.82/api/tambah_pengumuman.php");

  //   try {
  //     final response = await http.post(
  //       url,
  //       body: {
  //         "judul": _judulController.text,
  //         "deskripsi": _deskripsiController.text,
  //         "upload_gambar":
  //             base64Image ?? "", // jika tidak ada gambar kirim kosong
  //       },
  //     );

  //     final data = jsonDecode(response.body);

  //     if (data["success"] == true) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //             content: Text("Pengumuman berhasil dipublikasikan!"),
  //             backgroundColor: Colors.green),
  //       );
  //       Navigator.pop(context);
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //             content: Text("Gagal: ${data["message"]}"),
  //             backgroundColor: Colors.red),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
  //     );
  //   }
  // }

  // void _publishPengumuman() {
  //   // Validasi input
  //   if (_judulController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Judul tidak boleh kosong!"),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }

  //   if (_deskripsiController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Deskripsi tidak boleh kosong!"),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }

  //   // Simulasi publish
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text("Pengumuman berhasil dipublikasikan!"),
  //       backgroundColor: Colors.green,
  //     ),
  //   );

  //   // Kembali ke halaman sebelumnya
  //   Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    // Warna yang digunakan dalam gambar (estimasi):
    const Color darkBlueBackground =
        Color(0xFF365368); // Background Scaffold & App Bar
    const Color formContainerColor =
        Color(0xFF1C3C53); // Warna yang terlihat di sekitar input fields
    // const Color inputFieldColor = Color(0xFF7F8C8D); // Warna di dalam Judul & Isi Pengumuman
    const Color fileUploadButtonColor =
        Color(0xFF34495E); // Warna tombol Choose File
    // const Color fileUploadPlaceholderColor = Color(0xFF7F8C8D); // Warna placeholder Upload File/Gambar
    const Color publishButtonColor = Colors.green; // Warna tombol Publish

    return Scaffold(
      backgroundColor: darkBlueBackground,
      appBar: AppBar(
        backgroundColor: darkBlueBackground,
        title: const Text(
          "Tambah Pengumuman",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xffE8E995), // Warna judul AppBar (putih)
          ),
        ),
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.yellowAccent),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        // Padding luar untuk jarak dari tepi layar (jika diperlukan)
        padding: const EdgeInsets.all(20),
        child: Container(
          // Container tunggal untuk menampung semua elemen form
          // Ini adalah 'card' atau area utama yang menonjol dari background
          decoration: BoxDecoration(
            color:
                formContainerColor, // Warna abu-abu kebiruan yang lebih terang
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(20), // Padding di dalam container form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label Judul
              const Text(
                "Judul",
                style: TextStyle(
                  color: Colors.white, // Warna teks label
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              // Input Judul
              TextField(
                controller: _judulController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Masukkan Judul Pengumuman",
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white12, // Warna input field
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

              // Label Isi Pengumuman
              const Text(
                "Isi Pengumuman",
                style: TextStyle(
                  color: Colors.white, // Warna teks label
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              // Input Deskripsi
              TextField(
                controller: _deskripsiController,
                maxLines: 6,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Masukkan Isi Pengumuman",
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white12, // Warna input field
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

              // Upload File/Gambar
              Row(
                children: [
                  const Text(
                    "Upload File/Gambar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 4),
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

              // Tombol Upload dan Text Field Simulasi
              Row(
                children: [
                  // Tombol Choose File
                  ElevatedButton(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: fileUploadButtonColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Choose File",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Text/Placeholder untuk nama file yang dipilih
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color:
                            Colors.white12, // Warna abu-abu yang lebih terang
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _selectedImage != null
                            ? _selectedImage!.path.split('/').last
                            : "Upload File/Gambar",
                        style: TextStyle(
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Preview Gambar (opsional, disembunyikan jika tidak ada)
              if (_selectedImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                    height: 180,
                    width: double.infinity,
                  ),
                )
              else
                const SizedBox
                    .shrink(), // Hapus placeholder jika tidak ada gambar

              if (_selectedImage != null) const SizedBox(height: 30),
              if (_selectedImage == null) const SizedBox(height: 20),

              // Tombol Publish
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
            ],
          ),
        ),
      ),
    );
  }
}
