import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Ketentuan Pengguna',
        showBackButton: true,
        showProfileMenu: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF233746), // Sama dengan app bar
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ketentuan Penggunaan Aplikasi',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Sistem Penerimaan Mahasiswa Baru (PMB)',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Content sections
              _buildSection(
                '1. Penerimaan Ketentuan',
                'Dengan menggunakan Aplikasi Sistem Penerimaan Mahasiswa Baru (PMB), Anda dianggap telah membaca, memahami, dan menyetujui seluruh ketentuan yang berlaku di dalam aplikasi ini. Jika Anda tidak setuju dengan sebagian atau seluruh ketentuan, disarankan untuk tidak menggunakan aplikasi. Penggunaan aplikasi menandakan bahwa Anda menerima semua syarat dan ketentuan yang telah ditetapkan oleh pengelola.',
              ),

              _buildSection(
                '2. Tujuan Penggunaan',
                'Aplikasi ini dibuat dengan tujuan untuk mempermudah proses pendaftaran, seleksi, dan pengumuman hasil penerimaan mahasiswa baru di lingkungan kampus. Penggunaan aplikasi ini hanya diperbolehkan untuk keperluan akademik dan administrasi yang sah serta tidak boleh digunakan untuk tindakan yang melanggar hukum, merugikan pihak lain, atau bertentangan dengan peraturan perundang-undangan yang berlaku.',
              ),

              _buildSection(
                '3. Hak dan Kewajiban Pengguna',
                'Setiap pengguna wajib memberikan data yang benar, lengkap, dan akurat saat melakukan pendaftaran. Pengguna bertanggung jawab penuh atas keamanan akun miliknya, termasuk menjaga kerahasiaan kata sandi dan informasi pribadi. Pengguna tidak diperbolehkan menggunakan aplikasi untuk tujuan penipuan, peretasan, penyebaran data palsu, atau aktivitas yang dapat merugikan pihak kampus maupun pihak lain. Pengguna juga berhak memperoleh informasi yang transparan terkait status pendaftaran dan hasil seleksi melalui aplikasi.',
              ),

              _buildSection(
                '4. Pengumpulan dan Penggunaan Data',
                'Data pribadi yang Anda berikan selama menggunakan aplikasi ini akan digunakan hanya untuk kepentingan administrasi penerimaan mahasiswa baru. Pengelola aplikasi berkomitmen untuk menjaga keamanan dan kerahasiaan data pengguna sesuai dengan Kebijakan Privasi yang berlaku. Data tidak akan dibagikan kepada pihak ketiga tanpa persetujuan pengguna, kecuali jika diwajibkan oleh hukum.',
              ),

              _buildSection(
                '5. Tanggung Jawab Pengelola',
                'Pengelola aplikasi berhak melakukan pembaruan, perbaikan, atau penghentian sementara layanan aplikasi demi meningkatkan kualitas sistem. Pengelola tidak bertanggung jawab atas kerugian atau gangguan yang timbul akibat kesalahan pengguna, gangguan teknis, atau faktor di luar kendali sistem. Jika ditemukan penyalahgunaan atau data palsu, pengelola berhak menolak atau membatalkan pendaftaran pengguna yang bersangkutan.',
              ),

              _buildSection(
                '6. Perubahan Ketentuan',
                'Ketentuan penggunaan ini dapat diubah atau diperbarui sewaktu-waktu tanpa pemberitahuan sebelumnya. Setiap pembaruan akan diumumkan melalui halaman resmi aplikasi. Pengguna diharapkan memeriksa halaman ini secara berkala untuk mengetahui perubahan terbaru.',
              ),

              _buildSection(
                '7. Hukum yang Berlaku',
                'Seluruh ketentuan dalam aplikasi ini diatur berdasarkan hukum yang berlaku di Republik Indonesia. Apabila terjadi perselisihan, penyelesaiannya akan dilakukan terlebih dahulu melalui musyawarah untuk mencapai mufakat. Jika tidak tercapai, maka penyelesaian dilakukan sesuai dengan ketentuan hukum yang berlaku.',
              ),

              _buildContactSection(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF233746),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFA3ADB5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '8. Kontak dan Dukungan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF233746),
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Untuk pertanyaan, keluhan, atau saran terkait penggunaan aplikasi ini, pengguna dapat menghubungi pihak pengelola melalui:',
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Color(0xFF233746),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.email, color: Color(0xFF233746), size: 20),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  'helpdesk.pmb@kampus.ac.id',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF233746),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.phone, color: Color(0xFF233746), size: 20),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  '+62 812 3456 7890',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF233746),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
