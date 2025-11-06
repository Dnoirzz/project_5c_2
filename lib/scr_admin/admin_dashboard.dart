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

  Map<String, dynamic>? dashboardData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }

  Future<void> _fetchDashboardData() async {
    try {
      final data = await AdminDashboardService.fetchDashboardData(); // ✅ correct
      setState(() {
        dashboardData = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching dashboard: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // ✅ Match JSON keys from your PHP output
    final totalMahasiswa = dashboardData?['total_mahasiswa'] ?? 0;
    final totalUser = dashboardData?['total_user'] ?? 0;
    final pendingList = dashboardData?['pending_verifikasi'] ?? [];
    final mahasiswaList = dashboardData?['data_mahasiswa_user'] ?? [];

    // ✅ Example pie chart: verified vs pending
    final verifiedCount = mahasiswaList
        .where((m) => m['status_verifikasi'] == 'Sudah')
        .length;
    final pendingCount = mahasiswaList
        .where((m) => m['status_verifikasi'] == 'Belum')
        .length;

    final chartData = [
      {
        'label': 'Terverifikasi',
        'value': verifiedCount.toDouble(),
        'color': '0xFF4CAF50'
      },
      {
        'label': 'Belum Verifikasi',
        'value': pendingCount.toDouble(),
        'color': '0xFFF44336'
      },
    ];

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
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
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
                    text: "${pendingList.length} Mahasiswa ",
                    style: const TextStyle(
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: "yang Belum ",
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

            // ✅ Info Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _infoCard(Icons.people, "Total Mahasiswa",
                      totalMahasiswa.toString()),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _infoCard(
                      Icons.admin_panel_settings, "Total User", totalUser.toString()),
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
                    "Status Verifikasi Mahasiswa",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: chartData.map<PieChartSectionData>((d) {
                          return PieChartSectionData(
                            color: Color(int.parse(d['color'])),
                            value: d['value'],
                            title: '${d['value']}',
                            radius: 60,
                            titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildLegendFromData(chartData),
                  const SizedBox(height: 12),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AdminPengumumanPage()),
                        );
                      },
                      icon: const Icon(Icons.campaign, color: Colors.white),
                      label: const Text('Kelola Pengumuman'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Daftar Mahasiswa Belum Terverifikasi",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // ✅ Table from pending_verifikasi list
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.white10),
                columns: const [
                  DataColumn(
                      label: Text('Nama',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Status',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                ],
                rows: pendingList.map<DataRow>((student) {
                  return DataRow(cells: [
                    DataCell(Text(student['nama_lengkap'] ?? '-',
                        style: const TextStyle(color: Colors.white70))),
                    DataCell(Text(student['status_verifikasi'] ?? '-',
                        style: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold))),
                  ]);
                }).toList(),
              ),
            ),
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

  Widget _buildLegendFromData(List<dynamic> chartData) {
    return Column(
      children: chartData.map<Widget>((d) {
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
              Text(d['label'],
                  style: const TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
