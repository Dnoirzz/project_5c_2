// import 'package:flutter/material.dart';

// class DataAkademikPage extends StatefulWidget {
//   final Map<String, dynamic>? savedData;
//   final Function(Map<String, dynamic>) onDataChanged;

//   const DataAkademikPage({
//     super.key,
//     this.savedData,
//     required this.onDataChanged,
//   });

//   @override
//   State<DataAkademikPage> createState() => _DataAkademikPageState();
// }

// class _DataAkademikPageState extends State<DataAkademikPage> {
//   String? _selectedTahunLulus;
//   String? _selectedJurusan;
//   String? _selectedProdi;

//   // TextEditingController untuk setiap field
//   final TextEditingController _asalSekolahController = TextEditingController();
//   final TextEditingController _nilaiRataController = TextEditingController();

//   void _notifyDataChanged() {
//     Map<String, dynamic> data = {
//       'asalSekolah': _asalSekolahController.text,
//       'tahunLulus': _selectedTahunLulus,
//       'nilaiRata': _nilaiRataController.text,
//     };

//     // Only include non-null values for dropdowns
//     if (_selectedJurusan != null) {
//       data['jurusan'] = _selectedJurusan;
//     }
//     if (_selectedProdi != null) {
//       data['prodi'] = _selectedProdi;
//     }

//     widget.onDataChanged(data);
//   }

//   void _setupTextFieldListeners() {
//     _asalSekolahController.addListener(_notifyDataChanged);
//     _nilaiRataController.addListener(_notifyDataChanged);
//   }

//   @override
//   void initState() {
//     super.initState();
//     if (widget.savedData != null) {
//       _asalSekolahController.text = widget.savedData?['asalSekolah'] ?? '';
//       _selectedTahunLulus = widget.savedData?['tahunLulus'];
//       _nilaiRataController.text = widget.savedData?['nilaiRata'] ?? '';
//       _selectedJurusan = widget.savedData?['jurusan'];
//       _selectedProdi = widget.savedData?['prodi'];
//     }
//     _setupTextFieldListeners();
//   }

//   @override
//   void dispose() {
//     _asalSekolahController.removeListener(_notifyDataChanged);
//     _nilaiRataController.removeListener(_notifyDataChanged);
//     _asalSekolahController.dispose();
//     _nilaiRataController.dispose();
//     super.dispose();
//   }

//   List<String> _getTahunLulusList() {
//     final currentYear = DateTime.now().year;
//     final List<String> years = [];

//     // Generate tahun dari 1950 sampai tahun sekarang
//     for (int year = currentYear; year >= 2018; year--) {
//       years.add(year.toString());
//     }

//     return years;
//   }

//   List<String> _getJurusanList() {
//     return ['Teknik Elektro', 'Teknik Sipil', 'Akuntansi'];
//   }

//   List<String> _getProdiList(String? jurusan) {
//     switch (jurusan) {
//       case 'Teknik Elektro':
//         return [
//           'D3 - Teknik Listrik',
//           'D3 - Teknik Informatika',
//           'D4 - Teknik Rekayasa Sistem Elektronika',
//         ];
//       case 'Teknik Sipil':
//         return [
//           'D3 - Teknik Sipil',
//           'D4 - Teknologi Rekayasa Kontruksi Jalan & Jembatan',
//           'D4 - Perencanaan Perumahan & Permukiman',
//         ];
//       case 'Akuntansi':
//         return ['Akuntansi', 'Manajemen', 'Keuangan'];
//       default:
//         return [];
//     }
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
//                   Icon(Icons.school, color: Colors.blue),
//                   SizedBox(width: 8),
//                   Text(
//                     "Data Akademik",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 4),
//               const Text(
//                 "Informasi pendidikan dan akademik",
//                 style: TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//               const SizedBox(height: 16),

//               // Asal Sekolah
//               _inputField(
//                 "Asal Sekolah",
//                 "Masukkan Nama Sekolah",
//                 controller: _asalSekolahController,
//               ),

//               // Tahun Lulus - Dropdown
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Tahun Lulus",
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                   ),
//                   const SizedBox(height: 8),
//                   DropdownButtonFormField<String>(
//                     value: _selectedTahunLulus,
//                     isExpanded: true,
//                     style: const TextStyle(fontSize: 14, color: Colors.black),
//                     decoration: InputDecoration(
//                       hintText: "Pilih tahun lulus",
//                       hintStyle: const TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 14,
//                         horizontal: 12,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(color: Colors.grey.shade300),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(color: Colors.grey.shade300),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: const BorderSide(color: Color(0xFF4F6C7A)),
//                       ),
//                     ),
//                     items: _getTahunLulusList().map((String tahun) {
//                       return DropdownMenuItem<String>(
//                         value: tahun,
//                         child: Text(
//                           tahun,
//                           style: const TextStyle(fontSize: 14),
//                         ),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         _selectedTahunLulus = newValue;
//                         _notifyDataChanged();
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Nilai Rata-rata
//               _inputField(
//                 "Nilai Rata-rata",
//                 "Masukkan nilai rata-rata",
//                 controller: _nilaiRataController,
//                 keyboardType: TextInputType.numberWithOptions(decimal: true),
//               ),

//               // Jurusan yang Dipilih - Dropdown
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Jurusan yang Dipilih",
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                   ),
//                   const SizedBox(height: 8),
//                   DropdownButtonFormField<String>(
//                     value: _selectedJurusan,
//                     isExpanded: true,
//                     style: const TextStyle(fontSize: 14, color: Colors.black),
//                     decoration: InputDecoration(
//                       hintText: "Pilih jurusan",
//                       hintStyle: const TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 14,
//                         horizontal: 12,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(color: Colors.grey.shade300),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(color: Colors.grey.shade300),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: const BorderSide(color: Color(0xFF4F6C7A)),
//                       ),
//                     ),
//                     items: _getJurusanList().map((String jurusan) {
//                       return DropdownMenuItem<String>(
//                         value: jurusan,
//                         child: Text(
//                           jurusan,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(fontSize: 14),
//                         ),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         _selectedJurusan = newValue;
//                         // Reset prodi ketika jurusan berubah
//                         _selectedProdi = null;
//                         _notifyDataChanged();
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Prodi yang Dipilih - Dropdown (hanya tampil jika jurusan sudah dipilih)
//               if (_selectedJurusan != null) ...[
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Prodi yang Dipilih",
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     DropdownButtonFormField<String>(
//                       value: _selectedProdi,
//                       isExpanded: true,
//                       style: const TextStyle(fontSize: 14, color: Colors.black),
//                       decoration: InputDecoration(
//                         hintText: "Pilih program studi",
//                         hintStyle: const TextStyle(
//                           color: Colors.grey,
//                           fontSize: 14,
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                         contentPadding: const EdgeInsets.symmetric(
//                           vertical: 14,
//                           horizontal: 12,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.grey.shade300),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.grey.shade300),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(
//                             color: Color(0xFF4F6C7A),
//                           ),
//                         ),
//                       ),
//                       items:
//                           _getProdiList(_selectedJurusan).map((String prodi) {
//                         return DropdownMenuItem<String>(
//                           value: prodi,
//                           child: Text(
//                             prodi,
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 2,
//                             style: const TextStyle(fontSize: 14),
//                           ),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedProdi = newValue;
//                           _notifyDataChanged();
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _inputField(
//     String label,
//     String hint, {
//     int maxLines = 1,
//     TextEditingController? controller,
//     TextInputType? keyboardType,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           maxLines: maxLines,
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//             filled: true,
//             fillColor: Colors.white,
//             contentPadding: const EdgeInsets.symmetric(
//               vertical: 14,
//               horizontal: 12,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Color(0xFF4F6C7A)),
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }
// lib/pages/formulir/data_akademik_page.dart
import 'package:SPMB/models/jurusanModel.dart';
import 'package:SPMB/models/prodiModel.dart';
import 'package:SPMB/services/jurusanProdiService.dart';
import 'package:flutter/material.dart';
// import '../../models/jurusan_model.dart';
// import '../../models/prodi_model.dart';
// import '../../services/jurusan_prodi_service.dart';

class DataAkademikPage extends StatefulWidget {
  final Map<String, dynamic>? savedData;
  final Function(Map<String, dynamic>) onDataChanged;

  const DataAkademikPage({
    super.key,
    this.savedData,
    required this.onDataChanged,
  });

  @override
  State<DataAkademikPage> createState() => _DataAkademikPageState();
}

class _DataAkademikPageState extends State<DataAkademikPage> {
  String? _selectedTahunLulus;
  Jurusan? _selectedJurusan;
  Prodi? _selectedProdi;

  List<Jurusan> _jurusanList = [];
  List<Prodi> _prodiList = [];

  bool _isLoadingJurusan = false;
  bool _isLoadingProdi = false;

  // TextEditingController untuk setiap field
  final TextEditingController _asalSekolahController = TextEditingController();
  final TextEditingController _nilaiRataController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setupTextFieldListeners();
    _loadJurusan();

    // Restore saved data
    if (widget.savedData != null) {
      _restoreSavedData();
    }
  }

  void _restoreSavedData() {
    _asalSekolahController.text = widget.savedData?['asalSekolah'] ?? '';
    _selectedTahunLulus = widget.savedData?['tahunLulus'];
    _nilaiRataController.text = widget.savedData?['nilaiRata'] ?? '';

    // Restore jurusan
    if (widget.savedData?['jurusan'] != null) {
      final savedJurusan = widget.savedData!['jurusan'];
      if (savedJurusan is Map<String, dynamic>) {
        _selectedJurusan = Jurusan.fromJson(savedJurusan);
        _loadProdi(_selectedJurusan!.idJurusan);
      }
    }

    // Restore prodi
    if (widget.savedData?['prodi'] != null) {
      final savedProdi = widget.savedData!['prodi'];
      if (savedProdi is Map<String, dynamic>) {
        _selectedProdi = Prodi.fromJson(savedProdi);
      }
    }
  }

  Future<void> _loadJurusan() async {
    setState(() {
      _isLoadingJurusan = true;
    });

    try {
      final jurusanList = await JurusanProdiService.getAllJurusan();
      setState(() {
        _jurusanList = jurusanList;
        _isLoadingJurusan = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingJurusan = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memuat data jurusan: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _loadProdi(int idJurusan) async {
    setState(() {
      _isLoadingProdi = true;
      _prodiList = [];
      _selectedProdi = null;
    });

    try {
      final prodiList = await JurusanProdiService.getProdiByJurusan(idJurusan);
      setState(() {
        _prodiList = prodiList;
        _isLoadingProdi = false;
      });
      _notifyDataChanged();
    } catch (e) {
      setState(() {
        _isLoadingProdi = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memuat data prodi: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _notifyDataChanged() {
    Map<String, dynamic> data = {
      'asalSekolah': _asalSekolahController.text,
      'tahunLulus': _selectedTahunLulus,
      'nilaiRata': _nilaiRataController.text,
      'jurusan': _selectedJurusan != null
          ? {
              'id_jurusan': _selectedJurusan!.idJurusan,
              'nama_jurusan': _selectedJurusan!.namaJurusan,
            }
          : null,
      'prodi': _selectedProdi != null
          ? {
              'id_prodi': _selectedProdi!.idProdi,
              'nama_prodi': _selectedProdi!.namaProdi,
            }
          : null,
    };

    widget.onDataChanged(data);
  }

  void _setupTextFieldListeners() {
    _asalSekolahController.addListener(_notifyDataChanged);
    _nilaiRataController.addListener(_notifyDataChanged);
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
                  Icon(Icons.school, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    "Data Akademik",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedTahunLulus,
                    isExpanded: true,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
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
                        borderSide: const BorderSide(color: Color(0xFF4F6C7A)),
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
                    const TextInputType.numberWithOptions(decimal: true),
              ),

              // Jurusan yang Dipilih - Dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Jurusan yang Dipilih",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  _isLoadingJurusan
                      ? Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : DropdownButtonFormField<Jurusan>(
                          value: _selectedJurusan,
                          isExpanded: true,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
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
                              borderSide:
                                  const BorderSide(color: Color(0xFF4F6C7A)),
                            ),
                          ),
                          items: _jurusanList.map((Jurusan jurusan) {
                            return DropdownMenuItem<Jurusan>(
                              value: jurusan,
                              child: Text(
                                jurusan.namaJurusan,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (Jurusan? newValue) {
                            setState(() {
                              _selectedJurusan = newValue;
                              _selectedProdi = null;
                            });

                            if (newValue != null) {
                              _loadProdi(newValue.idJurusan);
                            } else {
                              _notifyDataChanged();
                            }
                          },
                        ),
                ],
              ),
              const SizedBox(height: 16),

              // Prodi yang Dipilih - Dropdown (hanya tampil jika jurusan sudah dipilih)
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
                    _isLoadingProdi
                        ? Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          )
                        : DropdownButtonFormField<Prodi>(
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
                            items: _prodiList.map((Prodi prodi) {
                              return DropdownMenuItem<Prodi>(
                                value: prodi,
                                child: Text(
                                  prodi.namaProdi,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (Prodi? newValue) {
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
