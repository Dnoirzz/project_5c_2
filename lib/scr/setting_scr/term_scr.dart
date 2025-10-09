import 'package:flutter/material.dart';
import '../../widgets/appBar.dart';

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
      body: const Center(
        child: Text('''
Ketentuan Penggunaan Aplikasi

1. Penerimaan Ketentuan
Dengan menggunakan Aplikasi Sistem Penerimaan Mahasiswa Baru (PMB), Anda dianggap telah membaca, memahami, dan menyetujui seluruh ketentuan yang berlaku di dalam aplikasi ini. Jika Anda tidak setuju dengan sebagian atau seluruh ketentuan, disarankan untuk tidak menggunakan aplikasi. Penggunaan aplikasi menandakan bahwa Anda menerima semua syarat dan ketentuan yang telah ditetapkan oleh pengelola.

2. Tujuan Penggunaan
Aplikasi ini dibuat dengan tujuan untuk mempermudah proses pendaftaran, seleksi, dan pengumuman hasil penerimaan mahasiswa baru di lingkungan kampus. Penggunaan aplikasi ini hanya diperbolehkan untuk keperluan akademik dan administrasi yang sah serta tidak boleh digunakan untuk tindakan yang melanggar hukum, merugikan pihak lain, atau bertentangan dengan peraturan perundang-undangan yang berlaku.

3. Hak dan Kewajiban Pengguna
Setiap pengguna wajib memberikan data yang benar, lengkap, dan akurat saat melakukan pendaftaran. Pengguna bertanggung jawab penuh atas keamanan akun miliknya, termasuk menjaga kerahasiaan kata sandi dan informasi pribadi. Pengguna tidak diperbolehkan menggunakan aplikasi untuk tujuan penipuan, peretasan, penyebaran data palsu, atau aktivitas yang dapat merugikan pihak kampus maupun pihak lain. Pengguna juga berhak memperoleh informasi yang transparan terkait status pendaftaran dan hasil seleksi melalui aplikasi.

4. Pengumpulan dan Penggunaan Data
Data pribadi yang Anda berikan selama menggunakan aplikasi ini akan digunakan hanya untuk kepentingan administrasi penerimaan mahasiswa baru. Pengelola aplikasi berkomitmen untuk menjaga keamanan dan kerahasiaan data pengguna sesuai dengan Kebijakan Privasi yang berlaku. Data tidak akan dibagikan kepada pihak ketiga tanpa persetujuan pengguna, kecuali jika diwajibkan oleh hukum.

5. Tanggung Jawab Pengelola
Pengelola aplikasi berhak melakukan pembaruan, perbaikan, atau penghentian sementara layanan aplikasi demi meningkatkan kualitas sistem. Pengelola tidak bertanggung jawab atas kerugian atau gangguan yang timbul akibat kesalahan pengguna, gangguan teknis, atau faktor di luar kendali sistem. Jika ditemukan penyalahgunaan atau data palsu, pengelola berhak menolak atau membatalkan pendaftaran pengguna yang bersangkutan.

6. Perubahan Ketentuan
Ketentuan penggunaan ini dapat diubah atau diperbarui sewaktu-waktu tanpa pemberitahuan sebelumnya. Setiap pembaruan akan diumumkan melalui halaman resmi aplikasi. Pengguna diharapkan memeriksa halaman ini secara berkala untuk mengetahui perubahan terbaru.

7. Hukum yang Berlaku
Seluruh ketentuan dalam aplikasi ini diatur berdasarkan hukum yang berlaku di Republik Indonesia. Apabila terjadi perselisihan, penyelesaiannya akan dilakukan terlebih dahulu melalui musyawarah untuk mencapai mufakat. Jika tidak tercapai, maka penyelesaian dilakukan sesuai dengan ketentuan hukum yang berlaku.

8. Kontak dan Dukungan
Untuk pertanyaan, keluhan, atau saran terkait penggunaan aplikasi ini, pengguna dapat menghubungi pihak pengelola melalui:
📧 Email: helpdesk.pmb@kampus.ac.id
📞 Telepon: +62 812 3456 7890'''),
      ),
    );
  }
}
