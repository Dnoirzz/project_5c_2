// import 'dart:convert';
// import 'package:flutter/material.dart';
// import '../../models/dataDokumen_models.dart';

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
//             color: Colors.black.withOpacity(0.05),
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
//                 'Dokumen',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           const SizedBox(height: 4),
//           const Text(
//             'Dokumen yang telah diupload',
//             style: TextStyle(fontSize: 12, color: Colors.grey),
//           ),
//           const SizedBox(height: 20),
//           if (dataDokumen.isEmpty)
//             const Center(child: Text('Belum ada dokumen diupload'))
//           else
//             ...dataDokumen.map((doc) {
//               final status = doc.statusVerifikasi.toLowerCase();
//               final isVerified = status == 'verifikasi';

//               return Container(
//                 margin: const EdgeInsets.only(bottom: 10),
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: isVerified ? Colors.green.shade50 : Colors.red.shade50,
//                   border: Border.all(
//                     color: isVerified
//                         ? Colors.green.shade300
//                         : Colors.red.shade300,
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       isVerified ? Icons.check_circle : Icons.cancel,
//                       color: isVerified ? Colors.green : Colors.red,
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             doc.jenisDokumen,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: isVerified
//                                   ? Colors.green.shade800
//                                   : Colors.red.shade800,
//                             ),
//                           ),
//                           Text(
//                             doc.namaFile,
//                             style: TextStyle(color: Colors.grey[600]),
//                           ),
//                         ],
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.visibility,
//                           color: Color(0xFF4F6C7A)),
//                       onPressed: () {
//                         if (doc.uploadFile.isNotEmpty) {
//                           try {
//                             final bytes = base64Decode(doc.uploadFile);
//                             showDialog(
//                               context: context,
//                               builder: (_) => AlertDialog(
//                                 title: Text(doc.jenisDokumen),
//                                 content: Image.memory(
//                                   bytes,
//                                   fit: BoxFit.contain,
//                                   errorBuilder: (context, error, stackTrace) =>
//                                       const Text('Gagal memuat gambar'),
//                                 ),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () => Navigator.pop(context),
//                                     child: const Text('Tutup'),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           } catch (e) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text('Format file tidak valid')),
//                             );
//                           }
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content: Text('File tidak tersedia')),
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import '../../models/dataDokumen_models.dart';

class DokumenTab extends StatelessWidget {
  final List<DataDokumen> dataDokumen;
  const DokumenTab({super.key, required this.dataDokumen});

  // Helper function untuk menentukan warna berdasarkan status
  Color _getStatusColor(String status) {
    final statusLower = status.trim().toLowerCase();
    if (statusLower.contains('lulus') || statusLower == 'verifikasi') {
      return Colors.green;
    } else if (statusLower.contains('ditolak') ||
        statusLower.contains('tolak')) {
      return Colors.red;
    } else {
      return Colors.orange; // Menunggu verifikasi
    }
  }

  // Helper function untuk menentukan icon berdasarkan status
  IconData _getStatusIcon(String status) {
    final statusLower = status.trim().toLowerCase();
    if (statusLower.contains('lulus') || statusLower == 'verifikasi') {
      return Icons.check_circle;
    } else if (statusLower.contains('ditolak') ||
        statusLower.contains('tolak')) {
      return Icons.cancel;
    } else {
      return Icons.access_time; // Menunggu verifikasi
    }
  }

  // Helper function untuk format status text
  String _formatStatus(String status) {
    final statusLower = status.trim().toLowerCase();
    if (statusLower.contains('lulus') || statusLower == 'verifikasi') {
      return 'Lulus Verifikasi';
    } else if (statusLower.contains('ditolak') ||
        statusLower.contains('tolak')) {
      return 'Ditolak Verifikasi';
    } else {
      return 'Menunggu Verifikasi';
    }
  }

  void _showDocumentPreview(BuildContext context, DataDokumen doc) {
    if (doc.uploadFile.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('File tidak tersedia'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final bytes = base64Decode(doc.uploadFile);
      final statusColor = _getStatusColor(doc.statusVerifikasi);
      final statusText = _formatStatus(doc.statusVerifikasi);

      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header dengan info dokumen
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF263D4A),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.folder, color: Colors.white),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doc.jenisDokumen,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              doc.namaFile,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),

                // Status badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  color: statusColor.withOpacity(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(_getStatusIcon(doc.statusVerifikasi),
                          color: statusColor, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Status: $statusText',
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                // Gambar dokumen
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6,
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: InteractiveViewer(
                    panEnabled: true,
                    boundaryMargin: const EdgeInsets.all(20),
                    minScale: 0.5,
                    maxScale: 4,
                    child: Image.memory(
                      bytes,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.error_outline,
                                  size: 48, color: Colors.red),
                              const SizedBox(height: 16),
                              const Text(
                                'Gagal memuat gambar',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Format file mungkin tidak didukung',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Footer dengan tombol
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F6C7A),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Tutup'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
          const Text(
            'Dokumen yang telah diupload',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          // Jika tidak ada dokumen
          if (dataDokumen.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Icon(
                      Icons.folder_open,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Belum ada dokumen yang diupload',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            )
          // Jika ada dokumen
          else
            ...dataDokumen.map((doc) {
              final statusColor = _getStatusColor(doc.statusVerifikasi);
              final statusText = _formatStatus(doc.statusVerifikasi);
              final statusIcon = _getStatusIcon(doc.statusVerifikasi);

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.05),
                  border: Border.all(
                    color: statusColor.withOpacity(0.3),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => _showDocumentPreview(context, doc),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          // Icon status
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              statusIcon,
                              color: statusColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Info dokumen
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doc.jenisDokumen,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xFF263D4A),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  doc.namaFile,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    statusText,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Button lihat
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF4F6C7A).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.visibility,
                                color: Color(0xFF4F6C7A),
                              ),
                              onPressed: () =>
                                  _showDocumentPreview(context, doc),
                              tooltip: 'Lihat dokumen',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
        ],
      ),
    );
  }
}
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

// CODINGAN BENAR
// import 'dart:html' as html;
// import 'package:flutter/material.dart';
// import '../../models/dataDokumen_models.dart';

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
//             color: Colors.black.withOpacity(0.05),
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
//                 'Dokumen',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           const SizedBox(height: 4),
//           const Text('Dokumen yang telah diupload',
//               style: TextStyle(fontSize: 12, color: Colors.grey)),
//           const SizedBox(height: 20),
//           if (dataDokumen.isEmpty)
//             const Center(child: Text('Belum ada dokumen diupload'))
//           else
//             ...dataDokumen.map((doc) {
//               final status = doc.statusVerifikasi.toLowerCase();
//               final isVerified = status == 'verifikasi';

//               return Container(
//                   margin: const EdgeInsets.only(bottom: 10),
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color:
//                         isVerified ? Colors.green.shade50 : Colors.red.shade50,
//                     border: Border.all(
//                       color: isVerified
//                           ? Colors.green.shade300
//                           : Colors.red.shade300,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(children: [
//                     Icon(
//                       isVerified ? Icons.check_circle : Icons.cancel,
//                       color: isVerified ? Colors.green : Colors.red,
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(doc.jenisDokumen,
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: isVerified
//                                       ? Colors.green.shade800
//                                       : Colors.red.shade800)),
//                           Text(doc.namaFile,
//                               style: TextStyle(color: Colors.grey[600])),
//                         ],
//                       ),
//                     ),
//                     // IconButton(
//                     //   onPressed: () {
//                     //     // TODO: buka atau unduh file
//                     //   },
//                     //   icon: const Icon(Icons.visibility,
//                     //       color: Color(0xFF4F6C7A)),
//                     // ),
//                     // IconButton(
//                     //   icon: const Icon(Icons.visibility,
//                     //       color: Color(0xFF4F6C7A)),
//                     //   onPressed: () {
//                     //     showDialog(
//                     //       context: context,
//                     //       builder: (_) => AlertDialog(
//                     //         title: Text(doc.jenisDokumen),
//                     //         content: Column(
//                     //           mainAxisSize: MainAxisSize.min,
//                     //           crossAxisAlignment: CrossAxisAlignment.start,
//                     //           children: [
//                     //             Text("Nama File: ${doc.namaFile}"),
//                     //             Text("Status: ${doc.statusVerifikasi}"),
//                     //             Text("Tanggal Upload: ${doc.tanggalUpload}"),
//                     //           ],
//                     //         ),
//                     //         actions: [
//                     //           TextButton(
//                     //             onPressed: () => Navigator.pop(context),
//                     //             child: const Text("Tutup"),
//                     //           ),
//                     //         ],
//                     //       ),
//                     //     );
//                     //   },
//                     // ),
//                     // IconButton(
//                     //   icon: const Icon(Icons.visibility,
//                     //       color: Color(0xFF4F6C7A)),
//                     //   onPressed: () {
//                     //     final String baseUrl = "http://44.220.144.82/api/";
//                     //     final String filePath =
//                     //         doc.pathFile.replaceAll(r"\", "/");
//                     //     final String fullUrl = baseUrl + filePath;

//                     //     showDialog(
//                     //       context: context,
//                     //       builder: (_) => AlertDialog(
//                     //         title: Text(doc.jenisDokumen),
//                     //         content: Image.network(
//                     //           fullUrl,
//                     //           fit: BoxFit.contain,
//                     //           errorBuilder: (context, error, stackTrace) {
//                     //             return const Text("Gagal memuat gambar");
//                     //           },
//                     //         ),
//                     //         actions: [
//                     //           TextButton(
//                     //             onPressed: () => Navigator.pop(context),
//                     //             child: const Text("Tutup"),
//                     //           ),
//                     //         ],
//                     //       ),
//                     //     );
//                     //   },
//                     // ),
//                     IconButton(
//                       icon: const Icon(Icons.visibility,
//                           color: Color(0xFF4F6C7A)),
//                       onPressed: () {
//                         // final String filePath =
//                         //     doc.pathFile.replaceAll(r"\", "/");
//                         // final String fullUrl =
//                         //     "http://44.220.144.82/api/$filePath";

//                         showDialog(
//                           context: context,
//                           builder: (_) => AlertDialog(
//                             title: Text(doc.jenisDokumen),
//                             content: Image.network(
//                               fullUrl,
//                               fit: BoxFit.contain,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return const Text("Gagal memuat gambar");
//                               },
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 child: const Text("Tutup"),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ]));
//             }).toList(),
//         ],
//       ),
//     );
//   }
// }
