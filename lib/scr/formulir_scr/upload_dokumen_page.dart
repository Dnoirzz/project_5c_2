// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class UploadDokumenPage extends StatefulWidget {
//   final Map<String, dynamic>? savedData;
//   final Function(Map<String, dynamic>)? onDataChanged;

//   const UploadDokumenPage({
//     super.key,
//     this.savedData,
//     this.onDataChanged,
//   });

//   @override
//   State<UploadDokumenPage> createState() => _UploadDokumenPageState();
// }

// class _UploadDokumenPageState extends State<UploadDokumenPage> {
//   final ImagePicker _picker = ImagePicker();

//   final Map<String, File?> _images = {
//     'Ijazah/SKL': null,
//     'Kartu Keluarga': null,
//     'Akta Kelahiran': null,
//     'Pas Foto 3x4': null,
//   };

//   final Map<String, DateTime?> _uploadDates = {
//     'Ijazah/SKL': null,
//     'Kartu Keluarga': null,
//     'Akta Kelahiran': null,
//     'Pas Foto 3x4': null,
//   };

//   @override
//   void initState() {
//     super.initState();
//     if (widget.savedData != null) {
//       _loadSavedData();
//     }
//   }

//   @override
//   void didUpdateWidget(UploadDokumenPage oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.savedData != oldWidget.savedData) {
//       _loadSavedData();
//     }
//   }

//   void _loadSavedData() {
//     if (widget.savedData == null) return;
//     final data = widget.savedData!;

//     setState(() {
//       if (data['ijazah']?.isNotEmpty == true) {
//         _images['Ijazah/SKL'] = File(data['ijazah']);
//         _uploadDates['Ijazah/SKL'] = DateTime.now();
//       }
//       if (data['kk']?.isNotEmpty == true) {
//         _images['Kartu Keluarga'] = File(data['kk']);
//         _uploadDates['Kartu Keluarga'] = DateTime.now();
//       }
//       if (data['akta']?.isNotEmpty == true) {
//         _images['Akta Kelahiran'] = File(data['akta']);
//         _uploadDates['Akta Kelahiran'] = DateTime.now();
//       }
//       if (data['foto']?.isNotEmpty == true) {
//         _images['Pas Foto 3x4'] = File(data['foto']);
//         _uploadDates['Pas Foto 3x4'] = DateTime.now();
//       }
//     });
//   }

//   Future<void> _pickImageFromCamera(String docType) async {
//     try {
//       final XFile? image = await _picker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 80,
//         maxWidth: 1024,
//         maxHeight: 1024,
//       );

//       if (image != null) {
//         setState(() {
//           _images[docType] = File(image.path);
//           _uploadDates[docType] = DateTime.now();
//         });

//         _notifyDataChanged();

//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Foto $docType berhasil diambil'),
//               backgroundColor: Colors.green,
//               duration: const Duration(seconds: 2),
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error mengambil foto: ${e.toString()}'),
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 3),
//           ),
//         );
//       }
//     }
//   }

//   void _notifyDataChanged() {
//     if (widget.onDataChanged != null) {
//       bool hasUpload = _images.values.any((file) => file != null);

//       widget.onDataChanged!({
//         'uploaded': hasUpload,
//         'ijazah': _images['Ijazah/SKL']?.path,
//         'kk': _images['Kartu Keluarga']?.path,
//         'akta': _images['Akta Kelahiran']?.path,
//         'foto': _images['Pas Foto 3x4']?.path,
//       });
//     }
//   }

//   String _formatDate(DateTime? date) {
//     if (date == null) return '';
//     final months = [
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'Mei',
//       'Jun',
//       'Jul',
//       'Ags',
//       'Sep',
//       'Okt',
//       'Nov',
//       'Des'
//     ];
//     return 'Upload ${date.day} ${months[date.month - 1]}, '
//         '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         color: Colors.white,
//         elevation: 2,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Row(
//                 children: [
//                   Icon(Icons.upload_file, color: Colors.blue, size: 20),
//                   SizedBox(width: 8),
//                   Text(
//                     "Upload Dokumen",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 4),
//               const Text(
//                 "Upload berkas pendaftaran",
//                 style: TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//               const SizedBox(height: 16),

//               // Upload cards
//               ..._images.keys.map((docType) => _buildDocumentCard(docType)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDocumentCard(String docType) {
//     final image = _images[docType];
//     final uploadDate = _uploadDates[docType];

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 64,
//             height: 64,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: Icon(
//               Icons.camera_alt_outlined,
//               color: Colors.grey.shade600,
//               size: 32,
//             ),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             docType,
//             style: const TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w600,
//               color: Colors.black87,
//             ),
//           ),
//           if (uploadDate != null) ...[
//             const SizedBox(height: 4),
//             Text(
//               _formatDate(uploadDate),
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey.shade600,
//               ),
//             ),
//           ],
//           const SizedBox(height: 16),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () => _pickImageFromCamera(docType),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor:
//                     image != null ? Colors.green.shade50 : Colors.white,
//                 foregroundColor: image != null
//                     ? Colors.green.shade700
//                     : const Color(0xFF4F6C7A),
//                 elevation: 0,
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   side: BorderSide(
//                     color: image != null
//                         ? Colors.green.shade300
//                         : Colors.grey.shade300,
//                   ),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     image != null ? Icons.check_circle : Icons.camera_alt,
//                     size: 18,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     image != null ? 'Foto sudah diambil' : 'Ambil foto',
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (image != null) ...[
//             const SizedBox(height: 12),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.file(
//                 image,
//                 height: 120,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

class UploadDokumenPage extends StatefulWidget {
  final Map<String, dynamic>? savedData;
  final Function(Map<String, dynamic>) onDataChanged;

  const UploadDokumenPage({
    super.key,
    this.savedData,
    required this.onDataChanged,
  });

  @override
  State<UploadDokumenPage> createState() => _UploadDokumenPageState();
}

class _UploadDokumenPageState extends State<UploadDokumenPage> {
  final ImagePicker _picker = ImagePicker();
  
  // Map untuk menyimpan file paths dan data
  Map<String, File?> _dokumenFiles = {
    'ijazah': null,
    'kk': null,
    'akta': null,
    'foto': null,
  };

  // Map untuk menyimpan base64 data
  Map<String, String?> _dokumenBase64 = {
    'ijazah': null,
    'kk': null,
    'akta': null,
    'foto': null,
  };

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  void _loadSavedData() {
    if (widget.savedData != null) {
      setState(() {
        // Load file paths jika ada
        if (widget.savedData?['ijazah_path'] != null) {
          _dokumenFiles['ijazah'] = File(widget.savedData!['ijazah_path']);
        }
        if (widget.savedData?['kk_path'] != null) {
          _dokumenFiles['kk'] = File(widget.savedData!['kk_path']);
        }
        if (widget.savedData?['akta_path'] != null) {
          _dokumenFiles['akta'] = File(widget.savedData!['akta_path']);
        }
        if (widget.savedData?['foto_path'] != null) {
          _dokumenFiles['foto'] = File(widget.savedData!['foto_path']);
        }

        // Load base64 data jika ada
        _dokumenBase64['ijazah'] = widget.savedData?['ijazah_base64'];
        _dokumenBase64['kk'] = widget.savedData?['kk_base64'];
        _dokumenBase64['akta'] = widget.savedData?['akta_base64'];
        _dokumenBase64['foto'] = widget.savedData?['foto_base64'];
      });
    }
  }

  Future<void> _pickImage(String dokumenType) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        File imageFile = File(image.path);
        
        // Convert to base64
        List<int> imageBytes = await imageFile.readAsBytes();
        String base64Image = base64Encode(imageBytes);

        setState(() {
          _dokumenFiles[dokumenType] = imageFile;
          _dokumenBase64[dokumenType] = base64Image;
        });

        _notifyDataChanged();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Dokumen ${_getDokumenLabel(dokumenType)} berhasil dipilih'),
            backgroundColor: const Color(0xFF009137),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('❌ Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memilih gambar: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _takePhoto(String dokumenType) async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (photo != null) {
        File photoFile = File(photo.path);
        
        // Convert to base64
        List<int> photoBytes = await photoFile.readAsBytes();
        String base64Photo = base64Encode(photoBytes);

        setState(() {
          _dokumenFiles[dokumenType] = photoFile;
          _dokumenBase64[dokumenType] = base64Photo;
        });

        _notifyDataChanged();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Foto ${_getDokumenLabel(dokumenType)} berhasil diambil'),
            backgroundColor: const Color(0xFF009137),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('❌ Error taking photo: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengambil foto: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showImageSourceDialog(String dokumenType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text('Pilih Sumber ${_getDokumenLabel(dokumenType)}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF009137)),
                title: const Text('Galeri'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(dokumenType);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF009137)),
                title: const Text('Kamera'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto(dokumenType);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteDocument(String dokumenType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text('Hapus Dokumen'),
          content: Text('Apakah Anda yakin ingin menghapus ${_getDokumenLabel(dokumenType)}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _dokumenFiles[dokumenType] = null;
                  _dokumenBase64[dokumenType] = null;
                });
                _notifyDataChanged();
                Navigator.pop(context);
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${_getDokumenLabel(dokumenType)} berhasil dihapus'),
                    backgroundColor: Colors.orange,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _showImagePreview(File imageFile, String title) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                InteractiveViewer(
                  child: Image.file(
                    imageFile,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 400,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Ketuk di mana saja untuk menutup",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _notifyDataChanged() {
    Map<String, dynamic> data = {};

    // Simpan file paths untuk local preview
    if (_dokumenFiles['ijazah'] != null) {
      data['ijazah_path'] = _dokumenFiles['ijazah']!.path;
      data['ijazah_base64'] = _dokumenBase64['ijazah'];
      data['ijazah_name'] = _dokumenFiles['ijazah']!.path.split('/').last;
    }
    if (_dokumenFiles['kk'] != null) {
      data['kk_path'] = _dokumenFiles['kk']!.path;
      data['kk_base64'] = _dokumenBase64['kk'];
      data['kk_name'] = _dokumenFiles['kk']!.path.split('/').last;
    }
    if (_dokumenFiles['akta'] != null) {
      data['akta_path'] = _dokumenFiles['akta']!.path;
      data['akta_base64'] = _dokumenBase64['akta'];
      data['akta_name'] = _dokumenFiles['akta']!.path.split('/').last;
    }
    if (_dokumenFiles['foto'] != null) {
      data['foto_path'] = _dokumenFiles['foto']!.path;
      data['foto_base64'] = _dokumenBase64['foto'];
      data['foto_name'] = _dokumenFiles['foto']!.path.split('/').last;
    }

    widget.onDataChanged(data);
  }

  String _getDokumenLabel(String dokumenType) {
    switch (dokumenType) {
      case 'ijazah':
        return 'Ijazah/SKL';
      case 'kk':
        return 'Kartu Keluarga';
      case 'akta':
        return 'Akta Kelahiran';
      case 'foto':
        return 'Pas Foto 3x4';
      default:
        return dokumenType;
    }
  }

  IconData _getDokumenIcon(String dokumenType) {
    switch (dokumenType) {
      case 'ijazah':
        return Icons.school;
      case 'kk':
        return Icons.people;
      case 'akta':
        return Icons.description;
      case 'foto':
        return Icons.photo_camera;
      default:
        return Icons.insert_drive_file;
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
                  Icon(Icons.upload_file, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    "Upload Dokumen",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                "Upload dokumen yang diperlukan (format: JPG, PNG)",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // Upload cards
              _buildUploadCard('ijazah'),
              const SizedBox(height: 12),
              _buildUploadCard('kk'),
              const SizedBox(height: 12),
              _buildUploadCard('akta'),
              const SizedBox(height: 12),
              _buildUploadCard('foto'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadCard(String dokumenType) {
    bool hasFile = _dokumenFiles[dokumenType] != null;
    String label = _getDokumenLabel(dokumenType);
    IconData icon = _getDokumenIcon(dokumenType);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: hasFile ? Colors.green.shade50 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasFile ? Colors.green.shade300 : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: hasFile ? const Color(0xFF009137) : Colors.grey,
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      hasFile ? 'Dokumen telah diupload' : 'Belum diupload',
                      style: TextStyle(
                        fontSize: 12,
                        color: hasFile ? const Color(0xFF009137) : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                hasFile ? Icons.check_circle : Icons.cloud_upload,
                color: hasFile ? const Color(0xFF009137) : Colors.grey,
                size: 28,
              ),
            ],
          ),
          
          if (hasFile) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                _dokumenFiles[dokumenType]!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showImagePreview(
                      _dokumenFiles[dokumenType]!,
                      label,
                    ),
                    icon: const Icon(Icons.visibility, size: 18),
                    label: const Text('Lihat'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showImageSourceDialog(dokumenType),
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Ganti'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _deleteDocument(dokumenType),
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                ),
              ],
            ),
          ] else ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showImageSourceDialog(dokumenType),
                icon: const Icon(Icons.add_photo_alternate),
                label: const Text('Upload Dokumen'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF009137),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}