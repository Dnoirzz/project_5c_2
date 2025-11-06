// import 'package:SPMB/models/dataPribadi_models.dart';
import 'package:SPMB/scr_admin/management_form.dart';
import 'package:SPMB/services/dashboard_admin_service.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../scr_admin/widgets/sidebar.dart';
import '../scr_admin/pengumuman/admin_pengumuman_page.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int totalLaki = 0;
  int totalPerempuan = 0;
  int totalMahasiswa = 0;
  int totalVerified = 0;
  int totalPending = 0;
  List<dynamic> mahasiswaList = [];
  bool isLoading = true;
  String? errorMessage;
  String adminNama = "Admin";
  List<dynamic> jurusanist = [];
  void initState() {
    super.initState();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    final data = await DashboardService.getDashboardStats('admin@example.com');
    setState(() {
      isLoading = true;
      errorMessage = null;
      adminNama = data['admin_nama'] ?? 'Admin';
    });

    try {
      print(' Loading dashboard data...');
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('email') ?? '';
      final data = await DashboardService.getDashboardStats(email);
      print(' Processing data...');
      // Parse statistik dengan null safety
      final stats = data['statistik'];
      if (stats == null) {
        throw Exception('Data statistik tidak ditemukan');
      }

      setState(() {
        adminNama =
            data['admin_nama'] ?? 'Admin'; // Konversi ke int dengan aman
        totalMahasiswa =
            int.tryParse(stats['total_mahasiswa']?.toString() ?? '0') ?? 0;
        totalLaki = int.tryParse(stats['total_laki']?.toString() ?? '0') ?? 0;
        totalPerempuan =
            int.tryParse(stats['total_perempuan']?.toString() ?? '0') ?? 0;
        totalPending =
            int.tryParse(stats['total_belum_verif']?.toString() ?? '0') ?? 0;
        totalVerified =
            int.tryParse(stats['total_terverifikasi']?.toString() ?? '0') ?? 0;

        // Parse list mahasiswa
        mahasiswaList = (data['belum_verifikasi'] as List?) ?? [];

        isLoading = false;
        print('Dashboard loaded successfully');
        print(
            'Stats: Total=$totalMahasiswa, Laki=$totalLaki, Perempuan=$totalPerempuan');
      });
    } catch (e) {
      print(' Load error: $e');
      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: loadDashboardData,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF364A63),
      appBar: AppBar(
        backgroundColor: const Color(0xFF36566F),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu, color: Colors.white),
        ),
        title: const Text(
          'DASHBOARD',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: loadDashboardData,
            icon: const Icon(Icons.refresh, color: Colors.white),
            tooltip: 'Refresh',
          ),
        ],
      ),
      drawer: Sidebar(
        userName: adminNama,
        currentPage: 'Dashboard',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Good Morning, Sarah",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Kamu Mempunyai ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  TextSpan(
                    text: "$totalPending Daftar Mahasiswa ",
                    style: const TextStyle(
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: "yang Belum di ",
                    style: TextStyle(color: Colors.white),
                  ),
                  const TextSpan(
                    text: "Terverifikasi",
                    style: TextStyle(
                        color: Colors.lightGreenAccent,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white12,
                hintText: 'Search Here ....',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _infoCard(
                      Icons.male, "Total Mhs Laki - Laki", "$totalLaki"),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _infoCard(
                      Icons.female, "Total Mhs Perempuan", "$totalPerempuan"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child:
                      _infoCard(Icons.people, "Total Mhs", "$totalMahasiswa"),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _infoCard(
                      Icons.verified, "Terverifikasi", "$totalVerified"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Distribusi Mahasiswa per Jurusan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child:
                        // PieChart(
                        //   PieChartData(
                        //     sectionsSpace: 2,
                        //     centerSpaceRadius: 40,
                        //     sections: [
                        //       PieChartSectionData(
                        //         color: Colors.redAccent,
                        //         value: 40,
                        //         title: '40%',
                        //         radius: 60,
                        //         titleStyle: const TextStyle(
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //       PieChartSectionData(
                        //         color: Colors.greenAccent,
                        //         value: 30,
                        //         title: '30%',
                        //         radius: 60,
                        //         titleStyle: const TextStyle(
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //       PieChartSectionData(
                        //         color: Colors.blueAccent,
                        //         value: 20,
                        //         title: '20%',
                        //         radius: 60,
                        //         titleStyle: const TextStyle(
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //       PieChartSectionData(
                        //         color: Colors.orangeAccent,
                        //         value: 10,
                        //         title: '10%',
                        //         radius: 60,
                        //         titleStyle: const TextStyle(
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        PieChart(
                      PieChartData(
                        sectionsSpace: 3,
                        centerSpaceRadius: 40,
                        sections: jurusanist.map((item) {
                          final jumlah =
                              int.tryParse(item['jumlah'].toString()) ?? 0;
                          final nama = item['nama_jurusan'].toString();
                          return PieChartSectionData(
                            value: jumlah.toDouble(),
                            title: nama,
                            radius: 60,
                            titleStyle: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildLegend(),
                  const SizedBox(height: 12),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       // Navigate to full chart page
                  //     },
                  //     child: const Text(
                  //       "View All",
                  //       style: TextStyle(
                  //         color: Colors.lightBlueAccent,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  // Tombol menuju halaman pengumuman
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminPengumumanPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.campaign, color: Colors.white),
                      label: const Text('Kelola Pengumuman'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Daftar Mahasiswa Belum Terverifikasi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FormManagementPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // const Text(
            //   sudo
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 16,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: GestureDetector(
            //     onTap: () {
            //       // Navigate to full chart page
            //     },
            //     child: const Text(
            //       "View All",
            //       style: TextStyle(
            //         color: Colors.lightBlueAccent,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 12),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.white12,
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: DataTable(
            //       headingRowColor: WidgetStateProperty.all(Colors.white10),
            //       columnSpacing: 20,
            //       horizontalMargin: 16,
            //       columns: const [
            //         DataColumn(
            //             label: Text('Nama',
            //                 style: TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold))),
            //         DataColumn(
            //             label: Text('Jurusan',
            //                 style: TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold))),
            //         DataColumn(
            //             label: Text('Prodi',
            //                 style: TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold))),
            //         DataColumn(
            //             label: Text('Status',
            //                 style: TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold))),
            //       ],
            //       rows: List.generate(5, (index) {
            //         return const DataRow(cells: [
            //           DataCell(Text('Sari Putriani',
            //               style: TextStyle(color: Colors.white70))),
            //           DataCell(Text('Teknik Elektro',
            //               style: TextStyle(color: Colors.white70))),
            //           DataCell(Text('D3 Teknik Informatika',
            //               style: TextStyle(color: Colors.white70))),
            //           DataCell(Text('Belum Terverifikasi',
            //               style: TextStyle(
            //                   color: Colors.redAccent,
            //                   fontWeight: FontWeight.bold))),
            //         ]);
            //       }),
            //     ),
            //   ),
            // ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(Colors.white10),
                  columnSpacing: 20,
                  horizontalMargin: 16,
                  columns: const [
                    DataColumn(
                        label: Text('Nama',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Jurusan',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Prodi',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Status',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  ],
                  rows: mahasiswaList.isEmpty
                      ? [
                          const DataRow(cells: [
                            DataCell(Text('Tidak ada data',
                                style: TextStyle(color: Colors.white70))),
                            DataCell(Text('-',
                                style: TextStyle(color: Colors.white70))),
                            DataCell(Text('-',
                                style: TextStyle(color: Colors.white70))),
                            DataCell(Text('-',
                                style: TextStyle(color: Colors.white70))),
                          ])
                        ]
                      : mahasiswaList.map((mhs) {
                          return DataRow(cells: [
                            DataCell(Text(
                                mhs['nama_lengkap']?.toString() ?? '-',
                                style: const TextStyle(color: Colors.white70))),
                            DataCell(Text(
                                mhs['nama_jurusan']?.toString() ?? '-',
                                style: const TextStyle(color: Colors.white70))),
                            DataCell(Text(mhs['nama_prodi']?.toString() ?? '-',
                                style: const TextStyle(color: Colors.white70))),
                            DataCell(Text(
                                mhs['status_verifikasi']?.toString() ??
                                    'Belum Terverifikasi',
                                style: const TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold))),
                          ]);
                        }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white70, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Column(
      children: [
        _legendItem(Colors.redAccent, 'Teknik Informatika'),
        const SizedBox(height: 8),
        _legendItem(Colors.greenAccent, 'Teknik Elektro'),
        const SizedBox(height: 8),
        _legendItem(Colors.blueAccent, 'Teknik Mesin'),
        const SizedBox(height: 8),
        _legendItem(Colors.orangeAccent, 'Lainnya'),
      ],
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}

// import 'package:SPMB/scr_admin/management_form.dart';
// import 'package:SPMB/scr_admin/pengumuman/admin_pengumuman_page.dart';
// import 'package:SPMB/services/dashboard_admin_service.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// // Dashboard Service

// class AdminDashboard extends StatefulWidget {
//   const AdminDashboard({super.key});

//   @override
//   State<AdminDashboard> createState() => _AdminDashboardState();
// }

// class _AdminDashboardState extends State<AdminDashboard> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   // Data variables
//   int totalLaki = 0;
//   int totalPerempuan = 0;
//   int totalMahasiswa = 0;
//   int totalVerified = 0;
//   int totalPending = 0;
//   List<dynamic> mahasiswaList = [];
//   bool isLoading = true;
//   String? errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     loadDashboardData();
//   }

//   Future<void> loadDashboardData() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });

//     try {
//       print('📱 Loading dashboard data...');
//       final data = await DashboardService.getDashboardStats();

//       print('📊 Processing data...');
//       // Parse statistik dengan null safety
//       final stats = data['statistik'];
//       if (stats == null) {
//         throw Exception('Data statistik tidak ditemukan');
//       }

//       setState(() {
//         // Konversi ke int dengan aman
//         totalMahasiswa =
//             int.tryParse(stats['total_mahasiswa']?.toString() ?? '0') ?? 0;
//         totalLaki = int.tryParse(stats['total_laki']?.toString() ?? '0') ?? 0;
//         totalPerempuan =
//             int.tryParse(stats['total_perempuan']?.toString() ?? '0') ?? 0;
//         totalPending =
//             int.tryParse(stats['total_belum_verif']?.toString() ?? '0') ?? 0;
//         totalVerified =
//             int.tryParse(stats['total_terverifikasi']?.toString() ?? '0') ?? 0;

//         // Parse list mahasiswa
//         mahasiswaList = (data['belum_verifikasi'] as List?) ?? [];

//         isLoading = false;
//         print('✅ Dashboard loaded successfully');
//         print(
//             '📈 Stats: Total=$totalMahasiswa, Laki=$totalLaki, Perempuan=$totalPerempuan');
//       });
//     } catch (e) {
//       print('❌ Load error: $e');
//       setState(() {
//         isLoading = false;
//         errorMessage = e.toString();
//       });

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error: $e'),
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 5),
//             action: SnackBarAction(
//               label: 'Retry',
//               textColor: Colors.white,
//               onPressed: loadDashboardData,
//             ),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: const Color(0xFF364A63),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF36566F),
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             _scaffoldKey.currentState?.openDrawer();
//           },
//           icon: const Icon(Icons.menu, color: Colors.white),
//         ),
//         title: const Text(
//           'DASHBOARD',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1.2,
//           ),
//         ),
//         centerTitle: false,
//         actions: [
//           IconButton(
//             onPressed: loadDashboardData,
//             icon: const Icon(Icons.refresh, color: Colors.white),
//             tooltip: 'Refresh',
//           ),
// //         ],
//       ),
//       // Uncomment jika sudah ada Sidebar
//       // drawer: const Sidebar(
//       //   userName: 'Sarah Elexandare',
//       //   currentPage: 'Dashboard',
//       // ),
//       body: isLoading
//           ? const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(color: Colors.white),
//                   SizedBox(height: 16),
//                   Text(
//                     'Loading data...',
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                 ],
//               ),
//             )
//           : RefreshIndicator(
//               onRefresh: loadDashboardData,
//               color: Colors.white,
//               backgroundColor: const Color(0xFF36566F),
//               child: SingleChildScrollView(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Good Morning, Sarah",
//                       style: TextStyle(color: Colors.white70, fontSize: 16),
//                     ),
//                     const SizedBox(height: 4),
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           const TextSpan(
//                             text: "Kamu Mempunyai ",
//                             style: TextStyle(color: Colors.white, fontSize: 16),
//                           ),
//                           TextSpan(
//                             text: "$totalPending Daftar Mahasiswa ",
//                             style: const TextStyle(
//                                 color: Colors.yellowAccent,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           const TextSpan(
//                             text: "yang Belum di ",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           const TextSpan(
//                             text: "Terverifikasi",
//                             style: TextStyle(
//                                 color: Colors.lightGreenAccent,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextField(
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white12,
//                         hintText: 'Search Here ....',
//                         hintStyle: const TextStyle(color: Colors.white54),
//                         prefixIcon:
//                             const Icon(Icons.search, color: Colors.white54),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: _infoCard(Icons.male, "Total Mhs Laki - Laki",
//                               "$totalLaki"),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: _infoCard(Icons.female, "Total Mhs Perempuan",
//                               "$totalPerempuan"),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: _infoCard(
//                               Icons.people, "Total Mhs", "$totalMahasiswa"),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: _infoCard(Icons.verified, "Terverifikasi",
//                               "$totalVerified"),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white12,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "Distribusi Mahasiswa per Jurusan",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           SizedBox(
//                             height: 200,
//                             child: PieChart(
//                               PieChartData(
//                                 sectionsSpace: 2,
//                                 centerSpaceRadius: 40,
//                                 sections: [
//                                   PieChartSectionData(
//                                     color: Colors.redAccent,
//                                     value: 40,
//                                     title: '40%',
//                                     radius: 60,
//                                     titleStyle: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   PieChartSectionData(
//                                     color: Colors.greenAccent,
//                                     value: 30,
//                                     title: '30%',
//                                     radius: 60,
//                                     titleStyle: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   PieChartSectionData(
//                                     color: Colors.blueAccent,
//                                     value: 20,
//                                     title: '20%',
//                                     radius: 60,
//                                     titleStyle: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   PieChartSectionData(
//                                     color: Colors.orangeAccent,
//                                     value: 10,
//                                     title: '10%',
//                                     radius: 60,
//                                     titleStyle: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           _buildLegend(),
//                           const SizedBox(height: 20),
//                           Center(
//                             child: ElevatedButton.icon(
//                               onPressed: () {
//                                 // Uncomment jika sudah ada AdminPengumumanPage
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => const AdminPengumumanPage(),
//                                   ),
//                                 );
//                               },
//                               icon: const Icon(Icons.campaign,
//                                   color: Colors.white),
//                               label: const Text('Kelola Pengumuman'),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.blueAccent,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 24, vertical: 14),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 textStyle: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Daftar Mahasiswa Belum Terverifikasi",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             // Uncomment jika sudah ada FormManagementPage
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => const FormManagementPage(),
//                               ),
//                             );
//                           },
//                           child: const Text(
//                             "View All",
//                             style: TextStyle(
//                               color: Colors.lightBlueAccent,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white12,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: DataTable(
//                           headingRowColor:
//                               WidgetStateProperty.all(Colors.white10),
//                           columnSpacing: 20,
//                           horizontalMargin: 16,
//                           columns: const [
//                             DataColumn(
//                                 label: Text('Nama',
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold))),
//                             DataColumn(
//                                 label: Text('Jurusan',
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold))),
//                             DataColumn(
//                                 label: Text('Prodi',
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold))),
//                             DataColumn(
//                                 label: Text('Status',
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold))),
//                           ],
//                           rows: mahasiswaList.isEmpty
//                               ? [
//                                   const DataRow(cells: [
//                                     DataCell(Text('Tidak ada data',
//                                         style:
//                                             TextStyle(color: Colors.white70))),
//                                     DataCell(Text('-',
//                                         style:
//                                             TextStyle(color: Colors.white70))),
//                                     DataCell(Text('-',
//                                         style:
//                                             TextStyle(color: Colors.white70))),
//                                     DataCell(Text('-',
//                                         style:
//                                             TextStyle(color: Colors.white70))),
//                                   ])
//                                 ]
//                               : mahasiswaList.map((mhs) {
//                                   return DataRow(cells: [
//                                     DataCell(Text(
//                                         mhs['nama_lengkap']?.toString() ?? '-',
//                                         style: const TextStyle(
//                                             color: Colors.white70))),
//                                     DataCell(Text(
//                                         mhs['nama_jurusan']?.toString() ?? '-',
//                                         style: const TextStyle(
//                                             color: Colors.white70))),
//                                     DataCell(Text(
//                                         mhs['nama_prodi']?.toString() ?? '-',
//                                         style: const TextStyle(
//                                             color: Colors.white70))),
//                                     DataCell(Text(
//                                         mhs['status_verifikasi']?.toString() ??
//                                             'Belum Terverifikasi',
//                                         style: const TextStyle(
//                                             color: Colors.redAccent,
//                                             fontWeight: FontWeight.bold))),
//                                   ]);
//                                 }).toList(),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   Widget _infoCard(IconData icon, String title, String value) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white12,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           Icon(icon, color: Colors.white70, size: 32),
//           const SizedBox(height: 8),
//           Text(
//             value,
//             style: const TextStyle(
//                 color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(color: Colors.white70, fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLegend() {
//     return Column(
//       children: [
//         _legendItem(Colors.redAccent, 'Teknik Informatika'),
//         const SizedBox(height: 8),
//         _legendItem(Colors.greenAccent, 'Teknik Elektro'),
//         const SizedBox(height: 8),
//         _legendItem(Colors.blueAccent, 'Teknik Mesin'),
//         const SizedBox(height: 8),
//         _legendItem(Colors.orangeAccent, 'Lainnya'),
//       ],
//     );
//   }

//   Widget _legendItem(Color color, String label) {
//     return Row(
//       children: [
//         Container(
//           width: 16,
//           height: 16,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           label,
//           style: const TextStyle(color: Colors.white70, fontSize: 14),
//         ),
//       ],
//     );
//   }
// }
