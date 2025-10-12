import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // untuk grafik pie
import '../widgets/sidebar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF364A63),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'DASHBOARD',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: false,
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
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Kamu Mempunyai ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  TextSpan(
                    text: "20 Daftar Mahasiswa ",
                    style: TextStyle(
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: "yang Belum di ",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextSpan(
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
                _infoCard(Icons.male, "Total Mhs Laki - Laki", "20"),
                _infoCard(Icons.female, "Total Mhs Perempuan", "20"),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _infoCard(Icons.people, "Total Mhs", "100", width: 150),
                const SizedBox(width: 16),
                _infoCard(Icons.verified, "Terverifikasi", "20", width: 150),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 180,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 30,
                        sections: [
                          PieChartSectionData(
                            color: Colors.redAccent,
                            value: 40,
                            title: 'Teknik Informatika',
                            radius: 50,
                          ),
                          PieChartSectionData(
                            color: Colors.greenAccent,
                            value: 30,
                            title: 'Teknik Elektro',
                            radius: 50,
                          ),
                          PieChartSectionData(
                            color: Colors.blueAccent,
                            value: 20,
                            title: 'Teknik Mesin',
                            radius: 50,
                          ),
                          PieChartSectionData(
                            color: Colors.orangeAccent,
                            value: 10,
                            title: 'Lainnya',
                            radius: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.white10),
                columns: const [
                  DataColumn(label: Text('Nama', style: TextStyle(color: Colors.white))),
                  DataColumn(label: Text('Jurusan', style: TextStyle(color: Colors.white))),
                  DataColumn(label: Text('Prodi', style: TextStyle(color: Colors.white))),
                  DataColumn(label: Text('Status', style: TextStyle(color: Colors.white))),
                ],
                rows: List.generate(5, (index) {
                  return const DataRow(cells: [
                    DataCell(Text('Sari Putriani', style: TextStyle(color: Colors.white))),
                    DataCell(Text('Teknik Elektro', style: TextStyle(color: Colors.white))),
                    DataCell(Text('D3 Teknik Informatika', style: TextStyle(color: Colors.white))),
                    DataCell(Text('Belum Terverifikasi', style: TextStyle(color: Colors.redAccent))),
                  ]);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String value, {double width = 150}) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white70, size: 30),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
