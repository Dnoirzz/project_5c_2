import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../widgets/appBar.dart';
import 'formulir_scr/formulir_main.dart';

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
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CustomAppBar(
        title: 'Dashboard',
        showMenuButton: true,
        showProfileMenu: true,
        currentPage: 'dashboard',
      ),
      drawer: const AppDrawer(currentPage: 'dashboard'),

      // ===================== BODY DASHBOARD =======================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profil Card
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
                            'Status: menunggu Verifikasi',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          formattedDate,
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
            const SizedBox(height: 24),

            // Progress Pendaftaran
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
      leading:
          completed
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
