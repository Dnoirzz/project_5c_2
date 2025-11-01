// import 'package:flutter/material.dart';

// class DokumenTab extends StatelessWidget {
//   const DokumenTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFF4F6C7A), width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             offset: const Offset(0, 2),
//             blurRadius: 4,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           const Row(
//             children: [
//               Icon(Icons.folder, color: Color(0xFF4F6C7A), size: 24),
//               SizedBox(width: 8),
//               Text(
//                 'Dokumen',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 4),
//           const Text(
//             'Dokumen yang telah diupload',
//             style: TextStyle(fontSize: 12, color: Colors.grey),
//           ),
//           const SizedBox(height: 20),

//           // Document List - sesuai dengan formulir pendaftaran
//           _buildDocumentItem('KTP', 'ktp_aldi_mahendra.jpg', 'verified'),
//           _buildDocumentItem('Ijazah', 'ijazah_sma_2024.pdf', 'verified'),
//           _buildDocumentItem('Akta', 'akta_kelahiran_aldi.pdf', 'uploaded'),
//           _buildDocumentItem('KK', 'kartu_keluarga_mahendra.pdf', 'uploaded'),
//           _buildDocumentItem('Pas Foto', 'pas_foto_aldi_3x4.jpg', 'uploaded'),
//         ],
//       ),
//     );
//   }

//   Widget _buildDocumentItem(String title, String filename, String status) {
//     // Determine colors and icon based on status
//     Color backgroundColor;
//     Color borderColor;
//     Color iconColor;
//     IconData iconData;
//     Color titleColor;
//     bool showFilename;
//     bool showViewButton;

//     switch (status) {
//       case 'verified':
//         backgroundColor = Colors.green.shade50;
//         borderColor = Colors.green.shade200;
//         iconColor = Colors.green;
//         iconData = Icons.check_circle;
//         titleColor = Colors.green.shade700;
//         showFilename = true;
//         showViewButton = true;
//         break;
//       case 'uploaded':
//         backgroundColor = Colors.orange.shade50;
//         borderColor = Colors.orange.shade200;
//         iconColor = Colors.orange;
//         iconData = Icons.pending;
//         titleColor = Colors.orange.shade700;
//         showFilename = true;
//         showViewButton = true;
//         break;
//       case 'not_uploaded':
//       default:
//         backgroundColor = Colors.grey.shade50;
//         borderColor = Colors.grey.shade300;
//         iconColor = Colors.grey.shade600;
//         iconData = Icons.pending;
//         titleColor = Colors.grey.shade700;
//         showFilename = false;
//         showViewButton = false;
//         break;
//     }

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: borderColor, width: 1),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(4),
//             decoration: BoxDecoration(
//               color: status == 'not_uploaded'
//                   ? Colors.grey.shade200
//                   : Colors.white,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(iconData, color: iconColor, size: 20),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: titleColor,
//                   ),
//                 ),
//                 if (showFilename)
//                   Text(
//                     filename,
//                     style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
//                   ),
//               ],
//             ),
//           ),
//           if (showViewButton)
//             IconButton(
//               onPressed: () {
//                 // TODO: Implement download/view functionality
//                 // Debug: View $filename
//               },
//               icon: const Icon(
//                 Icons.visibility,
//                 color: Color(0xFF4F6C7A),
//                 size: 20,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../models/dataDokumen_models.dart';

class DokumenTab extends StatelessWidget {
  final List<DataDokumen> dataDokumen;
  const DokumenTab({super.key, required this.dataDokumen});

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
              Icon(Icons.folder, color: Color(0xFF4F6C7A), size: 24),
              SizedBox(width: 8),
              Text(
                'Dokumen',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text('Dokumen yang telah diupload',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 20),
          if (dataDokumen.isEmpty)
            const Center(child: Text('Belum ada dokumen diupload'))
          else
            ...dataDokumen.map((doc) {
              final status = doc.statusVerifikasi.toLowerCase();
              final isVerified = status == 'verifikasi';

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isVerified ? Colors.green.shade50 : Colors.red.shade50,
                  border: Border.all(
                    color: isVerified
                        ? Colors.green.shade300
                        : Colors.red.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      isVerified ? Icons.check_circle : Icons.cancel,
                      color: isVerified ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doc.jenisDokumen,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isVerified
                                      ? Colors.green.shade800
                                      : Colors.red.shade800)),
                          Text(doc.namaFile,
                              style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: buka atau unduh file
                      },
                      icon: const Icon(Icons.visibility,
                          color: Color(0xFF4F6C7A)),
                    ),
                  ],
                ),
              );
            }).toList(),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:SPMB/models/dataDokumen_models.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart'; // Untuk file PDF (optional)
// import 'package:photo_view/photo_view.dart'; // Untuk zoom gambar

// class DokumenTab extends StatelessWidget {
//   final List<DataDokumen> dataDokumen;

//   const DokumenTab({super.key, required this.dataDokumen});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFF4F6C7A), width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             offset: const Offset(0, 2),
//             blurRadius: 4,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             children: [
//               Icon(Icons.folder, color: Color(0xFF4F6C7A), size: 24),
//               SizedBox(width: 8),
//               Text(
//                 'Dokumen Saya',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           ...dataDokumen
//               .map((doc) => _buildDocumentItem(context, doc))
//               .toList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildDocumentItem(BuildContext context, DataDokumen doc) {
//     Color backgroundColor;
//     Color borderColor;
//     Color iconColor;
//     IconData iconData;

//     switch (doc.statusVerifikasi.toLowerCase()) {
//       case 'terverifikasi':
//         backgroundColor = Colors.green.shade50;
//         borderColor = Colors.green.shade200;
//         iconColor = Colors.green;
//         iconData = Icons.check_circle;
//         break;
//       case 'menunggu verifikasi':
//         backgroundColor = Colors.yellow.shade50;
//         borderColor = Colors.yellow.shade700;
//         iconColor = Colors.orange;
//         iconData = Icons.hourglass_top;
//         break;
//       default: // belum diverifikasi
//         backgroundColor = Colors.red.shade50;
//         borderColor = Colors.red.shade200;
//         iconColor = Colors.red;
//         iconData = Icons.error;
//         break;
//     }

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: borderColor, width: 1),
//       ),
//       child: Row(
//         children: [
//           Icon(iconData, color: iconColor, size: 24),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(doc.jenisDokumen,
//                     style: const TextStyle(
//                         fontSize: 14, fontWeight: FontWeight.w500)),
//                 Text(doc.namaFile,
//                     style:
//                         const TextStyle(fontSize: 12, color: Colors.black54)),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.visibility, color: Color(0xFF4F6C7A)),
//             onPressed: () {
//               _showDocument(context, doc);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   void _showDocument(BuildContext context, DataDokumen doc) {
//     if (doc.formatFile.toLowerCase() == 'pdf') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => Scaffold(
//             appBar: AppBar(title: Text(doc.jenisDokumen)),
//             body: PDFView(filePath: doc.pathFile),
//           ),
//         ),
//       );
//     } else {
//       // Menampilkan gambar
//       showDialog(
//         context: context,
//         builder: (_) => Dialog(
//           child: Container(
//             constraints: const BoxConstraints(maxHeight: 600),
//             child: PhotoView(
//               imageProvider: NetworkImage(doc.pathFile),
//               backgroundDecoration: const BoxDecoration(color: Colors.white),
//             ),
//           ),
//         ),
//       );
//     }
//   }
// }
