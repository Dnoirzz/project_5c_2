// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../widgets/app_bar.dart';
// import 'data_pribadi_page.dart';
// import 'data_akademik_page.dart';
// import 'data_ortu_page.dart';
// import 'upload_dokumen_page.dart';
// import 'review_submit_page.dart';
// import '../dashboard_scr.dart';

// /// Main Formulir Pendaftaran dengan konten terpisah
// /// Hanya konten yang berubah, AppBar dan header tetap
// class FormulirPendaftaranMain extends StatefulWidget {
//   const FormulirPendaftaranMain({super.key});

//   @override
//   State<FormulirPendaftaranMain> createState() =>
//       _FormulirPendaftaranMainState();
// }

// class _FormulirPendaftaranMainState extends State<FormulirPendaftaranMain> {
//   int _currentPage = 0;
//   final ScrollController _scrollController = ScrollController();

//   // Track which pages have been saved
//   final Map<int, bool> _pagesSaved = {
//     0: false,
//     1: false,
//     2: false,
//     3: false, // Upload dokumen page
//     4: false, // Review page
//   };

//   // Store form data for each page
//   final Map<int, Map<String, dynamic>> _formData = {};
//   final Map<String, dynamic> _localDraft = {};
//   @override
//   void initState() {
//     super.initState();
//     // Initialize form data for each page
//     for (int i = 0; i < 5; i++) {
//       _formData[i] = {};
//     }
//     _loadDraftData();
//   }

//   // Check if all required fields are filled for the current page
//   bool _checkRequiredFields(Map<String, dynamic> data) {
//     switch (_currentPage) {
//       case 0: // Data Pribadi
//         return data['namaLengkap']?.isNotEmpty == true &&
//             data['nik']?.isNotEmpty == true &&
//             data['tempatLahir']?.isNotEmpty == true &&
//             data['tanggalLahir'] != null &&
//             data['jenisKelamin']?.isNotEmpty == true &&
//             data['alamat']?.isNotEmpty == true &&
//             data['province'] != null;

//       case 1: // Data Akademik
//         return data['asalSekolah']?.isNotEmpty == true &&
//             data['tahunLulus']?.isNotEmpty == true &&
//             data['jurusan']?.isNotEmpty == true &&
//             data['prodi']?.isNotEmpty == true;

//       case 2: // Data Orang Tua
//         return data['namaAyah']?.isNotEmpty == true &&
//             data['pekerjaanAyah']?.isNotEmpty == true &&
//             data['namaIbu']?.isNotEmpty == true &&
//             data['pekerjaanIbu']?.isNotEmpty == true;

//       case 3: // Upload Dokumen - tidak ada auto-save, harus manual save
//         return false;

//       default:
//         return false;
//     }
//   }

//   // Check if any field is filled for the current page (for draft saving)
//   bool _checkAnyFieldFilled(Map<String, dynamic> data) {
//     switch (_currentPage) {
//       case 0: // Data Pribadi
//         return data['namaLengkap']?.isNotEmpty == true ||
//             data['nik']?.isNotEmpty == true ||
//             data['tempatLahir']?.isNotEmpty == true ||
//             data['tanggalLahir'] != null ||
//             data['jenisKelamin']?.isNotEmpty == true ||
//             data['alamat']?.isNotEmpty == true ||
//             data['province'] != null;

//       case 1: // Data Akademik
//         return data['asalSekolah']?.isNotEmpty == true ||
//             data['tahunLulus']?.isNotEmpty == true ||
//             data['jurusan']?.isNotEmpty == true ||
//             data['prodi']?.isNotEmpty == true;

//       case 2: // Data Orang Tua
//         return data['namaAyah']?.isNotEmpty == true ||
//             data['pekerjaanAyah']?.isNotEmpty == true ||
//             data['namaIbu']?.isNotEmpty == true ||
//             data['pekerjaanIbu']?.isNotEmpty == true ||
//             data['noTlpAyah']?.isNotEmpty == true ||
//             data['alamatAyah']?.isNotEmpty == true ||
//             data['penghasilanAyah']?.isNotEmpty == true ||
//             data['noTlpIbu']?.isNotEmpty == true ||
//             data['alamatIbu']?.isNotEmpty == true ||
//             data['penghasilanIbu']?.isNotEmpty == true;

//       case 3: // Upload Dokumen
//         return data['uploaded'] == true ||
//             data['ijazah'] != null ||
//             data['akta'] != null ||
//             data['kk'] != null ||
//             data['foto'] != null;

//       default:
//         return false;
//     }
//   }

//   void _handlePageDataChanged(Map<String, dynamic> newData) {
//     if (mounted) {
//       // Use addPostFrameCallback to avoid setState during build
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) {
//           setState(() {
//             final existingData =
//                 Map<String, dynamic>.from(_formData[_currentPage] ?? {});
//             bool hasSignificantChanges = false;

//             // Deep comparison of old and new data
//             if (existingData.isEmpty && newData.isNotEmpty) {
//               hasSignificantChanges = true;
//             } else if (existingData.length != newData.length) {
//               hasSignificantChanges = true;
//             } else {
//               for (var key in newData.keys) {
//                 if (existingData[key] != newData[key]) {
//                   hasSignificantChanges = true;
//                   break;
//                 }
//               }
//             }

//             // Create a deep copy of the new data
//             Map<String, dynamic> dataCopy = {};
//             newData.forEach((key, value) {
//               dataCopy[key] = value;
//             });
//             _formData[_currentPage] = dataCopy;

//             // Check if all required fields are filled
//             bool allFieldsFilled = _checkRequiredFields(dataCopy);

//             // Auto-save if all required fields are filled
//             if (allFieldsFilled) {
//               _pagesSaved[_currentPage] = true;
//             } else {
//               // Only mark as unsaved if there are actual changes
//               if (hasSignificantChanges) {
//                 _pagesSaved[_currentPage] = false;
//               }
//             }

//             // Keep saved state if previously saved and no changes
//             if (_pagesSaved[_currentPage] == true && !hasSignificantChanges) {
//               _pagesSaved[_currentPage] = true;
//             }
//           });
//         }
//       });
//     }
//   }

//   void _saveDraft() async {
//     final prefs = await SharedPreferences.getInstance();

//     Map<String, dynamic> dataCopy = {};
//     _formData[_currentPage]?.forEach((key, value) {
//       dataCopy[key] = value;
//     });

//     // simpan ke local storage (pakai JSON agar tetap bisa simpan Map)
//     await prefs.setString('formulir_page_$_currentPage', jsonEncode(dataCopy));

//     setState(() {
//       _pagesSaved[_currentPage] = true;
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text("Draft tersimpan secara lokal."),
//         backgroundColor: Color(0xFF009137),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   // void _applyDraftToControllers() {
//   //   _formData[_currentPage]?.forEach((key, value) {
//   //     switch (key) {
//   //       case 'email':
//   //         _emailController.text = value ?? '';
//   //         break;
//   //       case 'namaLengkap':
//   //         _namaLengkapController.text = value ?? '';
//   //         break;
//   //       // tambahkan controller lain sesuai field kamu
//   //     }
//   //   });
//   // }

//   void _loadDraftData() async {
//     final prefs = await SharedPreferences.getInstance();

//     setState(() {
//       for (int i = 0; i < 5; i++) {
//         final savedData = prefs.getString('formulir_page_$i');
//         if (savedData != null) {
//           _formData[i] = Map<String, dynamic>.from(jsonDecode(savedData));
//           _pagesSaved[i] = true;
//         }
//       }
//     });
//   }

//     // terapkan draft ke textfield aktif
//     // setState(() {
//     //   _applyDraftToControllers();
//     // });
//   }
// // sudah benar
//   // void _saveDraft() {
//   //   // salin data dari form saat ini
//   //   Map<String, dynamic> dataCopy = {};
//   //   _formData[_currentPage]?.forEach((key, value) {
//   //     dataCopy[key] = value;
//   //   });

//   //   // simpan ke variabel lokal
//   //   _localDraft[_currentPage.toString()] = dataCopy;

//   //   setState(() {
//   //     _pagesSaved[_currentPage] = true;
//   //   });

//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     const SnackBar(
//   //       content: Text("Draft tersimpan secara lokal."),
//   //       backgroundColor: Color(0xFF009137),
//   //       duration: Duration(seconds: 2),
//   //     ),
//   //   );
//   // }

// // awal
//   // void _saveDraft() {
//   //   setState(() {
//   //     // For all pages including document upload
//   //     if (_formData[_currentPage]?.isNotEmpty == true) {
//   //       // Create a deep copy of the current data to ensure it's preserved
//   //       Map<String, dynamic> dataCopy = {};
//   //       _formData[_currentPage]!.forEach((key, value) {
//   //         dataCopy[key] = value;
//   //       });
//   //       _formData[_currentPage] = dataCopy;
//   //       _pagesSaved[_currentPage] = true;
//   //     }
//   //   });

//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     const SnackBar(
//   //       content: Text("Draft berhasil disimpan!"),
//   //       backgroundColor: Color(0xFF009137),
//   //     ),
//   //   );
//   // }

//   final List<String> _stepTitles = [
//     'Data Pribadi',
//     'Data Akademik',
//     'Data Orang Tua',
//     'Upload Dokumen',
//     'Review & Submit',
//   ];

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _nextPage() {
//     // Allow moving forward if:
//     // 1. Current page is saved, or
//     // 2. Current page has data and was previously saved
//     if (_currentPage < 4) {
//       bool canProceed = _pagesSaved[_currentPage] == true ||
//           (_formData[_currentPage]?.isNotEmpty == true &&
//               _formData[_currentPage] == _formData[_currentPage]);

//       if (canProceed) {
//         setState(() {
//           _currentPage++;

//           // When moving to a new page, if it has saved data, mark it as saved
//           if (_formData[_currentPage]?.isNotEmpty == true) {
//             _pagesSaved[_currentPage] = true;
//           }

//           _applyDraftToControllers();
//         });

//         // Scroll ke atas setelah berpindah halaman
//         _scrollToTop();
//       }
//     }
//   }

//   void _previousPage() {
//     if (_currentPage > 0) {
//       setState(() {
//         // Store the current page's state before moving
//         if (_formData[_currentPage]?.isNotEmpty == true) {
//           Map<String, dynamic> currentPageData = {};
//           _formData[_currentPage]!.forEach((key, value) {
//             currentPageData[key] = value;
//           });
//           // Save the current page's data and state
//           _formData[_currentPage] = currentPageData;
//           // Only preserve saved state if it was explicitly saved
//           if (_pagesSaved[_currentPage] == true) {
//             _pagesSaved[_currentPage] = true;
//           }
//         }

//         // Move to previous page
//         _currentPage--;

//         // Restore previous page's state
//         if (_formData[_currentPage]?.isNotEmpty == true) {
//           Map<String, dynamic> prevPageData = {};
//           _formData[_currentPage]!.forEach((key, value) {
//             prevPageData[key] = value;
//           });
//           _formData[_currentPage] = prevPageData;
//           // If this page was previously saved, restore that state
//           if (_pagesSaved[_currentPage] == true) {
//             _pagesSaved[_currentPage] = true;
//           }
//         }
//       });

//       // Scroll ke atas setelah berpindah halaman
//       _scrollToTop();
//     }
//   }

//   void _scrollToTop() {
//     // Delay kecil untuk memastikan widget sudah di-render
//     Future.delayed(const Duration(milliseconds: 100), () {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           0.0,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F6F6),
//       appBar: CustomAppBar(
//         title: 'Formulir Pendaftaran',
//         showMenuButton: true,
//         showProfileMenu: true,
//         currentPage: 'formulir',
//       ),
//       drawer: const AppDrawer(currentPage: 'formulir'),
//       body: SingleChildScrollView(
//         controller: _scrollController,
//         child: Column(
//           children: [
//             // ========== HEADER BOX (TIDAK BERUBAH) ==========
//             Container(
//               color: const Color(0xFF2C3E50),
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF4F6C7A),
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withValues(alpha: 0.25),
//                       offset: const Offset(0, 4),
//                       blurRadius: 8,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Expanded(
//                           child: Text(
//                             "Formulir Pendaftaran Mahasiswa Baru",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 4,
//                             horizontal: 12,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.white30,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             "${_currentPage + 1} dari 5",
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       _stepTitles[_currentPage],
//                       style: const TextStyle(
//                         color: Colors.white70,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // ========== TAB NAVIGATION (TIDAK BERUBAH) ==========
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Container(
//                 margin: const EdgeInsets.only(top: 12),
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withValues(alpha: 0.08),
//                       offset: const Offset(0, 2),
//                       blurRadius: 4,
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _tabItem(Icons.person, "Data Pribadi", _currentPage == 0),
//                     _tabItem(Icons.school, "Data Akademik", _currentPage == 1),
//                     _tabItem(Icons.group, "Data Orang Tua", _currentPage == 2),
//                     _tabItem(
//                       Icons.upload_file,
//                       "Upload Dokumen",
//                       _currentPage == 3,
//                     ),
//                     _tabItem(
//                       Icons.check_circle,
//                       "Review & Submit",
//                       _currentPage == 4,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),

//             // ========== KONTEN (YANG BERUBAH) ==========
//             // Ganti PageView dengan Column yang dapat di-scroll
//             _buildCurrentPageContent(),

//             // ========== BOTTOM NAVIGATION BAR (SEKARANG BISA DI-SCROLL) ==========
//             Container(
//               margin: const EdgeInsets.all(12),
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.1),
//                     offset: const Offset(0, 4),
//                     blurRadius: 12,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Row(
//                     mainAxisAlignment: _currentPage == 4
//                         ? MainAxisAlignment
//                             .start // Only show back button on review page
//                         : MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Tombol Sebelumnya
//                       Container(
//                         width: 140,
//                         child: ElevatedButton(
//                           onPressed: _currentPage > 0 ? _previousPage : null,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.white,
//                             foregroundColor: Colors.black,
//                             elevation: 0,
//                             side: BorderSide(color: Colors.grey.shade300),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: const Text("< Sebelumnya"),
//                         ),
//                       ),

// //                       // Tombol Simpan Draft (hanya tampil jika bukan di halaman review)
//                       if (_currentPage != 4)
//                         Container(
//                           child: ElevatedButton.icon(
//                             onPressed: _checkRequiredFields(
//                                     _formData[_currentPage] ?? {})
//                                 ? _saveDraft
//                                 : null, // aktif hanya jika field lengkap
//                             icon: const Icon(Icons.save_outlined,
//                                 color: Colors.white),
//                             label: const Text(
//                               "Simpan Draft",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: _checkRequiredFields(
//                                       _formData[_currentPage] ?? {})
//                                   ? const Color(0xFF233746)
//                                   : Colors.grey.shade400,
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                           ),
//                         ),
//                       //     if (_currentPage != 4)
//                       //       Container(
//                       //         child: ElevatedButton.icon(
//                       //           onPressed: _checkAnyFieldFilled(
//                       //                       _formData[_currentPage] ?? {}) ||
//                       //                   _pagesSaved[_currentPage] == true
//                       //               ? _saveDraft
//                       //               : null,
//                       //           icon: Icon(
//                       //             Icons.save_outlined,
//                       //             color: (_checkAnyFieldFilled(
//                       //                         _formData[_currentPage] ?? {}) ||
//                       //                     _pagesSaved[_currentPage] == true)
//                       //                 ? (_pagesSaved[_currentPage] == true
//                       //                     ? Colors.white
//                       //                     : const Color(0xFF233746))
//                       //                 : Colors.grey.shade400,
//                       //           ),
//                       //           label: Text(
//                       //             "Simpan Draft",
//                       //             style: TextStyle(
//                       //               color: (_checkAnyFieldFilled(
//                       //                           _formData[_currentPage] ?? {}) ||
//                       //                       _pagesSaved[_currentPage] == true)
//                       //                   ? (_pagesSaved[_currentPage] == true
//                       //                       ? Colors.white
//                       //                       : const Color(0xFF233746))
//                       //                   : Colors.grey.shade400,
//                       //             ),
//                       //           ),
//                       //           style: ElevatedButton.styleFrom(
//                       //             backgroundColor: _pagesSaved[_currentPage] == true
//                       //                 ? const Color(0xFF009137)
//                       //                 : (_checkAnyFieldFilled(
//                       //                         _formData[_currentPage] ?? {})
//                       //                     ? Colors.white
//                       //                     : Colors.grey.shade100),
//                       //             elevation: 0,
//                       //             side: BorderSide(
//                       //               color: _pagesSaved[_currentPage] == true
//                       //                   ? const Color(0xFF009137)
//                       //                   : (_checkAnyFieldFilled(
//                       //                           _formData[_currentPage] ?? {})
//                       //                       ? const Color(0xFF233746)
//                       //                       : Colors.grey.shade300),
//                       //             ),
//                       //             shape: RoundedRectangleBorder(
//                       //               borderRadius: BorderRadius.circular(8),
//                       //             ),
//                       //           ),
//                       //         ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Container(
//                       width: 140,
//                       child: ElevatedButton(
//                         onPressed: _currentPage < 4
//                             ? (_checkRequiredFields(
//                                     _formData[_currentPage] ?? {})
//                                 ? _nextPage
//                                 : null)
//                             : () {
//                                 // Show confirmation dialog before submitting
//                                 showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return AlertDialog(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       title: Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Icon(Icons.check_circle,
//                                               color: Color(0xFF009137)),
//                                           SizedBox(width: 8),
//                                           Flexible(
//                                             child: Text(
//                                               'Konfirmasi Pendaftaran',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       content: Text(
//                                         'Apakah Anda yakin ingin mengirim formulir pendaftaran? Pastikan semua data sudah benar dan lengkap.',
//                                         style: TextStyle(fontSize: 14),
//                                       ),
//                                       actions: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             TextButton(
//                                               onPressed: () =>
//                                                   Navigator.of(context).pop(),
//                                               child: const Text('Batal'),
//                                             ),
//                                             SizedBox(width: 8),
//                                             ElevatedButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                                 ScaffoldMessenger.of(context)
//                                                     .showSnackBar(
//                                                   const SnackBar(
//                                                     content: Row(
//                                                       mainAxisSize:
//                                                           MainAxisSize.min,
//                                                       children: [
//                                                         Icon(Icons.check_circle,
//                                                             color:
//                                                                 Colors.white),
//                                                         SizedBox(width: 8),
//                                                         Text(
//                                                             "Formulir berhasil dikirim!"),
//                                                       ],
//                                                     ),
//                                                     backgroundColor:
//                                                         Color(0xFF009137),
//                                                     duration:
//                                                         Duration(seconds: 3),
//                                                   ),
//                                                 );
//                                                 // Add navigation to dashboard after success message
//                                                 Navigator.of(context)
//                                                     .pushAndRemoveUntil(
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         const DashboardPage(),
//                                                   ),
//                                                   (route) => false,
//                                                 );
//                                               },
//                                               style: ElevatedButton.styleFrom(
//                                                 backgroundColor:
//                                                     const Color(0xFF009137),
//                                                 foregroundColor: Colors.white,
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                 ),
//                                               ),
//                                               child: const Text('Kirim'),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 );
//                               },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: _currentPage < 4
//                               ? (_checkRequiredFields(
//                                           _formData[_currentPage] ?? {}) ||
//                                       _pagesSaved[_currentPage] == true
//                                   ? const Color(0xFF233746)
//                                   : Colors.grey.shade300)
//                               : const Color(0xFF009137),
//                           foregroundColor: Colors.white,
//                           elevation: _currentPage < 4
//                               ? (_checkRequiredFields(
//                                           _formData[_currentPage] ?? {}) ||
//                                       _pagesSaved[_currentPage] == true
//                                   ? 2
//                                   : 0)
//                               : 3,
//                           shadowColor: _currentPage < 4
//                               ? (_checkRequiredFields(
//                                           _formData[_currentPage] ?? {}) ||
//                                       _pagesSaved[_currentPage] == true
//                                   ? const Color(0xFF233746)
//                                       .withValues(alpha: 0.3)
//                                   : Colors.transparent)
//                               : const Color(0xFF009137).withValues(alpha: 0.3),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 12, horizontal: 16),
//                         ),
//                         child: Text(_currentPage < 4
//                             ? "Selanjutnya >"
//                             : "Daftar Sekarang"),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20), // Extra space at bottom
//           ],
//         ),
//       ),
//     );
//   }

//   // Method untuk navigasi langsung ke halaman tertentu
//   void _navigateToPage(int pageIndex) {
//     if (pageIndex != _currentPage) {
//       // Use addPostFrameCallback to avoid setState during build
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) {
//           setState(() {
//             _currentPage = pageIndex;
//           });
//           _scrollToTop();
//         }
//       });
//     }
//   }

//   // Method untuk menampilkan konten berdasarkan halaman saat ini
//   Widget _buildCurrentPageContent() {
//     switch (_currentPage) {
//       case 0:
//         return DataPribadiPage(
//           savedData: _formData[0],
//           onDataChanged: _handlePageDataChanged,
//         );
//       case 1:
//         return DataAkademikPage(
//           savedData: _formData[1],
//           onDataChanged: _handlePageDataChanged,
//         );
//       case 2:
//         return DataOrtuPage(
//           savedData: _formData[2],
//           onDataChanged: _handlePageDataChanged,
//         );
//       case 3:
//         return UploadDokumenPage(
//           savedData: _formData[3],
//           onDataChanged: _handlePageDataChanged,
//         );
//       case 4:
//         return ReviewSubmitPage(
//           formData: _formData,
//           pagesSaved: _pagesSaved,
//           onPageEdit: _navigateToPage,
//         );
//       default:
//         return DataPribadiPage(
//           savedData: _formData[0],
//           onDataChanged: _handlePageDataChanged,
//         );
//     }
//   }

//   // Tab Navigation Item (simple progress indicator)
//   Widget _tabItem(IconData icon, String title, bool active) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: active ? const Color(0xFF4F6C7A) : Colors.grey.shade400,
//               width: 2,
//             ),
//             color: active ? const Color(0xFFE8F0F3) : Colors.white,
//           ),
//           child: Icon(
//             icon,
//             color: active ? const Color(0xFF4F6C7A) : Colors.grey[600],
//             size: 20,
//           ),
//         ),
//         const SizedBox(height: 6),
//         SizedBox(
//           width: 60,
//           child: Text(
//             title,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w500,
//               color: active ? const Color(0xFF4F6C7A) : Colors.grey,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:convert';

import 'package:SPMB/services/pendaftaranService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/app_bar.dart';
import 'data_pribadi_page.dart';
import 'data_akademik_page.dart';
import 'data_ortu_page.dart';
import 'upload_dokumen_page.dart';
import 'review_submit_page.dart';
import '../dashboard_scr.dart';

/// Main Formulir Pendaftaran dengan konten terpisah
/// Hanya konten yang berubah, AppBar dan header tetap
class FormulirPendaftaranMain extends StatefulWidget {
  const FormulirPendaftaranMain({super.key});

  @override
  State<FormulirPendaftaranMain> createState() =>
      _FormulirPendaftaranMainState();
}

class _FormulirPendaftaranMainState extends State<FormulirPendaftaranMain> {
  int _currentPage = 0;
  final ScrollController _scrollController = ScrollController();

  // Track which pages have been saved
  final Map<int, bool> _pagesSaved = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
  };

  // Store form data for each page
  final Map<int, Map<String, dynamic>> _formData = {};

  bool _isLoading = true;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // Initialize SharedPreferences dan load data
  Future<void> _initializeData() async {
    print('🚀 Initializing FormulirPendaftaran...');

    // Initialize form data untuk setiap halaman
    for (int i = 0; i < 5; i++) {
      _formData[i] = {};
    }

    // Initialize SharedPreferences
    _prefs = await SharedPreferences.getInstance();
    print('✅ SharedPreferences initialized');

    // Load draft data
    await _loadDraftData();

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Check if all required fields are filled for the current page
  bool _checkRequiredFields(Map<String, dynamic> data) {
    switch (_currentPage) {
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
        return false;

      default:
        return false;
    }
  }

  void _handlePageDataChanged(Map<String, dynamic> newData) {
    if (!mounted) return;

    final existingData = _formData[_currentPage] ?? {};

    // Hanya update jika ada perubahan signifikan
    bool hasChanges = false;
    if (existingData.isEmpty && newData.isNotEmpty) {
      hasChanges = true;
    } else if (existingData.length != newData.length) {
      hasChanges = true;
    } else {
      for (var key in newData.keys) {
        if (existingData[key] != newData[key]) {
          hasChanges = true;
          break;
        }
      }
    }

    if (!hasChanges) return;

    // Update data
    _formData[_currentPage] = Map<String, dynamic>.from(newData);

    // Check if all required fields are filled
    bool allFieldsFilled = _checkRequiredFields(newData);

    // Update saved state
    if (allFieldsFilled && _pagesSaved[_currentPage] != true) {
      setState(() {
        _pagesSaved[_currentPage] = true;
      });
    } else if (!allFieldsFilled && _pagesSaved[_currentPage] == true) {
      setState(() {
        _pagesSaved[_currentPage] = false;
      });
    }
    setState(() {});
  }

  Future<void> _saveDraft() async {
    try {
      if (_prefs == null) {
        _prefs = await SharedPreferences.getInstance();
      }

      Map<String, dynamic> dataCopy = {};
      _formData[_currentPage]?.forEach((key, value) {
        // Konversi DateTime ke string ISO 8601
        if (value is DateTime) {
          dataCopy[key] = value.toIso8601String();
        } else {
          dataCopy[key] = value;
        }
      });

      // Simpan ke SharedPreferences
      String jsonString = jsonEncode(dataCopy);
      final keyData = 'draft_formulir_page_$_currentPage';
      final keySaved = 'draft_formulir_saved_$_currentPage';

      await _prefs!.setString(keyData, jsonString);
      await _prefs!.setBool(keySaved, true);

      print('💾 Saved draft for page $_currentPage');
      print('📝 Key: $keyData');
      print('📝 JSON: $jsonString');

      // Verifikasi
      final verify = _prefs!.getString(keyData);
      print('🔍 Verification: $verify');

      setState(() {
        _pagesSaved[_currentPage] = true;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Draft tersimpan secara lokal."),
            backgroundColor: Color(0xFF009137),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('❌ Error saving draft: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal menyimpan draft: $e"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _loadDraftData() async {
    try {
      print('🔄 Loading draft data...');

      if (_prefs == null) {
        print('❌ SharedPreferences not initialized');
        return;
      }

      // Tampilkan semua keys
      final allKeys = _prefs!.getKeys();
      print('🔑 All keys: $allKeys');

      for (int i = 0; i < 5; i++) {
        final keyData = 'draft_formulir_page_$i';
        final keySaved = 'draft_formulir_saved_$i';

        final savedData = _prefs!.getString(keyData);
        final isSaved = _prefs!.getBool(keySaved) ?? false;

        print('📄 Page $i:');
        print('   - Key: $keyData');
        print('   - Data: $savedData');
        print('   - Saved: $isSaved');

        if (savedData != null && savedData.isNotEmpty) {
          try {
            Map<String, dynamic> decodedData =
                Map<String, dynamic>.from(jsonDecode(savedData));

            // Konversi string ISO 8601 kembali ke DateTime
            Map<String, dynamic> processedData = {};
            decodedData.forEach((key, value) {
              if (value is String && (key.toLowerCase().contains('tanggal'))) {
                try {
                  processedData[key] = DateTime.parse(value);
                  print('   ✅ Converted $key to DateTime');
                } catch (e) {
                  processedData[key] = value;
                  print('   ⚠️ Could not convert $key to DateTime');
                }
              } else {
                processedData[key] = value;
              }
            });

            _formData[i] = processedData;
            _pagesSaved[i] = isSaved;
            print('   ✅ Loaded ${processedData.length} fields');
          } catch (e) {
            print('   ❌ Error decoding: $e');
            _formData[i] = {};
            _pagesSaved[i] = false;
          }
        } else {
          _formData[i] = {};
          _pagesSaved[i] = false;
          print('   ℹ️ No data');
        }
      }

      final totalWithData =
          _formData.entries.where((e) => e.value.isNotEmpty).length;
      print('📊 Total pages with data: $totalWithData');
    } catch (e) {
      print('❌ Error loading draft: $e');
    }
  }

  final List<String> _stepTitles = [
    'Data Pribadi',
    'Data Akademik',
    'Data Orang Tua',
    'Upload Dokumen',
    'Review & Submit',
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // void _nextPage() {
  //   if (_currentPage < 4) {
  //     bool canProceed = _pagesSaved[_currentPage] == true ||
  //         (_formData[_currentPage]?.isNotEmpty == true &&
  //             _formData[_currentPage] == _formData[_currentPage]);

  //     if (canProceed) {
  //       setState(() {
  //         _currentPage++;

  //         if (_formData[_currentPage]?.isNotEmpty == true) {
  //           _pagesSaved[_currentPage] = true;
  //         }
  //       });

  //       _scrollToTop();
  //     }
  //   }
  // }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        if (_formData[_currentPage]?.isNotEmpty == true) {
          Map<String, dynamic> currentPageData = {};
          _formData[_currentPage]!.forEach((key, value) {
            currentPageData[key] = value;
          });
          _formData[_currentPage] = currentPageData;
          if (_pagesSaved[_currentPage] == true) {
            _pagesSaved[_currentPage] = true;
          }
        }

        _currentPage--;

        if (_formData[_currentPage]?.isNotEmpty == true) {
          Map<String, dynamic> prevPageData = {};
          _formData[_currentPage]!.forEach((key, value) {
            prevPageData[key] = value;
          });
          _formData[_currentPage] = prevPageData;
          if (_pagesSaved[_currentPage] == true) {
            _pagesSaved[_currentPage] = true;
          }
        }
      });

      _scrollToTop();
    }
  }

  void _nextPage() {
    if (_currentPage < 4) {
      // Validasi data sebelum pindah
      bool canProceed = _checkRequiredFields(_formData[_currentPage] ?? {});

      if (!canProceed) {
        // Tampilkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Mohon lengkapi semua field yang wajib diisi'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      // Debug: Print data saat pindah halaman
      print('📄 Data Page $_currentPage sebelum pindah:');
      print('   ${jsonEncode(_formData[_currentPage])}');

      setState(() {
        _currentPage++;
      });

      // Debug: Print semua data
      print('📊 Semua Data Form:');
      _formData.forEach((page, data) {
        print('   Page $page: ${jsonEncode(data)}');
      });

      _scrollToTop();
    }
  }

  void _scrollToTop() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }
  // Tambahkan method ini setelah method _scrollToTop()

  // Future<void> _submitPendaftaran() async {
  //   // Validasi data sebelum submit
  //   bool isDataComplete = true;
  //   String missingData = '';

  //   // Check data pribadi
  //   final dataPribadi = _formData[0];
  //   if (dataPribadi == null || dataPribadi.isEmpty) {
  //     isDataComplete = false;
  //     missingData = 'Data Pribadi';
  //   }

  //   // Check data akademik
  //   final dataAkademik = _formData[1];
  //   if (dataAkademik == null ||
  //       dataAkademik['jurusan'] == null ||
  //       dataAkademik['prodi'] == null) {
  //     isDataComplete = false;
  //     if (missingData.isNotEmpty) missingData += ', ';
  //     missingData += 'Data Akademik (Jurusan/Prodi)';
  //   }

  //   // Check data orangtua
  //   final dataOrangtua = _formData[2];
  //   if (dataOrangtua == null || dataOrangtua.isEmpty) {
  //     isDataComplete = false;
  //     if (missingData.isNotEmpty) missingData += ', ';
  //     missingData += 'Data Orang Tua';
  //   }

  //   if (!isDataComplete) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           title: Row(
  //             children: [
  //               Icon(Icons.warning, color: Colors.orange),
  //               SizedBox(width: 8),
  //               Text('Data Belum Lengkap', style: TextStyle(fontSize: 16)),
  //             ],
  //           ),
  //           content: Text(
  //             'Mohon lengkapi data berikut terlebih dahulu:\n$missingData',
  //             style: TextStyle(fontSize: 14),
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.of(context).pop(),
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //     return;
  //   }

  //   // Show loading dialog
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return WillPopScope(
  //         onWillPop: () async => false,
  //         child: Center(
  //           child: Container(
  //             padding: EdgeInsets.all(20),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(12),
  //             ),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 CircularProgressIndicator(
  //                   color: Color(0xFF009137),
  //                 ),
  //                 SizedBox(height: 16),
  //                 Text(
  //                   'Mengirim data pendaftaran...',
  //                   style: TextStyle(fontSize: 14),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );

  //   try {
  //     // Submit pendaftaran
  //     final result = await PendaftaranService.submitPendaftaran(_formData);

  //     // Close loading dialog
  //     if (mounted) Navigator.of(context).pop();

  //     if (result['success'] == true) {
  //       // Show success dialog
  //       if (mounted) {
  //         showDialog(
  //           context: context,
  //           barrierDismissible: false,
  //           builder: (BuildContext context) {
  //             return WillPopScope(
  //               onWillPop: () async => false,
  //               child: AlertDialog(
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //                 title: Row(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Icon(Icons.check_circle,
  //                         color: Color(0xFF009137), size: 32),
  //                     SizedBox(width: 12),
  //                     Flexible(
  //                       child: Text(
  //                         'Berhasil!',
  //                         style: TextStyle(
  //                             fontSize: 18, fontWeight: FontWeight.bold),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 content: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       result['message'] ?? 'Pendaftaran berhasil dikirim!',
  //                       style: TextStyle(fontSize: 14),
  //                     ),
  //                     SizedBox(height: 12),
  //                     Container(
  //                       padding: EdgeInsets.all(12),
  //                       decoration: BoxDecoration(
  //                         color: Color(0xFFE8F5E9),
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                       child: Row(
  //                         children: [
  //                           Icon(Icons.info_outline,
  //                               color: Color(0xFF009137), size: 20),
  //                           SizedBox(width: 8),
  //                           Expanded(
  //                             child: Text(
  //                               'Admin akan memverifikasi data Anda dalam 1-3 hari kerja.',
  //                               style: TextStyle(
  //                                   fontSize: 12, color: Color(0xFF1B5E20)),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 actions: [
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                       Navigator.of(context).pushAndRemoveUntil(
  //                         MaterialPageRoute(
  //                           builder: (context) => const DashboardPage(),
  //                         ),
  //                         (route) => false,
  //                       );
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: const Color(0xFF009137),
  //                       foregroundColor: Colors.white,
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                       padding:
  //                           EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  //                     ),
  //                     child: const Text('Kembali ke Dashboard'),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //         );
  //       }
  //     } else {
  //       // Show error dialog
  //       if (mounted) {
  //         showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //               title: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Icon(Icons.error, color: Colors.red, size: 32),
  //                   SizedBox(width: 12),
  //                   Flexible(
  //                     child: Text(
  //                       'Gagal',
  //                       style: TextStyle(
  //                           fontSize: 18, fontWeight: FontWeight.bold),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               content: Text(
  //                 result['message'] ??
  //                     'Terjadi kesalahan saat mengirim pendaftaran. Silakan coba lagi.',
  //                 style: TextStyle(fontSize: 14),
  //               ),
  //               actions: [
  //                 TextButton(
  //                   onPressed: () => Navigator.of(context).pop(),
  //                   style: TextButton.styleFrom(
  //                     foregroundColor: Colors.red,
  //                   ),
  //                   child: const Text('OK'),
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     // Close loading dialog if still open
  //     if (mounted) Navigator.of(context).pop();

  //     // Show error
  //     if (mounted) {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(12),
  //             ),
  //             title: Row(
  //               children: [
  //                 Icon(Icons.error, color: Colors.red),
  //                 SizedBox(width: 8),
  //                 Text('Error', style: TextStyle(fontSize: 16)),
  //               ],
  //             ),
  //             content: Text(
  //               'Terjadi kesalahan: $e',
  //               style: TextStyle(fontSize: 14),
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () => Navigator.of(context).pop(),
  //                 child: const Text('OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   }
  // }
// Tambahkan method ini sebelum _submitPendaftaran()
  Map<String, dynamic> _prepareDataForSubmit() {
    Map<String, dynamic> submitData = {};

    // ========== DATA PRIBADI (Page 0) ==========
    final dataPribadi = _formData[0];
    if (dataPribadi != null) {
      submitData['nama_lengkap'] = dataPribadi['namaLengkap'] ?? '';
      submitData['nik'] = dataPribadi['nik'] ?? '';
      submitData['tempat_lahir'] = dataPribadi['tempatLahir'] ?? '';

      // ✅ FIX: Handle DateTime conversion properly
      if (dataPribadi['tanggalLahir'] != null) {
        try {
          DateTime tanggalLahir;
          if (dataPribadi['tanggalLahir'] is DateTime) {
            tanggalLahir = dataPribadi['tanggalLahir'];
          } else if (dataPribadi['tanggalLahir'] is String) {
            tanggalLahir = DateTime.parse(dataPribadi['tanggalLahir']);
          } else {
            throw Exception('Invalid tanggalLahir type');
          }
          submitData['tanggal_lahir'] =
              DateFormat('yyyy-MM-dd').format(tanggalLahir);
        } catch (e) {
          print('❌ Error formatting tanggalLahir: $e');
          submitData['tanggal_lahir'] = '';
        }
      }

      submitData['jenis_kelamin'] = dataPribadi['jenisKelamin'] ?? '';
      submitData['agama'] = dataPribadi['agama'] ?? '';
      submitData['alamat'] = dataPribadi['alamat'] ?? '';
      submitData['no_hp'] = dataPribadi['noHp'] ?? '';
      submitData['email'] = dataPribadi['email'] ?? '';
      submitData['kode_pos'] = dataPribadi['kodePos'] ?? '';

      // ✅ FIX: Extract location names properly
      if (dataPribadi['province'] != null && dataPribadi['province'] is Map) {
        submitData['province_name'] = dataPribadi['province']['name'] ?? '';
      } else {
        submitData['province_name'] = '';
      }

      if (dataPribadi['regency'] != null && dataPribadi['regency'] is Map) {
        submitData['regency_name'] = dataPribadi['regency']['name'] ?? '';
      } else {
        submitData['regency_name'] = '';
      }

      if (dataPribadi['district'] != null && dataPribadi['district'] is Map) {
        submitData['district_name'] = dataPribadi['district']['name'] ?? '';
      } else {
        submitData['district_name'] = '';
      }

      if (dataPribadi['village'] != null && dataPribadi['village'] is Map) {
        submitData['village_name'] = dataPribadi['village']['name'] ?? '';
      } else {
        submitData['village_name'] = '';
      }
    }

    // ========== DATA AKADEMIK (Page 1) ==========
    final dataAkademik = _formData[1];
    print('📚 Data Akademik Raw: $dataAkademik');

    if (dataAkademik != null) {
      submitData['asal_sekolah'] = dataAkademik['asalSekolah'] ?? '';
      submitData['tahun_lulus'] = dataAkademik['tahunLulus'] ?? '';
      submitData['nilai_rata'] = dataAkademik['nilaiRata'] ?? '0';

      // ✅ FIX: Extract IDs properly
      if (dataAkademik['jurusan'] != null && dataAkademik['jurusan'] is Map) {
        submitData['id_jurusan'] = dataAkademik['jurusan']['id_jurusan'] ?? 0;
        print('✅ ID Jurusan: ${submitData['id_jurusan']}');
      } else {
        submitData['id_jurusan'] = 0;
        print('❌ Jurusan NULL or invalid type');
      }

      if (dataAkademik['prodi'] != null && dataAkademik['prodi'] is Map) {
        submitData['id_prodi'] = dataAkademik['prodi']['id_prodi'] ?? 0;
        print('✅ ID Prodi: ${submitData['id_prodi']}');
      } else {
        submitData['id_prodi'] = 0;
        print('❌ Prodi NULL or invalid type');
      }
    }

    // ========== DATA ORANG TUA (Page 2) ==========
    final dataOrangtua = _formData[2];
    if (dataOrangtua != null) {
      submitData['nama_ayah'] = dataOrangtua['namaAyah'] ?? '';
      submitData['nik_ayah'] = dataOrangtua['nikAyah'] ?? '';
      submitData['pekerjaan_ayah'] = dataOrangtua['pekerjaanAyah'] ?? '';
      submitData['no_tlp_ayah'] = dataOrangtua['noTlpAyah'] ?? '';
      submitData['alamat_ayah'] = dataOrangtua['alamatAyah'] ?? '';
      submitData['penghasilan_ayah'] = dataOrangtua['penghasilanAyah'] ?? '';

      submitData['nama_ibu'] = dataOrangtua['namaIbu'] ?? '';
      submitData['nik_ibu'] = dataOrangtua['nikIbu'] ?? '';
      submitData['pekerjaan_ibu'] = dataOrangtua['pekerjaanIbu'] ?? '';
      submitData['no_tlp_ibu'] = dataOrangtua['noTlpIbu'] ?? '';
      submitData['alamat_ibu'] = dataOrangtua['alamatIbu'] ?? '';
      submitData['penghasilan_ibu'] = dataOrangtua['penghasilanIbu'] ?? '';
    }

    // ========== DATA DOKUMEN (Page 3) - Optional ==========
    // final dataDokumen = _formData[3];
    // if (dataDokumen != null) {
    //   submitData['dokumen'] = dataDokumen;
    // }
    // ========== DATA DOKUMEN (Page 3) ==========
    final dataDokumen = _formData[3];
    List<Map<String, dynamic>> dokumenList = [];

    if (dataDokumen != null) {
      print('📎 Processing Dokumen...');

      if (dataDokumen['ijazah_base64'] != null) {
        dokumenList.add({
          'jenis_dokumen': 'Ijazah/SKL',
          'nama_file': dataDokumen['ijazah_name'] ?? 'ijazah.jpg',
          'file_base64': dataDokumen['ijazah_base64'],
        });
        print('✅ Ijazah added');
      }

      if (dataDokumen['kk_base64'] != null) {
        dokumenList.add({
          'jenis_dokumen': 'Kartu Keluarga',
          'nama_file': dataDokumen['kk_name'] ?? 'kk.jpg',
          'file_base64': dataDokumen['kk_base64'],
        });
        print('✅ KK added');
      }

      if (dataDokumen['akta_base64'] != null) {
        dokumenList.add({
          'jenis_dokumen': 'Akta Kelahiran',
          'nama_file': dataDokumen['akta_name'] ?? 'akta.jpg',
          'file_base64': dataDokumen['akta_base64'],
        });
        print('✅ Akta added');
      }

      if (dataDokumen['foto_base64'] != null) {
        dokumenList.add({
          'jenis_dokumen': 'Pas Foto 3x4',
          'nama_file': dataDokumen['foto_name'] ?? 'foto.jpg',
          'file_base64': dataDokumen['foto_base64'],
        });
        print('✅ Foto added');
      }

      print('📊 Total dokumen: ${dokumenList.length}');
    }

    submitData['dokumen'] = dokumenList;

    print('📤 Final Submit Data: ${jsonEncode(submitData)}');
    return submitData;
  }

// Update method _submitPendaftaran()
  Future<void> _submitPendaftaran() async {
    // Validasi data sebelum submit
    bool isDataComplete = true;
    List<String> missingDataList = [];

    // ========== Check data pribadi ==========
    final dataPribadi = _formData[0];
    if (dataPribadi == null || dataPribadi.isEmpty) {
      isDataComplete = false;
      missingDataList.add('Data Pribadi');
    } else {
      // Check required fields
      if (dataPribadi['namaLengkap'] == null ||
          dataPribadi['namaLengkap'].toString().isEmpty) {
        isDataComplete = false;
        missingDataList.add('Nama Lengkap');
      }
      if (dataPribadi['nik'] == null || dataPribadi['nik'].toString().isEmpty) {
        isDataComplete = false;
        missingDataList.add('NIK');
      }
    }

    // ========== Check data akademik dengan detail ==========
    final dataAkademik = _formData[1];
    print('🔍 Validating Data Akademik:');
    print('   - Full data: $dataAkademik');

    if (dataAkademik == null || dataAkademik.isEmpty) {
      isDataComplete = false;
      missingDataList.add('Data Akademik (Semua field kosong)');
    } else {
      // Validasi asal sekolah
      if (dataAkademik['asalSekolah'] == null ||
          dataAkademik['asalSekolah'].toString().isEmpty) {
        isDataComplete = false;
        missingDataList.add('Asal Sekolah');
      }

      // Validasi tahun lulus
      if (dataAkademik['tahunLulus'] == null ||
          dataAkademik['tahunLulus'].toString().isEmpty) {
        isDataComplete = false;
        missingDataList.add('Tahun Lulus');
      }

      // ✅ FIX: Validasi jurusan - Check Map dan ID
      if (dataAkademik['jurusan'] == null) {
        isDataComplete = false;
        missingDataList.add('Jurusan');
        print('   ❌ Jurusan NULL');
      } else if (dataAkademik['jurusan'] is Map) {
        final idJurusan = dataAkademik['jurusan']['id_jurusan'];
        if (idJurusan == null || idJurusan == 0) {
          isDataComplete = false;
          missingDataList.add('Jurusan (ID tidak valid)');
          print('   ❌ Jurusan ID invalid: $idJurusan');
        } else {
          print('   ✅ Jurusan OK: ${dataAkademik['jurusan']}');
        }
      }

      // ✅ FIX: Validasi prodi - Check Map dan ID
      if (dataAkademik['prodi'] == null) {
        isDataComplete = false;
        missingDataList.add('Program Studi');
        print('   ❌ Prodi NULL');
      } else if (dataAkademik['prodi'] is Map) {
        final idProdi = dataAkademik['prodi']['id_prodi'];
        if (idProdi == null || idProdi == 0) {
          isDataComplete = false;
          missingDataList.add('Program Studi (ID tidak valid)');
          print('   ❌ Prodi ID invalid: $idProdi');
        } else {
          print('   ✅ Prodi OK: ${dataAkademik['prodi']}');
        }
      }
    }

    // ========== Check data orangtua ==========
    final dataOrangtua = _formData[2];
    if (dataOrangtua == null || dataOrangtua.isEmpty) {
      isDataComplete = false;
      missingDataList.add('Data Orang Tua');
    } else {
      if (dataOrangtua['namaAyah'] == null ||
          dataOrangtua['namaAyah'].toString().isEmpty) {
        isDataComplete = false;
        missingDataList.add('Nama Ayah');
      }
      if (dataOrangtua['namaIbu'] == null ||
          dataOrangtua['namaIbu'].toString().isEmpty) {
        isDataComplete = false;
        missingDataList.add('Nama Ibu');
      }
    }

    // ========== Tampilkan error jika ada data yang kurang ==========
    if (!isDataComplete) {
      String missingData = missingDataList.join('\n• ');

      print('❌ Data tidak lengkap:');
      print('   Missing: $missingDataList');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Row(
              children: [
                Icon(Icons.warning, color: Colors.orange),
                SizedBox(width: 8),
                Text('Data Belum Lengkap', style: TextStyle(fontSize: 16)),
              ],
            ),
            content: Text(
              'Mohon lengkapi data berikut:\n\n• $missingData',
              style: TextStyle(fontSize: 14),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // ========== Jika semua data lengkap, prepare dan submit ==========
    print('✅ Semua data lengkap, mempersiapkan submit...');

    final preparedData = _prepareDataForSubmit();

    // Debug: Print data yang akan dikirim
    print('📤 Data yang akan dikirim ke server:');
    print(jsonEncode(preparedData));

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: Color(0xFF009137),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Mengirim data pendaftaran...',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    try {
      // Submit pendaftaran dengan data yang sudah diproses
      final preparedData = _prepareDataForSubmit();
      final result = await PendaftaranService.submitPendaftaran(preparedData);

      // Debug: Print response dari server
      print('📥 Response dari server:');
      print(jsonEncode(result));

      // Close loading dialog
      if (mounted) Navigator.of(context).pop();

      if (result['success'] == true) {
        // Show success dialog
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle,
                          color: Color(0xFF009137), size: 32),
                      SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          'Berhasil!',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result['message'] ?? 'Pendaftaran berhasil dikirim!',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,
                                color: Color(0xFF009137), size: 20),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Admin akan memverifikasi data Anda dalam 1-3 hari kerja.',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xFF1B5E20)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const DashboardPage(),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF009137),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Kembali ke Dashboard'),
                    ),
                  ],
                ),
              );
            },
          );
        }
      } else {
        // Show error dialog
        if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 32),
                    SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        'Gagal',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                content: Text(
                  result['message'] ??
                      'Terjadi kesalahan saat mengirim pendaftaran. Silakan coba lagi.',
                  style: TextStyle(fontSize: 14),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      // Close loading dialog if still open
      if (mounted) Navigator.of(context).pop();

      // Debug: Print error
      print('❌ Error saat submit: $e');

      // Show error
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Row(
                children: [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Error', style: TextStyle(fontSize: 16)),
                ],
              ),
              content: Text(
                'Terjadi kesalahan: $e',
                style: TextStyle(fontSize: 14),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: CustomAppBar(
          title: 'Formulir Pendaftaran',
          showMenuButton: true,
          showProfileMenu: true,
          currentPage: 'formulir',
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF233746),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: CustomAppBar(
        title: 'Formulir Pendaftaran',
        showMenuButton: true,
        showProfileMenu: true,
        currentPage: 'formulir',
      ),
      drawer: const AppDrawer(currentPage: 'formulir'),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // ========== HEADER BOX ==========
            Container(
              color: const Color(0xFF2C3E50),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4F6C7A),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            "Formulir Pendaftaran Mahasiswa Baru",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${_currentPage + 1} dari 5",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _stepTitles[_currentPage],
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ========== TAB NAVIGATION ==========
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _tabItem(Icons.person, "Data Pribadi", _currentPage == 0),
                    _tabItem(Icons.school, "Data Akademik", _currentPage == 1),
                    _tabItem(Icons.group, "Data Orang Tua", _currentPage == 2),
                    _tabItem(
                      Icons.upload_file,
                      "Upload Dokumen",
                      _currentPage == 3,
                    ),
                    _tabItem(
                      Icons.check_circle,
                      "Review & Submit",
                      _currentPage == 4,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ========== KONTEN ==========
            _buildCurrentPageContent(),

            // // ========== BOTTOM NAVIGATION ==========
            // Container(
            //   margin: const EdgeInsets.all(12),
            //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(16),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withValues(alpha: 0.1),
            //         offset: const Offset(0, 4),
            //         blurRadius: 12,
            //       ),
            //     ],
            //   ),
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: [
            //       Row(
            //           mainAxisAlignment: _currentPage == 4
            //               ? MainAxisAlignment.start
            //               : MainAxisAlignment.spaceBetween,
            //           children: [
            //             Container(
            //               width: 140,
            //               child: ElevatedButton(
            //                 onPressed: _currentPage > 0 ? _previousPage : null,
            //                 style: ElevatedButton.styleFrom(
            //                   backgroundColor: Colors.white,
            //                   foregroundColor: Colors.black,
            //                   elevation: 0,
            //                   side: BorderSide(color: Colors.grey.shade300),
            //                   shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(8),
            //                   ),
            //                 ),
            //                 child: const Text("< Sebelumnya"),
            //               ),
            //             ),
            //             if (_currentPage != 4)
            //               Container(
            //                 child: ElevatedButton.icon(
            //                   onPressed: (_formData[_currentPage]?.values.any(
            //                               (v) =>
            //                                   v != null &&
            //                                   v.toString().trim().isNotEmpty) ??
            //                           false)
            //                       ? _saveDraft
            //                       : null,
            //                   icon: const Icon(Icons.save_outlined,
            //                       color: Colors.white),
            //                   label: const Text(
            //                     "Simpan Draft",
            //                     style: TextStyle(color: Colors.white),
            //                   ),
            //                   style: ElevatedButton.styleFrom(
            //                     backgroundColor:
            //                         _pagesSaved[_currentPage] == true
            //                             ? const Color(0xFF009137)
            //                             : const Color(0xFFFF9800),
            //                     elevation: 0,
            //                     shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(8),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //           ]),
            //       const SizedBox(height: 10),
            //       Align(
            //         alignment: Alignment.centerRight,
            //         child: Container(
            //           width: 140,
            //           child: ElevatedButton(
            //             onPressed:
            //                 // () async {
            //                 //   // Validasi data sebelum submit
            //                 //   bool isDataComplete = true;
            //                 //   String missingData = '';

            //                 //   // Check data pribadi
            //                 //   final dataPribadi = _formData[0];
            //                 //   if (dataPribadi == null || dataPribadi.isEmpty) {
            //                 //     isDataComplete = false;
            //                 //     missingData = 'Data Pribadi';
            //                 //   }

            //                 //   // Check data akademik
            //                 //   final dataAkademik = _formData[1];
            //                 //   if (dataAkademik == null ||
            //                 //       dataAkademik['jurusan'] == null ||
            //                 //       dataAkademik['prodi'] == null) {
            //                 //     isDataComplete = false;
            //                 //     if (missingData.isNotEmpty) missingData += ', ';
            //                 //     missingData += 'Data Akademik (Jurusan/Prodi)';
            //                 //   }

            //                 //   // Check data orangtua
            //                 //   final dataOrangtua = _formData[2];
            //                 //   if (dataOrangtua == null || dataOrangtua.isEmpty) {
            //                 //     isDataComplete = false;
            //                 //     if (missingData.isNotEmpty) missingData += ', ';
            //                 //     missingData += 'Data Orang Tua';
            //                 //   }

            //                 //   if (!isDataComplete) {
            //                 //     showDialog(
            //                 //       context: context,
            //                 //       builder: (BuildContext context) {
            //                 //         return AlertDialog(
            //                 //           shape: RoundedRectangleBorder(
            //                 //             borderRadius: BorderRadius.circular(12),
            //                 //           ),
            //                 //           title: Row(
            //                 //             children: [
            //                 //               Icon(Icons.warning, color: Colors.orange),
            //                 //               SizedBox(width: 8),
            //                 //               Text('Data Belum Lengkap',
            //                 //                   style: TextStyle(fontSize: 16)),
            //                 //             ],
            //                 //           ),
            //                 //           content: Text(
            //                 //             'Mohon lengkapi data berikut terlebih dahulu: $missingData',
            //                 //             style: TextStyle(fontSize: 14),
            //                 //           ),
            //                 //           actions: [
            //                 //             TextButton(
            //                 //               onPressed: () =>
            //                 //                   Navigator.of(context).pop(),
            //                 //               child: const Text('OK'),
            //                 //             ),
            //                 //           ],
            //                 //         );
            //                 //       },
            //                 //     );
            //                 //     return;
            //                 //   }

            //                 //   // Show loading dialog
            //                 //   showDialog(
            //                 //     context: context,
            //                 //     barrierDismissible: false,
            //                 //     builder: (BuildContext context) {
            //                 //       return WillPopScope(
            //                 //         onWillPop: () async => false,
            //                 //         child: Center(
            //                 //           child: Container(
            //                 //             padding: EdgeInsets.all(20),
            //                 //             decoration: BoxDecoration(
            //                 //               color: Colors.white,
            //                 //               borderRadius: BorderRadius.circular(12),
            //                 //             ),
            //                 //             child: Column(
            //                 //               mainAxisSize: MainAxisSize.min,
            //                 //               children: [
            //                 //                 CircularProgressIndicator(
            //                 //                   color: Color(0xFF009137),
            //                 //                 ),
            //                 //                 SizedBox(height: 16),
            //                 //                 Text(
            //                 //                   'Mengirim data pendaftaran...',
            //                 //                   style: TextStyle(fontSize: 14),
            //                 //                 ),
            //                 //               ],
            //                 //             ),
            //                 //           ),
            //                 //         ),
            //                 //       );
            //                 //     },
            //                 //   );

            //                 //   // Submit pendaftaran
            //                 //   final result =
            //                 //       await PendaftaranService.submitPendaftaran(
            //                 //           _formData);

            //                 //   // Close loading dialog
            //                 //   if (mounted) Navigator.of(context).pop();

            //                 //   if (result['success'] == true) {
            //                 //     // Show success dialog
            //                 //     if (mounted) {
            //                 //       showDialog(
            //                 //         context: context,
            //                 //         barrierDismissible: false,
            //                 //         builder: (BuildContext context) {
            //                 //           return WillPopScope(
            //                 //             onWillPop: () async => false,
            //                 //             child: AlertDialog(
            //                 //               shape: RoundedRectangleBorder(
            //                 //                 borderRadius: BorderRadius.circular(12),
            //                 //               ),
            //                 //               title: Row(
            //                 //                 mainAxisSize: MainAxisSize.min,
            //                 //                 children: [
            //                 //                   Icon(Icons.check_circle,
            //                 //                       color: Color(0xFF009137),
            //                 //                       size: 32),
            //                 //                   SizedBox(width: 12),
            //                 //                   Flexible(
            //                 //                     child: Text(
            //                 //                       'Berhasil!',
            //                 //                       style: TextStyle(
            //                 //                           fontSize: 18,
            //                 //                           fontWeight: FontWeight.bold),
            //                 //                     ),
            //                 //                   ),
            //                 //                 ],
            //                 //               ),
            //                 //               content: Column(
            //                 //                 mainAxisSize: MainAxisSize.min,
            //                 //                 crossAxisAlignment:
            //                 //                     CrossAxisAlignment.start,
            //                 //                 children: [
            //                 //                   Text(
            //                 //                     result['message'] ??
            //                 //                         'Pendaftaran berhasil dikirim!',
            //                 //                     style: TextStyle(fontSize: 14),
            //                 //                   ),
            //                 //                   SizedBox(height: 12),
            //                 //                   Container(
            //                 //                     padding: EdgeInsets.all(12),
            //                 //                     decoration: BoxDecoration(
            //                 //                       color: Color(0xFFE8F5E9),
            //                 //                       borderRadius:
            //                 //                           BorderRadius.circular(8),
            //                 //                     ),
            //                 //                     child: Row(
            //                 //                       children: [
            //                 //                         Icon(Icons.info_outline,
            //                 //                             color: Color(0xFF009137),
            //                 //                             size: 20),
            //                 //                         SizedBox(width: 8),
            //                 //                         Expanded(
            //                 //                           child: Text(
            //                 //                             'Admin akan memverifikasi data Anda dalam 1-3 hari kerja.',
            //                 //                             style: TextStyle(
            //                 //                                 fontSize: 12,
            //                 //                                 color:
            //                 //                                     Color(0xFF1B5E20)),
            //                 //                           ),
            //                 //                         ),
            //                 //                       ],
            //                 //                     ),
            //                 //                   ),
            //                 //                 ],
            //                 //               ),
            //                 //               actions: [
            //                 //                 ElevatedButton(
            //                 //                   onPressed: () {
            //                 //                     Navigator.of(context).pop();
            //                 //                     Navigator.of(context)
            //                 //                         .pushAndRemoveUntil(
            //                 //                       MaterialPageRoute(
            //                 //                         builder: (context) =>
            //                 //                             const DashboardPage(),
            //                 //                       ),
            //                 //                       (route) => false,
            //                 //                     );
            //                 //                   },
            //                 //                   style: ElevatedButton.styleFrom(
            //                 //                     backgroundColor:
            //                 //                         const Color(0xFF009137),
            //                 //                     foregroundColor: Colors.white,
            //                 //                     shape: RoundedRectangleBorder(
            //                 //                       borderRadius:
            //                 //                           BorderRadius.circular(8),
            //                 //                     ),
            //                 //                     padding: EdgeInsets.symmetric(
            //                 //                         horizontal: 24, vertical: 12),
            //                 //                   ),
            //                 //                   child: const Text(
            //                 //                       'Kembali ke Dashboard'),
            //                 //                 ),
            //                 //               ],
            //                 //             ),
            //                 //           );
            //                 //         },
            //                 //       );
            //                 //     }
            //                 //   } else {
            //                 //     // Show error dialog
            //                 //     if (mounted) {
            //                 //       showDialog(
            //                 //         context: context,
            //                 //         builder: (BuildContext context) {
            //                 //           return AlertDialog(
            //                 //             shape: RoundedRectangleBorder(
            //                 //               borderRadius: BorderRadius.circular(12),
            //                 //             ),
            //                 //             title: Row(
            //                 //               mainAxisSize: MainAxisSize.min,
            //                 //               children: [
            //                 //                 Icon(Icons.error,
            //                 //                     color: Colors.red, size: 32),
            //                 //                 SizedBox(width: 12),
            //                 //                 Flexible(
            //                 //                   child: Text(
            //                 //                     'Gagal',
            //                 //                     style: TextStyle(
            //                 //                         fontSize: 18,
            //                 //                         fontWeight: FontWeight.bold),
            //                 //                   ),
            //                 //                 ),
            //                 //               ],
            //                 //             ),
            //                 //             content: Text(
            //                 //               result['message'] ??
            //                 //                   'Terjadi kesalahan saat mengirim pendaftaran. Silakan coba lagi.',
            //                 //               style: TextStyle(fontSize: 14),
            //                 //             ),
            //                 //             actions: [
            //                 //               TextButton(
            //                 //                 onPressed: () =>
            //                 //                     Navigator.of(context).pop(),
            //                 //                 style: TextButton.styleFrom(
            //                 //                   foregroundColor: Colors.red,
            //                 //                 ),
            //                 //                 child: const Text('OK'),
            //                 //               ),
            //                 //             ],
            //                 //           );
            //                 //         },
            //                 //       );
            //                 //     }
            //                 //   }
            //                 // },

            //                 () async {
            //               // Validasi data sebelum submit
            //               bool isDataComplete = true;
            //               String missingData = '';

            //               // Check data pribadi
            //               final dataPribadi = _formData[0];
            //               if (dataPribadi == null || dataPribadi.isEmpty) {
            //                 isDataComplete = false;
            //                 missingData = 'Data Pribadi';
            //               }

            //               // Check data akademik
            //               final dataAkademik = _formData[1];
            //               if (dataAkademik == null ||
            //                   dataAkademik['jurusan'] == null ||
            //                   dataAkademik['prodi'] == null) {
            //                 isDataComplete = false;
            //                 if (missingData.isNotEmpty) missingData += ', ';
            //                 missingData += 'Data Akademik (Jurusan/Prodi)';
            //               }

            //               // Check data orangtua
            //               final dataOrangtua = _formData[2];
            //               if (dataOrangtua == null || dataOrangtua.isEmpty) {
            //                 isDataComplete = false;
            //                 if (missingData.isNotEmpty) missingData += ', ';
            //                 missingData += 'Data Orang Tua';
            //               }

            //               if (!isDataComplete) {
            //                 showDialog(
            //                   context: context,
            //                   builder: (BuildContext context) {
            //                     return AlertDialog(
            //                       shape: RoundedRectangleBorder(
            //                         borderRadius: BorderRadius.circular(12),
            //                       ),
            //                       title: Row(
            //                         children: [
            //                           Icon(Icons.warning, color: Colors.orange),
            //                           SizedBox(width: 8),
            //                           Text('Data Belum Lengkap',
            //                               style: TextStyle(fontSize: 16)),
            //                         ],
            //                       ),
            //                       content: Text(
            //                         'Mohon lengkapi data berikut terlebih dahulu: $missingData',
            //                         style: TextStyle(fontSize: 14),
            //                       ),
            //                       actions: [
            //                         TextButton(
            //                           onPressed: () =>
            //                               Navigator.of(context).pop(),
            //                           child: const Text('OK'),
            //                         ),
            //                       ],
            //                     );
            //                   },
            //                 );
            //                 return;
            //               }

            //               // Show loading dialog
            //               showDialog(
            //                 context: context,
            //                 barrierDismissible: false,
            //                 builder: (BuildContext context) {
            //                   return WillPopScope(
            //                     onWillPop: () async => false,
            //                     child: Center(
            //                       child: Container(
            //                         padding: EdgeInsets.all(20),
            //                         decoration: BoxDecoration(
            //                           color: Colors.white,
            //                           borderRadius: BorderRadius.circular(12),
            //                         ),
            //                         child: Column(
            //                           mainAxisSize: MainAxisSize.min,
            //                           children: [
            //                             CircularProgressIndicator(
            //                               color: Color(0xFF009137),
            //                             ),
            //                             SizedBox(height: 16),
            //                             Text(
            //                               'Mengirim data pendaftaran...',
            //                               style: TextStyle(fontSize: 14),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 },
            //               );

            //               // Submit pendaftaran
            //               final result =
            //                   await PendaftaranService.submitPendaftaran(
            //                       _formData);

            //               // Close loading dialog
            //               if (mounted) Navigator.of(context).pop();

            //               if (result['success'] == true) {
            //                 // Show success dialog
            //                 if (mounted) {
            //                   showDialog(
            //                     context: context,
            //                     barrierDismissible: false,
            //                     builder: (BuildContext context) {
            //                       return WillPopScope(
            //                         onWillPop: () async => false,
            //                         child: AlertDialog(
            //                           shape: RoundedRectangleBorder(
            //                             borderRadius: BorderRadius.circular(12),
            //                           ),
            //                           title: Row(
            //                             mainAxisSize: MainAxisSize.min,
            //                             children: [
            //                               Icon(Icons.check_circle,
            //                                   color: Color(0xFF009137),
            //                                   size: 32),
            //                               SizedBox(width: 12),
            //                               Flexible(
            //                                 child: Text(
            //                                   'Berhasil!',
            //                                   style: TextStyle(
            //                                       fontSize: 18,
            //                                       fontWeight: FontWeight.bold),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                           content: Column(
            //                             mainAxisSize: MainAxisSize.min,
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                             children: [
            //                               Text(
            //                                 result['message'] ??
            //                                     'Pendaftaran berhasil dikirim!',
            //                                 style: TextStyle(fontSize: 14),
            //                               ),
            //                               SizedBox(height: 12),
            //                               Container(
            //                                 padding: EdgeInsets.all(12),
            //                                 decoration: BoxDecoration(
            //                                   color: Color(0xFFE8F5E9),
            //                                   borderRadius:
            //                                       BorderRadius.circular(8),
            //                                 ),
            //                                 child: Row(
            //                                   children: [
            //                                     Icon(Icons.info_outline,
            //                                         color: Color(0xFF009137),
            //                                         size: 20),
            //                                     SizedBox(width: 8),
            //                                     Expanded(
            //                                       child: Text(
            //                                         'Admin akan memverifikasi data Anda dalam 1-3 hari kerja.',
            //                                         style: TextStyle(
            //                                             fontSize: 12,
            //                                             color:
            //                                                 Color(0xFF1B5E20)),
            //                                       ),
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                           actions: [
            //                             ElevatedButton(
            //                               onPressed: () {
            //                                 Navigator.of(context).pop();
            //                                 Navigator.of(context)
            //                                     .pushAndRemoveUntil(
            //                                   MaterialPageRoute(
            //                                     builder: (context) =>
            //                                         const DashboardPage(),
            //                                   ),
            //                                   (route) => false,
            //                                 );
            //                               },
            //                               style: ElevatedButton.styleFrom(
            //                                 backgroundColor:
            //                                     const Color(0xFF009137),
            //                                 foregroundColor: Colors.white,
            //                                 shape: RoundedRectangleBorder(
            //                                   borderRadius:
            //                                       BorderRadius.circular(8),
            //                                 ),
            //                                 padding: EdgeInsets.symmetric(
            //                                     horizontal: 24, vertical: 12),
            //                               ),
            //                               child: const Text(
            //                                   'Kembali ke Dashboard'),
            //                             ),
            //                           ],
            //                         ),
            //                       );
            //                     },
            //                   );
            //                 }
            //               } else {
            //                 // Show error dialog
            //                 if (mounted) {
            //                   showDialog(
            //                     context: context,
            //                     builder: (BuildContext context) {
            //                       return AlertDialog(
            //                         shape: RoundedRectangleBorder(
            //                           borderRadius: BorderRadius.circular(12),
            //                         ),
            //                         title: Row(
            //                           mainAxisSize: MainAxisSize.min,
            //                           children: [
            //                             Icon(Icons.error,
            //                                 color: Colors.red, size: 32),
            //                             SizedBox(width: 12),
            //                             Flexible(
            //                               child: Text(
            //                                 'Gagal',
            //                                 style: TextStyle(
            //                                     fontSize: 18,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                         content: Text(
            //                           result['message'] ??
            //                               'Terjadi kesalahan saat mengirim pendaftaran. Silakan coba lagi.',
            //                           style: TextStyle(fontSize: 14),
            //                         ),
            //                         actions: [
            //                           TextButton(
            //                             onPressed: () =>
            //                                 Navigator.of(context).pop(),
            //                             style: TextButton.styleFrom(
            //                               foregroundColor: Colors.red,
            //                             ),
            //                             child: const Text('OK'),
            //                           ),
            //                         ],
            //                       );
            //                     },
            //                   );
            //                 }
            //               }
            //             },
            //             // _currentPage < 4
            //             //     ? (_checkRequiredFields(
            //             //             _formData[_currentPage] ?? {})
            //             //         ? _nextPage
            //             //         : null)
            //             //     : () {
            //             //         showDialog(
            //             //           context: context,
            //             //           builder: (BuildContext context) {
            //             //             return AlertDialog(
            //             //               shape: RoundedRectangleBorder(
            //             //                 borderRadius: BorderRadius.circular(12),
            //             //               ),
            //             //               title: Row(
            //             //                 mainAxisSize: MainAxisSize.min,
            //             //                 children: [
            //             //                   Icon(Icons.check_circle,
            //             //                       color: Color(0xFF009137)),
            //             //                   SizedBox(width: 8),
            //             //                   Flexible(
            //             //                     child: Text(
            //             //                       'Konfirmasi Pendaftaran',
            //             //                       style: TextStyle(fontSize: 16),
            //             //                     ),
            //             //                   ),
            //             //                 ],
            //             //               ),
            //             //               content: Text(
            //             //                 'Apakah Anda yakin ingin mengirim formulir pendaftaran? Pastikan semua data sudah benar dan lengkap.',
            //             //                 style: TextStyle(fontSize: 14),
            //             //               ),
            //             //               actions: [
            //             //                 Row(
            //             //                   mainAxisAlignment:
            //             //                       MainAxisAlignment.end,
            //             //                   children: [
            //             //                     TextButton(
            //             //                       onPressed: () =>
            //             //                           Navigator.of(context).pop(),
            //             //                       child: const Text('Batal'),
            //             //                     ),
            //             //                     SizedBox(width: 8),
            //             //                     ElevatedButton(
            //             //                       onPressed: () {
            //             //                         Navigator.of(context).pop();
            //             //                         ScaffoldMessenger.of(context)
            //             //                             .showSnackBar(
            //             //                           const SnackBar(
            //             //                             content: Row(
            //             //                               mainAxisSize:
            //             //                                   MainAxisSize.min,
            //             //                               children: [
            //             //                                 Icon(Icons.check_circle,
            //             //                                     color:
            //             //                                         Colors.white),
            //             //                                 SizedBox(width: 8),
            //             //                                 Text(
            //             //                                     "Formulir berhasil dikirim!"),
            //             //                               ],
            //             //                             ),
            //             //                             backgroundColor:
            //             //                                 Color(0xFF009137),
            //             //                             duration:
            //             //                                 Duration(seconds: 3),
            //             //                           ),
            //             //                         );
            //             //                         Navigator.of(context)
            //             //                             .pushAndRemoveUntil(
            //             //                           MaterialPageRoute(
            //             //                             builder: (context) =>
            //             //                                 const DashboardPage(),
            //             //                           ),
            //             //                           (route) => false,
            //             //                         );
            //             //                       },
            //             //                       style: ElevatedButton.styleFrom(
            //             //                         backgroundColor:
            //             //                             const Color(0xFF009137),
            //             //                         foregroundColor: Colors.white,
            //             //                         shape: RoundedRectangleBorder(
            //             //                           borderRadius:
            //             //                               BorderRadius.circular(8),
            //             //                         ),
            //             //                       ),
            //             //                       child: const Text('Kirim'),
            //             //                     ),
            //             //                   ],
            //             //                 ),
            //             //               ],
            //             //             );
            //             //           },
            //             //         );
            //             //       },
            //             // style: ElevatedButton.styleFrom(
            //             //   backgroundColor: _currentPage < 4
            //             //       ? (_checkRequiredFields(
            //             //                   _formData[_currentPage] ?? {}) ||
            //             //               _pagesSaved[_currentPage] == true
            //             //           ? const Color(0xFF233746)
            //             //           : Colors.grey.shade300)
            //             //       : const Color(0xFF009137),
            //             //   foregroundColor: Colors.white,
            //             //   elevation: _currentPage < 4
            //             //       ? (_checkRequiredFields(
            //             //                   _formData[_currentPage] ?? {}) ||
            //             //               _pagesSaved[_currentPage] == true
            //             //           ? 2
            //             //           : 0)
            //             //       : 3,
            //             //   shadowColor: _currentPage < 4
            //             //       ? (_checkRequiredFields(
            //             //                   _formData[_currentPage] ?? {}) ||
            //             //               _pagesSaved[_currentPage] == true
            //             //           ? const Color(0xFF233746)
            //             //               .withValues(alpha: 0.3)
            //             //           : Colors.transparent)
            //             //       : const Color(0xFF009137).withValues(alpha: 0.3),
            //             //   shape: RoundedRectangleBorder(
            //             //     borderRadius: BorderRadius.circular(12),
            //             //   ),
            //             //   padding: const EdgeInsets.symmetric(
            //             //       vertical: 12, horizontal: 16),
            //             // ),

            //             child: Text(_currentPage < 4
            //                 ? "Selanjutnya >"
            //                 : "Daftar Sekarang"),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
// ========== BOTTOM NAVIGATION ==========
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: _currentPage == 4
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      // Tombol Sebelumnya
                      Container(
                        width: 140,
                        child: ElevatedButton(
                          onPressed: _currentPage > 0 ? _previousPage : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("< Sebelumnya"),
                        ),
                      ),

                      // Tombol Simpan Draft (hanya tampil jika bukan halaman review)
                      if (_currentPage != 4)
                        Container(
                          child: ElevatedButton.icon(
                            onPressed: (_formData[_currentPage]?.values.any(
                                        (v) =>
                                            v != null &&
                                            v.toString().trim().isNotEmpty) ??
                                    false)
                                ? _saveDraft
                                : null,
                            icon: const Icon(Icons.save_outlined,
                                color: Colors.white),
                            label: const Text(
                              "Simpan Draft",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _pagesSaved[_currentPage] == true
                                  ? const Color(0xFF009137)
                                  : const Color(0xFFFF9800),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Tombol Selanjutnya / Daftar Sekarang
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 140,
                      child: ElevatedButton(
                        onPressed: _currentPage < 4
                            ? (_checkRequiredFields(
                                    _formData[_currentPage] ?? {})
                                ? _nextPage
                                : null)
                            : () =>
                                _submitPendaftaran(), // Panggil method terpisah
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _currentPage < 4
                              ? (_checkRequiredFields(
                                          _formData[_currentPage] ?? {}) ||
                                      _pagesSaved[_currentPage] == true
                                  ? const Color(0xFF233746)
                                  : Colors.grey.shade300)
                              : const Color(0xFF009137),
                          foregroundColor: Colors.white,
                          elevation: _currentPage < 4
                              ? (_checkRequiredFields(
                                          _formData[_currentPage] ?? {}) ||
                                      _pagesSaved[_currentPage] == true
                                  ? 2
                                  : 0)
                              : 3,
                          shadowColor: _currentPage < 4
                              ? (_checkRequiredFields(
                                          _formData[_currentPage] ?? {}) ||
                                      _pagesSaved[_currentPage] == true
                                  ? const Color(0xFF233746)
                                      .withValues(alpha: 0.3)
                                  : Colors.transparent)
                              : const Color(0xFF009137).withValues(alpha: 0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                        ),
                        child: Text(_currentPage < 4
                            ? "Selanjutnya >"
                            : "Daftar Sekarang"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _navigateToPage(int pageIndex) {
    if (pageIndex != _currentPage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _currentPage = pageIndex;
          });
          _scrollToTop();
        }
      });
    }
  }

  Widget _buildCurrentPageContent() {
    final uniqueKey = ValueKey(
        'page_${_currentPage}_${_formData[_currentPage]?.length ?? 0}');

    switch (_currentPage) {
      case 0:
        return DataPribadiPage(
          key: uniqueKey,
          savedData: _formData[0],
          onDataChanged: _handlePageDataChanged,
        );
      case 1:
        return DataAkademikPage(
          key: uniqueKey,
          savedData: _formData[1],
          onDataChanged: _handlePageDataChanged,
        );
      case 2:
        return DataOrtuPage(
          key: uniqueKey,
          savedData: _formData[2],
          onDataChanged: _handlePageDataChanged,
        );
      case 3:
        return UploadDokumenPage(
          key: uniqueKey,
          savedData: _formData[3],
          onDataChanged: _handlePageDataChanged,
        );
      case 4:
        return ReviewSubmitPage(
          key: uniqueKey,
          formData: _formData,
          pagesSaved: _pagesSaved,
          onPageEdit: _navigateToPage,
        );
      default:
        return DataPribadiPage(
          key: uniqueKey,
          savedData: _formData[0],
          onDataChanged: _handlePageDataChanged,
        );
    }
  }

  Widget _tabItem(IconData icon, String title, bool active) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: active ? const Color(0xFF4F6C7A) : Colors.grey.shade400,
              width: 2,
            ),
            color: active ? const Color(0xFFE8F0F3) : Colors.white,
          ),
          child: Icon(
            icon,
            color: active ? const Color(0xFF4F6C7A) : Colors.grey[600],
            size: 20,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 60,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: active ? const Color(0xFF4F6C7A) : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
