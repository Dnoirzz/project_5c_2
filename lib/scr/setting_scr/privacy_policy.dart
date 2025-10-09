import 'package:flutter/material.dart';
import '../../widgets/appBar.dart';

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
      body: const Center(
        child: Text('''
Tanggal Berlaku: 5 Oktober 2025
Versi: 20251005V1

PT EduTek Nusantara (selanjutnya disebut “Kami”, “Aplikasi”, atau “Sistem Penerimaan Mahasiswa Baru”) berkomitmen untuk melindungi privasi dan keamanan data pribadi pengguna. Dokumen Kebijakan Privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, menyimpan, dan melindungi informasi pribadi Anda saat menggunakan layanan kami. Kami menghormati hak privasi Anda dan memastikan setiap data pribadi yang diberikan akan diproses sesuai dengan peraturan perundang-undangan yang berlaku di Indonesia, termasuk Undang-Undang Nomor 27 Tahun 2022 tentang Perlindungan Data Pribadi (UU PDP). Dengan menggunakan aplikasi ini, Anda dianggap telah membaca, memahami, dan menyetujui seluruh isi kebijakan ini. Jika Anda tidak menyetujui kebijakan ini, mohon untuk tidak menggunakan layanan kami.

Kami mengumpulkan data pribadi untuk keperluan pendaftaran mahasiswa baru, pengelolaan akun, serta peningkatan layanan. Data yang dikumpulkan meliputi nama lengkap, NIK, NISN, tanggal lahir, jenis kelamin, alamat, email, nomor telepon, nilai rapor, ijazah, foto diri, serta dokumen pendukung lainnya. Selain itu, kami juga dapat mengumpulkan data otomatis seperti alamat IP perangkat, jenis perangkat, sistem operasi, log aktivitas, waktu akses, serta informasi penggunaan aplikasi. Kami mungkin juga meminta data tambahan seperti hasil survei kepuasan atau umpan balik dari pengguna guna meningkatkan kualitas layanan.

Informasi yang dikumpulkan akan digunakan untuk memproses pendaftaran mahasiswa baru, melakukan verifikasi data, mengelola akun pengguna, memberikan notifikasi hasil seleksi, serta menyediakan layanan bantuan dan tanggapan terhadap pertanyaan Anda. Kami juga menggunakan data tersebut untuk mengembangkan, memelihara, dan meningkatkan fitur aplikasi agar pengalaman pengguna semakin baik. Selain itu, kami dapat menggunakan data untuk memenuhi kewajiban hukum atau permintaan dari instansi resmi apabila diperlukan.

Kami menerapkan langkah-langkah keamanan administratif, teknis, dan fisik untuk melindungi data pribadi dari akses tidak sah, kehilangan, atau penyalahgunaan. Data disimpan pada server yang aman dengan akses terbatas dan dilindungi melalui proses enkripsi. Informasi pribadi hanya disimpan selama diperlukan untuk tujuan administratif atau sesuai dengan ketentuan hukum. Jika terjadi pelanggaran data, kami akan segera memberitahu pengguna dan otoritas yang berwenang sesuai ketentuan peraturan perundang-undangan.

Kami tidak akan menjual atau menyewakan data pribadi Anda kepada pihak ketiga. Namun, data dapat dibagikan kepada instansi pendidikan atau pemerintah untuk keperluan verifikasi pendaftaran, penyedia layanan teknologi yang membantu pengelolaan sistem dan keamanan data, serta penegak hukum apabila diwajibkan oleh hukum. Setiap pihak penerima data wajib mematuhi ketentuan kerahasiaan dan perlindungan data sesuai peraturan yang berlaku.

Pengguna memiliki hak untuk mengakses, memperbarui, dan menghapus data pribadinya. Anda juga berhak menarik persetujuan atas pemrosesan data dengan konsekuensi tidak dapat menggunakan sebagian layanan aplikasi. Permintaan terkait dapat dikirimkan melalui email ke privacy@penerimaanmahasiswa.id.

Aplikasi ini tidak menggunakan cookie kecuali untuk keperluan autentikasi dan keamanan sesi pengguna, serta tidak melacak aktivitas pribadi di luar penggunaan aplikasi. Kami juga tidak secara sengaja mengumpulkan data dari anak di bawah umur 17 tahun tanpa izin orang tua atau wali. Jika kami mengetahui adanya data anak yang dikumpulkan tanpa izin, maka data tersebut akan segera dihapus.

Kebijakan Privasi ini dapat diperbarui sewaktu-waktu. Perubahan akan diumumkan melalui notifikasi dalam aplikasi atau situs web resmi. Tanggal “Berlaku Efektif” di bagian atas menunjukkan waktu terakhir kebijakan ini diperbarui. Jika Anda terus menggunakan aplikasi setelah adanya pembaruan, berarti Anda menyetujui perubahan tersebut.

Apabila Anda memiliki pertanyaan, keluhan, atau permintaan terkait kebijakan ini, silakan hubungi kami melalui email privacy@penerimaanmahasiswa.id, kunjungi situs www.penerimaanmahasiswa.id, atau hubungi telepon (021) 555-1234.

Seluruh isi aplikasi dan kebijakan ini dilindungi oleh hukum Republik Indonesia. Hak cipta © 2025 Sistem Penerimaan Mahasiswa Baru. Semua hak dilindungi.
'''),
      ),
    );
  }
}
