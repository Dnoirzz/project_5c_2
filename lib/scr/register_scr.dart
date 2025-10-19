import 'package:SPMB/services/auth_servise.dart';
import 'package:flutter/material.dart';
import '../scr_admin/admin_dashboard.dart';
import 'login_scr.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController namalengkapController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController konfirmasiPasswordController =
        TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF3D5A6C), // warna biru background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tombol back
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 10),

              // Icon + Judul
              Center(
                child: Column(
                  children: const [
                    Icon(Icons.school, color: Colors.white, size: 50),
                    SizedBox(height: 8),
                    Text(
                      "Registrasi",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Container putih (card)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "silahkan registrasi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Masukan nama lengkap, password dan konfirmasi password untuk registrasi",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),

                    const SizedBox(height: 20),

                    // Gambar / ikon
                    Icon(
                      Icons.person_add_alt,
                      size: 80,
                      color: Colors.blueGrey,
                    ),

                    const SizedBox(height: 20),

                    // Form Input
                    TextField(
                      controller: namalengkapController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        hintText: "Nama Lengkap",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: konfirmasiPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Tombol Register
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3D5A6C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () async {
                          // validasi data kosong
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              namalengkapController.text.isEmpty ||
                              konfirmasiPasswordController.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Warning"),
                                content: const Text("Data tidak lengkap"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                            return;
                          }

                          // validasi format email
                          final email = emailController.text.trim();
                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(email)) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Email tidak valid"),
                                content: const Text(
                                    "Silakan masukkan alamat email yang benar."),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                            return;
                          }

                          // validasi password sama
                          if (passwordController.text.trim() !=
                              konfirmasiPasswordController.text.trim()) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Gagal"),
                                content: const Text(
                                    "Password dan konfirmasi tidak sama"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                            return;
                          }

                          try {
                            var data = await ApiService.register(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                              namalengkapController.text.trim(),
                            );

                            if (data['status'] == 'success') {
                              String role = data['role'] ?? 'mahasiswa';

                              if (role == 'admin') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminDashboard()),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Berhasil"),
                                    content: const Text("Registrasi berhasil!"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context); // tutup dialog
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()),
                                          );
                                        },
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  ),
                                  // namalengkapController.clear(),
                                );
                              }
                            } else if (data['message'] ==
                                'Email atau nama sudah terdaftar. Silakan gunakan yang lain.') {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Peringatan"),
                                  content: const Text(
                                      "Email atau nama sudah terdaftar. Silakan gunakan yang lain."),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                              namalengkapController.clear();
                              emailController.clear();
                              passwordController.clear();
                              konfirmasiPasswordController.clear();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        data['message'] ?? 'Gagal registrasi')),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Terjadi kesalahan: $e")),
                            );
                          }
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Link login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("sudah punya akun? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
