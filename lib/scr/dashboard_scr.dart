import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../widgets/appBar.dart';
import 'formulir_scr/formulir_main.dart';
import 'pengumuman/pengumuman.dart'; // <-- tambahkan import ini
import 'pengumuman/detail_pengumuman.dart'; // <-- tambahkan import ini

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String formattedDate = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeDateFormatting();
  }

  Future<void> _initializeDateFormatting() async {
    await initializeDateFormatting('id_ID', null);
    setState(() {
      formattedDate = DateFormat(
        'EEEE, d MMMM yyyy',
        'id_ID',
      ).format(DateTime.now());
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CustomAppBar(
        title: 'Dashboard',
        showMenuButton: true,
        showProfileMenu: true,
        currentPage: 'dashboard',
      ),
      drawer: const AppDrawer(currentPage: 'dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF233746),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Aldi Mahendra',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'NIK: 1234567890123456',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Status: Lengkapi Verifikasi',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.calendar_today,
                                  size: 16, color: Colors.white70),
                              const SizedBox(width: 6),
                              Text(
                                formattedDate,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Progress Pendaftaran Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FormulirPendaftaranMain(),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.assignment_outlined),
                          SizedBox(width: 8),
                          Text(
                            'Progress Pendaftaran',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Progres kelengkapan formulir pendaftaran Anda',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                      const SizedBox(height: 12),

                      // Progress Bar
                      Stack(
                        children: [
                          Container(
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.75,
                            child: Container(
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text('75%', style: TextStyle(fontSize: 13)),
                      ),
                      const SizedBox(height: 16),

                      const ChecklistItem(
                        title: 'Data Pribadi',
                        completed: true,
                      ),
                      const ChecklistItem(
                        title: 'Data Akademik',
                        completed: true,
                      ),
                      const ChecklistItem(
                        title: 'Data Orang tua',
                        completed: true,
                      ),
                      const ChecklistItem(
                        title: 'Upload Dokumen',
                        completed: false,
                        number: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Pengumuman section
            _buildFloatingPengumuman(context),

            // Tambahkan padding bottom agar scroll tidak terpotong
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingPengumuman(BuildContext context) {
    final first = pengumumanList.isNotEmpty ? pengumumanList.first : null;
    final itemsToShow = pengumumanList.length >= 2
        ? pengumumanList.take(2).toList()
        : (first != null ? [first] : []);

    Widget buildItem(Map item) {
      final String judul = item['judul'] ?? '';
      final String deskripsi = item['deskripsi'] ?? '';
      final String tanggal = item['tanggal'] ?? ''; // jika data ada di list
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PengumumanDetailPage(item: item)),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(judul, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 14, color: Colors.black54),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      tanggal.isNotEmpty ? tanggal : (item['waktu'] ?? ''),
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                deskripsi,
                style: const TextStyle(color: Colors.black54, fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }

    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.announcement_outlined, color: Colors.black87),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Pengumuman',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PengumumanPage()),
                    );
                  },
                  child: const Text('View All', style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
            const Divider(height: 12),
            if (itemsToShow.isNotEmpty)
              ...itemsToShow.map((it) => buildItem(it)).toList()
            else
              const Text('Belum ada pengumuman',
                  style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}

// Checklist item widget
class ChecklistItem extends StatelessWidget {
  final String title;
  final bool completed;
  final int? number;

  const ChecklistItem({
    super.key,
    required this.title,
    required this.completed,
    this.number,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: completed
          ? const Icon(Icons.check_circle, color: Colors.green)
          : CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 12,
              child: Text(
                number?.toString() ?? '',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: completed ? Colors.black : Colors.black87,
        ),
      ),
    );
  }
}
