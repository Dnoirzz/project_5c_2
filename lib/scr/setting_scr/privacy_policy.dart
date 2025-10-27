import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Kebijakan Privasi',
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
                      'Kebijakan Privasi',
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
                    SizedBox(height: 12),
                    // Use Wrap instead of Row to prevent overflow
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calendar_today,
                                color: Colors.white70, size: 16),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'Tanggal Berlaku: 5 Oktober 2025',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.info_outline,
                                color: Colors.white70, size: 16),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'Versi: 20251005V1',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Content sections
              _buildSection(
                'Pendahuluan',
                'PT EduTek Nusantara (selanjutnya disebut "Kami", "Aplikasi", atau "Sistem Penerimaan Mahasiswa Baru") berkomitmen untuk melindungi privasi dan keamanan data pribadi pengguna. Dokumen Kebijakan Privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, menyimpan, dan melindungi informasi pribadi Anda saat menggunakan layanan kami. Kami menghormati hak privasi Anda dan memastikan setiap data pribadi yang diberikan akan diproses sesuai dengan peraturan perundang-undangan yang berlaku di Indonesia, termasuk Undang-Undang Nomor 27 Tahun 2022 tentang Perlindungan Data Pribadi (UU PDP). Dengan menggunakan aplikasi ini, Anda dianggap telah membaca, memahami, dan menyetujui seluruh isi kebijakan ini. Jika Anda tidak menyetujui kebijakan ini, mohon untuk tidak menggunakan layanan kami.',
              ),

              _buildSection(
                'Data yang Dikumpulkan',
                'Kami mengumpulkan data pribadi untuk keperluan pendaftaran mahasiswa baru, pengelolaan akun, serta peningkatan layanan. Data yang dikumpulkan meliputi nama lengkap, NIK, NISN, tanggal lahir, jenis kelamin, alamat, email, nomor telepon, nilai rapor, ijazah, foto diri, serta dokumen pendukung lainnya. Selain itu, kami juga dapat mengumpulkan data otomatis seperti alamat IP perangkat, jenis perangkat, sistem operasi, log aktivitas, waktu akses, serta informasi penggunaan aplikasi. Kami mungkin juga meminta data tambahan seperti hasil survei kepuasan atau umpan balik dari pengguna guna meningkatkan kualitas layanan.',
              ),

              _buildSection(
                'Penggunaan Data',
                'Informasi yang dikumpulkan akan digunakan untuk memproses pendaftaran mahasiswa baru, melakukan verifikasi data, mengelola akun pengguna, memberikan notifikasi hasil seleksi, serta menyediakan layanan bantuan dan tanggapan terhadap pertanyaan Anda. Kami juga menggunakan data tersebut untuk mengembangkan, memelihara, dan meningkatkan fitur aplikasi agar pengalaman pengguna semakin baik. Selain itu, kami dapat menggunakan data untuk memenuhi kewajiban hukum atau permintaan dari instansi resmi apabila diperlukan.',
              ),

              _buildSection(
                'Keamanan Data',
                'Kami menerapkan langkah-langkah keamanan administratif, teknis, dan fisik untuk melindungi data pribadi dari akses tidak sah, kehilangan, atau penyalahgunaan. Data disimpan pada server yang aman dengan akses terbatas dan dilindungi melalui proses enkripsi. Informasi pribadi hanya disimpan selama diperlukan untuk tujuan administratif atau sesuai dengan ketentuan hukum. Jika terjadi pelanggaran data, kami akan segera memberitahu pengguna dan otoritas yang berwenang sesuai ketentuan peraturan perundang-undangan.',
              ),

              _buildSection(
                'Berbagi Data',
                'Kami tidak akan menjual atau menyewakan data pribadi Anda kepada pihak ketiga. Namun, data dapat dibagikan kepada instansi pendidikan atau pemerintah untuk keperluan verifikasi pendaftaran, penyedia layanan teknologi yang membantu pengelolaan sistem dan keamanan data, serta penegak hukum apabila diwajibkan oleh hukum. Setiap pihak penerima data wajib mematuhi ketentuan kerahasiaan dan perlindungan data sesuai peraturan yang berlaku.',
              ),

              _buildSection(
                'Hak Pengguna',
                'Pengguna memiliki hak untuk mengakses, memperbarui, dan menghapus data pribadinya. Anda juga berhak menarik persetujuan atas pemrosesan data dengan konsekuensi tidak dapat menggunakan sebagian layanan aplikasi. Permintaan terkait dapat dikirimkan melalui email ke privacy@penerimaanmahasiswa.id.',
              ),

              _buildSection(
                'Cookie dan Anak di Bawah Umur',
                'Aplikasi ini tidak menggunakan cookie kecuali untuk keperluan autentikasi dan keamanan sesi pengguna, serta tidak melacak aktivitas pribadi di luar penggunaan aplikasi. Kami juga tidak secara sengaja mengumpulkan data dari anak di bawah umur 17 tahun tanpa izin orang tua atau wali. Jika kami mengetahui adanya data anak yang dikumpulkan tanpa izin, maka data tersebut akan segera dihapus.',
              ),

              _buildSection(
                'Perubahan Kebijakan',
                'Kebijakan Privasi ini dapat diperbarui sewaktu-waktu. Perubahan akan diumumkan melalui notifikasi dalam aplikasi atau situs web resmi. Tanggal "Berlaku Efektif" di bagian atas menunjukkan waktu terakhir kebijakan ini diperbarui. Jika Anda terus menggunakan aplikasi setelah adanya pembaruan, berarti Anda menyetujui perubahan tersebut.',
              ),

              _buildContactSection(),

              _buildFooterSection(),

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
            'Kontak dan Dukungan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF233746),
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Apabila Anda memiliki pertanyaan, keluhan, atau permintaan terkait kebijakan ini, silakan hubungi kami melalui:',
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
                  'privacy@penerimaanmahasiswa.id',
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
              Icon(Icons.web, color: Color(0xFF233746), size: 20),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  'www.penerimaanmahasiswa.id',
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
                  '(021) 555-1234',
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

  Widget _buildFooterSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hak Cipta',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Seluruh isi aplikasi dan kebijakan ini dilindungi oleh hukum Republik Indonesia. Hak cipta © 2025 Sistem Penerimaan Mahasiswa Baru. Semua hak dilindungi.',
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.black87,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
