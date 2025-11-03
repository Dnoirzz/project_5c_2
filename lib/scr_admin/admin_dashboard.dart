import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../scr_admin/widgets/sidebar.dart';
import '../scr_admin/pengumuman/admin_pengumuman_page.dart';
import '/services/admin_dashboard_services.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AdminDashboardService service = AdminDashboardService();
  final TextEditingController _searchController = TextEditingController();

  Map<String, dynamic>? dashboardData;
  List<dynamic> filteredStudents = [];
  List<dynamic> allStudents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (mounted) {
      setState(() {
        if (_searchController.text.isEmpty) {
          filteredStudents = dashboardData?['unverified'] ?? [];
        } else {
          final query = _searchController.text.toLowerCase();
          filteredStudents =
              (dashboardData?['unverified'] ?? []).where((student) {
            final nama =
                (student['nama_mahasiswa'] ?? '').toString().toLowerCase();
            final email = (student['email'] ?? '').toString().toLowerCase();
            final jurusan = (student['jurusan'] ?? '').toString().toLowerCase();
            final prodi = (student['prodi'] ?? '').toString().toLowerCase();

            return nama.contains(query) ||
                email.contains(query) ||
                jurusan.contains(query) ||
                prodi.contains(query);
          }).toList();
        }
      });
    }
  }

  Future<void> _fetchDashboardData() async {
    try {
      final data = await service.fetchDashboardData();
      if (mounted) {
        setState(() {
          dashboardData = data;
          allStudents = data['allStudents'] ?? [];
          filteredStudents = data['unverified'] ?? [];
          isLoading = false;
        });
        print('✅ Dashboard data loaded successfully');
      }
    } catch (e) {
      print('❌ Error fetching dashboard: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
          dashboardData = {
            "jumlahMahasiswa": 0,
            "lakiLakiCount": 0,
            "perempuanCount": 0,
            "jumlahTerverifikasi": 0,
            "jumlahBelumVerifikasi": 0,
            "unverified": [],
            "distribusiJurusan": [],
            "allStudents": [],
          };
          filteredStudents = [];
        });

        // Show error snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memuat data: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFF364A63),
        body: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    // ✅ Use Correct Key Names from Service with null safety
    if (dashboardData == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF364A63),
        body: const Center(
          child: Text(
            'Gagal memuat data dashboard',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final totalStudents = dashboardData!['jumlahMahasiswa'] ?? 0;
    final totalMale = dashboardData!['lakiLakiCount'] ?? 0;
    final totalFemale = dashboardData!['perempuanCount'] ?? 0;
    final verified = dashboardData!['jumlahTerverifikasi'] ?? 0;
    final unverifiedCount = dashboardData!['jumlahBelumVerifikasi'] ?? 0;

    // ✅ Use filtered list for display
    final unverifiedStudents = filteredStudents;

    // ✅ Ambil distribusi jurusan dari API
    final distribusiJurusan = dashboardData!['distribusiJurusan'] ?? [];

    // ✅ Chart Data - Gunakan data dari distribusiJurusan atau fallback ke gender
    final List<Map<String, dynamic>> distribution;

    if (distribusiJurusan.isNotEmpty) {
      // Gunakan distribusi per jurusan dengan warna berbeda
      final colors = [
        '0xFF42A5F5', // Blue
        '0xFFEF5350', // Red
        '0xFF66BB6A', // Green
        '0xFFFFCA28', // Yellow
        '0xFFAB47BC', // Purple
        '0xFFFF7043', // Orange
      ];

      distribution = List<Map<String, dynamic>>.generate(
        distribusiJurusan.length > 6 ? 6 : distribusiJurusan.length,
        (index) {
          final item = distribusiJurusan[index];
          return {
            'label': item['jurusan'] ?? 'Unknown',
            'value': (item['jumlah'] ?? 0).toDouble(),
            'color': colors[index % colors.length],
          };
        },
      );
    } else {
      // Fallback ke distribusi gender
      distribution = [
        {
          'label': 'Laki-Laki',
          'value': totalMale.toDouble(),
          'color': '0xFF42A5F5',
        },
        {
          'label': 'Perempuan',
          'value': totalFemale.toDouble(),
          'color': '0xFFEF5350',
        },
      ];
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF364A63),
      appBar: AppBar(
        backgroundColor: const Color(0xFF36566F),
        elevation: 0,
        leading: IconButton(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
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
        actions: [
          IconButton(
            onPressed: () {
              // Refresh data
              if (mounted) {
                setState(() {
                  isLoading = true;
                });
                _fetchDashboardData();
              }
            },
            icon: const Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),
      drawer: const Sidebar(
        userName: 'Sarah Elexandare',
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
                    text: "$unverifiedCount Daftar Mahasiswa ",
                    style: const TextStyle(
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text: "yang Belum di ",
                    style: TextStyle(color: Colors.white),
                  ),
                  const TextSpan(
                    text: "Terverifikasi",
                    style: TextStyle(
                      color: Colors.lightGreenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white12,
                hintText: 'Cari nama, email, jurusan, atau prodi...',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white54),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ✅ Cards Now Linked to Correct Values
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _infoCard(
                    Icons.male,
                    "Total Mhs Laki - Laki",
                    "$totalMale",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _infoCard(
                    Icons.female,
                    "Total Mhs Perempuan",
                    "$totalFemale",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _infoCard(Icons.people, "Total Mhs", "$totalStudents"),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _infoCard(
                    Icons.verified,
                    "Terverifikasi",
                    "$verified",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 📊 Chart Section
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
                  distribution.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Belum ada data distribusi',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 200,
                          child: PieChart(
                            PieChartData(
                              sectionsSpace: 2,
                              centerSpaceRadius: 40,
                              sections:
                                  distribution.map<PieChartSectionData>((d) {
                                return PieChartSectionData(
                                  color: Color(int.parse(d['color'])),
                                  value: d['value'],
                                  title: '${d['value'].toInt()}',
                                  radius: 60,
                                  titleStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                  const SizedBox(height: 16),
                  if (distribution.isNotEmpty)
                    _buildLegendFromData(distribution),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "View All",
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                          horizontal: 24,
                          vertical: 14,
                        ),
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
              children: [
                const Text(
                  "Daftar Mahasiswa Belum Terverifikasi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${unverifiedStudents.length} mahasiswa",
                  style: const TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ✅ Table Using Unverified Students List
            unverifiedStudents.isEmpty
                ? Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Tidak ada mahasiswa yang belum terverifikasi',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DataTable(
                        headingRowColor: MaterialStateProperty.all(
                          Colors.white10,
                        ),
                        columns: const [
                          DataColumn(
                            label: Text(
                              'Nama',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Jurusan',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Prodi',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Status',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        rows: unverifiedStudents.map<DataRow>((student) {
                          final nama = student['nama_mahasiswa'] ??
                              student['nama'] ??
                              student['nama_lengkap'] ??
                              '-';
                          final jurusan = student['jurusan'] ?? '-';
                          final prodi =
                              student['prodi'] ?? student['kode_prodi'] ?? '-';
                          final status = student['status_verifikasi'] ??
                              student['status'] ??
                              '-';

                          // Tentukan warna status
                          Color statusColor;
                          if (status
                              .toString()
                              .toLowerCase()
                              .contains('ditolak')) {
                            statusColor = Colors.redAccent;
                          } else if (status
                              .toString()
                              .toLowerCase()
                              .contains('lulus')) {
                            statusColor = Colors.greenAccent;
                          } else if (status
                              .toString()
                              .toLowerCase()
                              .contains('menunggu')) {
                            statusColor = Colors.yellowAccent;
                          } else {
                            statusColor = Colors.orangeAccent;
                          }

                          return DataRow(
                            // Tambahkan onTap untuk interaksi
                            onSelectChanged: (selected) {
                              if (selected == true) {
                                _showStudentDetailDialog(student);
                              }
                            },
                            cells: [
                              DataCell(
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      color: Colors.white54,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        nama.toString(),
                                        style: const TextStyle(
                                          color: Colors.white70,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              DataCell(
                                Text(
                                  jurusan.toString(),
                                  style: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  prodi.toString(),
                                  style: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: statusColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    status.toString(),
                                    style: TextStyle(
                                      color: statusColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  /// Dialog untuk menampilkan detail mahasiswa
  void _showStudentDetailDialog(Map<String, dynamic> student) {
    final nama = student['nama_mahasiswa'] ?? student['nama_lengkap'] ?? '-';
    final email = student['email'] ?? '-';
    final jurusan = student['jurusan'] ?? '-';
    final prodi = student['prodi'] ?? student['kode_prodi'] ?? '-';
    final status = student['status_verifikasi'] ?? '-';
    final idMahasiswa = student['id_mahasiswa'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF36566F),
        title: const Row(
          children: [
            Icon(Icons.person, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Detail Mahasiswa',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Nama', nama.toString()),
              const Divider(color: Colors.white24),
              _buildDetailRow('Email', email.toString()),
              const Divider(color: Colors.white24),
              _buildDetailRow('Jurusan', jurusan.toString()),
              const Divider(color: Colors.white24),
              _buildDetailRow('Program Studi', prodi.toString()),
              const Divider(color: Colors.white24),
              _buildDetailRow('Status', status.toString()),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline,
                        color: Colors.yellowAccent, size: 20),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Klik "Lihat Dokumen" untuk melihat detail dokumen mahasiswa',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Tutup',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Navigate to document verification page
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Navigasi ke halaman verifikasi dokumen mahasiswa ID: $idMahasiswa',
                  ),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            icon: const Icon(Icons.folder_open),
            label: const Text('Lihat Dokumen'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(
            ': ',
            style: TextStyle(color: Colors.white70),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
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
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
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

  Widget _buildLegendFromData(List<dynamic> distribution) {
    return Column(
      children: distribution.map<Widget>((d) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Color(int.parse(d['color'])),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                d['label'],
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
