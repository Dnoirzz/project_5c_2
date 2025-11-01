// import 'dart:convert';
// import 'dart:io';
// import 'package:SPMB/services/pengumuman_services.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:SPMB/models/pengumuman_models.dart';
// // import 'package:SPMB/services/pengumuman_service.dart';

// class EditPengumumanPage extends StatefulWidget {
//   final Pengumuman pengumuman;

//   const EditPengumumanPage({
//     super.key,
//     required this.pengumuman,
//   });

//   @override
//   State<EditPengumumanPage> createState() => _EditPengumumanPageState();
// }

// class _EditPengumumanPageState extends State<EditPengumumanPage> {
//   final TextEditingController _judulController = TextEditingController();
//   final TextEditingController _isiController = TextEditingController();
//   final ImagePicker _picker = ImagePicker();

//   File? _selectedImage;
//   String? _existingImageUrl;

//   // Warna tema
//   static const Color darkBlueBackground = Color(0xFF335368);
//   static const Color formContainerColor = Color(0xFF2C3E50);
//   static const Color inputFieldColor = Colors.white12;
//   static const Color yellowAccent = Color(0xffE8E995);
//   static const Color publishButtonColor = Colors.green;

//   @override
//   void initState() {
//     super.initState();
//     _judulController.text = widget.pengumuman.judul;
//     _isiController.text = widget.pengumuman.isi;
//     _existingImageUrl = widget.pengumuman.gambar;
//   }

//   @override
//   void dispose() {
//     _judulController.dispose();
//     _isiController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage(ImageSource source) async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(source: source);
//       if (pickedFile != null) {
//         setState(() {
//           _selectedImage = File(pickedFile.path);
//           _existingImageUrl = null;
//         });
//       }
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Gagal memilih gambar: $e")),
//       );
//     }
//   }

//   void _showImageSourceDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: formContainerColor,
//         title: const Text("Pilih Sumber Gambar",
//             style: TextStyle(color: Colors.white)),
//         content: const Text("Pilih gambar dari galeri atau kamera",
//             style: TextStyle(color: Colors.white70)),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _pickImage(ImageSource.camera);
//             },
//             child: const Text("Kamera", style: TextStyle(color: yellowAccent)),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _pickImage(ImageSource.gallery);
//             },
//             child: const Text("Galeri", style: TextStyle(color: yellowAccent)),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _updatePengumuman() async {
//     if (_judulController.text.isEmpty || _isiController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text("Judul dan isi tidak boleh kosong"),
//         backgroundColor: Colors.red,
//       ));
//       return;
//     }

//     String base64Image = "";
//     if (_selectedImage != null) {
//       base64Image = base64Encode(_selectedImage!.readAsBytesSync());
//     } else {
//       base64Image = _existingImageUrl ?? "";
//     }

//     try {
//       final response = await http.post(
//         Uri.parse("${PengumumanService.baseUrl}/update_pengumuman_admin.php"),
//         body: {
//           "id_pengumuman": widget.pengumuman.id,
//           "judul": _judulController.text,
//           "deskripsi": _isiController.text,
//           "upload_gambar": base64Image,
//         },
//       );

//       final data = jsonDecode(response.body);
//       if (!mounted) return;

//       if (data["success"] == true) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(data["message"]),
//           backgroundColor: Colors.green,
//         ));
//         Navigator.pop(context, true); // kembali dan refresh data
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(data["message"]),
//           backgroundColor: Colors.red,
//         ));
//       }
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Terjadi kesalahan: $e"),
//         backgroundColor: Colors.red,
//       ));
//     }
//   }

//   String get _fileName {
//     if (_selectedImage != null) {
//       return _selectedImage!.path.split('/').last;
//     }
//     if (_existingImageUrl != null && _existingImageUrl!.isNotEmpty) {
//       return _existingImageUrl!.split('/').last;
//     }
//     return "Upload File/Gambar";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: darkBlueBackground,
//       appBar: AppBar(
//         backgroundColor: darkBlueBackground,
//         title: const Text(
//           "Edit Pengumuman",
//           style: TextStyle(
//               color: yellowAccent, fontWeight: FontWeight.bold, fontSize: 22),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: yellowAccent),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Container(
//           decoration: BoxDecoration(
//             color: formContainerColor,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Judul
//               const Text("Judul",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16)),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _judulController,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   hintText: "Masukkan judul pengumuman",
//                   hintStyle: const TextStyle(color: Colors.white70),
//                   filled: true,
//                   fillColor: inputFieldColor,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Isi
//               const Text("Isi Pengumuman",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16)),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _isiController,
//                 maxLines: 6,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   hintText: "Masukkan isi pengumuman",
//                   hintStyle: const TextStyle(color: Colors.white70),
//                   filled: true,
//                   fillColor: inputFieldColor,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Upload Gambar
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Text("Upload File/Gambar",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16)),
//                   Text("(jika ada)",
//                       style: TextStyle(color: Colors.white70, fontSize: 12)),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: _showImageSourceDialog,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: formContainerColor,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 12),
//                     ),
//                     child: const Text("Choose File",
//                         style: TextStyle(color: Colors.white)),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 12),
//                       decoration: BoxDecoration(
//                         color: inputFieldColor,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         _fileName,
//                         style: TextStyle(
//                           color: (_selectedImage != null ||
//                                   _existingImageUrl != null)
//                               ? Colors.white
//                               : Colors.white70,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Preview Gambar
//               if (_selectedImage != null)
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.file(_selectedImage!,
//                       fit: BoxFit.cover, height: 200, width: double.infinity),
//                 )
//               else if (_existingImageUrl != null &&
//                   _existingImageUrl!.isNotEmpty)
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.network(
//                     _existingImageUrl!,
//                     fit: BoxFit.cover,
//                     height: 200,
//                     width: double.infinity,
//                     errorBuilder: (_, __, ___) => Container(
//                       height: 200,
//                       color: inputFieldColor,
//                       child: const Center(
//                         child: Icon(Icons.broken_image,
//                             color: Colors.white70, size: 80),
//                       ),
//                     ),
//                   ),
//                 ),

//               const SizedBox(height: 30),

//               // Tombol Publish
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _updatePengumuman,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: publishButtonColor,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text("Update Pengumuman",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:SPMB/models/pengumuman_models.dart';
import 'package:SPMB/services/pengumuman_services.dart';

class EditPengumumanPage extends StatefulWidget {
  final Pengumuman pengumuman;

  const EditPengumumanPage({super.key, required this.pengumuman});

  @override
  State<EditPengumumanPage> createState() => _EditPengumumanPageState();
}

class _EditPengumumanPageState extends State<EditPengumumanPage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String? _existingImageUrl;

  static const Color darkBlueBackground = Color(0xFF335368);
  static const Color formContainerColor = Color(0xFF2C3E50);
  static const Color inputFieldColor = Colors.white12;
  static const Color yellowAccent = Color(0xffE8E995);
  static const Color publishButtonColor = Colors.green;

  @override
  void initState() {
    super.initState();
    _judulController.text = widget.pengumuman.judul;
    _isiController.text = widget.pengumuman.isi;
    _existingImageUrl = widget.pengumuman.gambar;
  }

  Future<void> _pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
        _existingImageUrl = null;
      });
    }
  }

  void _showImagePicker() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: formContainerColor,
        title: const Text("Pilih Sumber Gambar",
            style: TextStyle(color: Colors.white)),
        content: const Text("Ambil dari kamera atau galeri",
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
            child: const Text("Kamera", style: TextStyle(color: yellowAccent)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
            child: const Text("Galeri", style: TextStyle(color: yellowAccent)),
          ),
        ],
      ),
    );
  }

  Future<void> _updatePengumuman() async {
    if (_judulController.text.isEmpty || _isiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Judul dan isi tidak boleh kosong"),
            backgroundColor: Colors.red),
      );
      return;
    }

    String base64Image = "";
    if (_selectedImage != null) {
      base64Image = base64Encode(_selectedImage!.readAsBytesSync());
    }

    try {
      final success = await PengumumanService.updatePengumuman(
        id: widget.pengumuman.id,
        judul: _judulController.text,
        isi: _isiController.text,
        base64Image: base64Image,
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Pengumuman berhasil diperbarui"),
              backgroundColor: Colors.green),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Gagal memperbarui pengumuman"),
              backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Terjadi kesalahan: $e"),
            backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      appBar: AppBar(
        backgroundColor: darkBlueBackground,
        title: const Text("Edit Pengumuman",
            style: TextStyle(color: yellowAccent)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
              color: formContainerColor,
              borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Judul",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _judulController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Masukkan judul pengumuman",
                  hintStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: inputFieldColor,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Isi Pengumuman",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _isiController,
                maxLines: 6,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Masukkan isi pengumuman",
                  hintStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: inputFieldColor,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _showImagePicker,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: yellowAccent),
                    child: const Text("Pilih Gambar",
                        style: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _selectedImage != null
                          ? _selectedImage!.path.split('/').last
                          : (_existingImageUrl != null
                              ? _existingImageUrl!.split('/').last
                              : "Belum ada gambar"),
                      style: const TextStyle(color: Colors.white70),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (_selectedImage != null)
                Image.file(_selectedImage!,
                    height: 200, width: double.infinity, fit: BoxFit.cover)
              else if (_existingImageUrl != null &&
                  _existingImageUrl!.isNotEmpty)
                Image.network(_existingImageUrl!,
                    height: 200, width: double.infinity, fit: BoxFit.cover),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _updatePengumuman,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: publishButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text("Update Pengumuman",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
