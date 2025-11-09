import '../services/auth_servise.dart';
import 'package:flutter/material.dart';
import 'forgot_scr.dart';
import 'register_scr.dart';
import 'dashboard_scr.dart';
import '../scr_admin/admin_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  // Future<void> _initialize() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   print('=== INITIALIZE LOGIN SCREEN ===');
  //   print('is_logged_in: ${prefs.getBool('is_logged_in')}');
  //   print('APP_rememberMe: ${prefs.getBool('APP_rememberMe')}');
  //   print('APP_saved_email: ${prefs.getString('APP_saved_email')}');
  //   print('APP_saved_password: ${prefs.getString('APP_saved_password')}');

  //   // Cek apakah user sudah login
  //   bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  //   if (isLoggedIn) {
  //     // Auto-login: langsung redirect
  //     String role = prefs.getString('user_role') ?? 'mahasiswa';
  //     print('Auto-login detected, redirecting...');

  //     await Future.delayed(const Duration(milliseconds: 200));

  //     if (mounted) {
  //       if (role == 'admin') {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (_) => const AdminDashboard()),
  //         );
  //       } else {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (_) => const DashboardPage()),
  //         );
  //       }
  //     }
  //   } else {
  //     // Tidak auto-login: load remember me data
  //     print('Loading remember me data...');

  //     bool savedRememberMe = prefs.getBool('APP_rememberMe') ?? false;
  //     String savedEmail = prefs.getString('APP_saved_email') ?? '';
  //     String savedPassword = prefs.getString('APP_saved_password') ?? '';

  //     print('Loaded: rememberMe=$savedRememberMe, email=$savedEmail');

  //     setState(() {
  //       rememberMe = savedRememberMe;
  //       emailController.text = savedEmail;
  //       passwordController.text = savedPassword;
  //       _isChecking = false;
  //     });

  //     print('TextField updated');
  //   }
  // }
  // Future<void> _initialize() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   print('=== INITIALIZE LOGIN SCREEN ===');
  //   print('is_logged_in: ${prefs.getBool('is_logged_in')}');
  //   print('user_role: ${prefs.getString('user_role')}');
  //   print('APP_rememberMe: ${prefs.getBool('APP_rememberMe')}');
  //   print('APP_saved_email: ${prefs.getString('APP_saved_email')}');

  //   bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  //   // Jika sebelumnya ada session login, hapus dulu
  //   if (isLoggedIn) {
  //     print('Clearing previous session...');
  //     await prefs.remove('is_logged_in');
  //     await prefs.remove('user_role');
  //     await prefs.remove('user_email');
  //     await prefs.remove('user_nama_lengkap');
  //     isLoggedIn = false; // reset flag supaya tidak auto-redirect
  //   }

  //   // Load remember me data tetap bisa
  //   bool savedRememberMe = prefs.getBool('APP_rememberMe') ?? false;
  //   String savedEmail = prefs.getString('APP_saved_email') ?? '';
  //   String savedPassword = prefs.getString('APP_saved_password') ?? '';

  //   print('Loaded remember me: email=$savedEmail, rememberMe=$savedRememberMe');

  //   setState(() {
  //     rememberMe = savedRememberMe;
  //     emailController.text = savedEmail;
  //     passwordController.text = savedPassword;
  //     _isChecking = false;
  //   });
  // }
  Future<void> _initialize() async {
    final prefs = await SharedPreferences.getInstance();

    print('=== INITIALIZE LOGIN SCREEN ===');
    print('is_logged_in: ${prefs.getBool('is_logged_in')}');
    print('user_role: ${prefs.getString('user_role')}');
    print('APP_rememberMe: ${prefs.getBool('APP_rememberMe')}');
    print('APP_saved_email: ${prefs.getString('APP_saved_email')}');

    bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    // ⚠️ Jangan hapus session di sini.
    // Biarkan hanya auto-login / auto-redirect yang berjalan.

    if (isLoggedIn) {
      print('Auto-login detected, redirecting...');
      await Future.delayed(const Duration(milliseconds: 200));

      if (mounted) {
        String role = prefs.getString('user_role') ?? 'mahasiswa';
        if (role == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AdminDashboard()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const DashboardPage()),
          );
        }
      }
      return; // hentikan eksekusi agar tidak lanjut ke bawah
    }

    // Load remember me data
    bool savedRememberMe = prefs.getBool('APP_rememberMe') ?? false;
    String savedEmail = prefs.getString('APP_saved_email') ?? '';
    String savedPassword = prefs.getString('APP_saved_password') ?? '';

    print('Loaded remember me: email=$savedEmail, rememberMe=$savedRememberMe');

    setState(() {
      rememberMe = savedRememberMe;
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      _isChecking = false;
    });
  }

  Future<void> onRememberMeChanged(bool? val) async {
    setState(() {
      rememberMe = val ?? false;
    });
  }

  // Fungsi logout - panggil dari dashboard
  static Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    print('=== LOGOUT ===');
    print('Before logout:');
    print('  - is_logged_in: ${prefs.getBool('is_logged_in')}');
    print('  - APP_rememberMe: ${prefs.getBool('APP_rememberMe')}');
    print('  - APP_saved_email: ${prefs.getString('APP_saved_email')}');

    // Hapus hanya status login
    await prefs.remove('is_logged_in');
    await prefs.remove('user_email');
    await prefs.remove('user_nama_lengkap');
    await prefs.remove('user_role');

    // APP_rememberMe, APP_saved_email, APP_saved_password TIDAK DIHAPUS

    print('After logout:');
    print('  - is_logged_in: ${prefs.getBool('is_logged_in')}');
    print('  - APP_rememberMe: ${prefs.getBool('APP_rememberMe')}');
    print('  - APP_saved_email: ${prefs.getString('APP_saved_email')}');

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return const Scaffold(
        backgroundColor: Color(0xFF36566F),
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF36566F),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Icon(Icons.school,
                          size: 50, color: Color(0xFF36566F)),
                      const SizedBox(height: 10),
                      const Text("Login",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF36566F))),
                      const SizedBox(height: 20),
                      const Text(
                          "Masuk ke Akun Anda\nMasukan email dan password untuk melanjutkan",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.black54, fontSize: 14)),
                      const SizedBox(height: 20),
                      const Icon(Icons.email,
                          size: 100, color: Color(0xFF36566F)),
                      const SizedBox(height: 20),
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          prefixIcon:
                              Icon(Icons.email, color: Color(0xFF36566F)),
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon:
                              Icon(Icons.lock, color: Color(0xFF36566F)),
                          labelText: "Password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: onRememberMeChanged,
                              ),
                              const Text("Remember me"),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ForgotPasswordScreen()));
                            },
                            child: const Text("Lupa Password?",
                                style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF36566F),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () async {
                            String email = emailController.text.trim();
                            String password = passwordController.text.trim();

                            // Validasi input
                            if (email.isEmpty || password.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Email dan password harus diisi")));
                              return;
                            }

                            print('=== LOGIN ATTEMPT ===');
                            print('Email: $email');
                            print('Remember me: $rememberMe');

                            try {
                              var data =
                                  await ApiService.login(email, password);

                              print('Login response: ${data['status']}');

                              if (data['status'] == 'success') {
                                var user = data['data'];
                                String role = user['role'] ?? 'mahasiswa';

                                final prefs =
                                    await SharedPreferences.getInstance();

                                print('=== SAVING DATA ===');

                                // 1. Simpan data user session
                                await prefs.setString(
                                    'user_email', user['email'] ?? '');
                                await prefs.setString('user_nama_lengkap',
                                    user['nama_lengkap'] ?? '');
                                await prefs.setString('user_role', role);
                                await prefs.setBool('is_logged_in', true);

                                print(
                                    'Session saved: is_logged_in=true, role=$role');

                                // 2. Simpan/hapus remember me (gunakan prefix khusus)
                                if (rememberMe) {
                                  // Simpan email & password dengan prefix APP_
                                  await prefs.setString(
                                      'APP_saved_email', email);
                                  await prefs.setString(
                                      'APP_saved_password', password);
                                  await prefs.setBool('APP_rememberMe', true);
                                  print('Remember me saved: email=$email');
                                } else {
                                  // Hapus email & password jika tidak centang
                                  await prefs.remove('APP_saved_email');
                                  await prefs.remove('APP_saved_password');
                                  await prefs.setBool('APP_rememberMe', false);
                                  print('Remember me removed');
                                }

                                // Verifikasi data tersimpan
                                print('Verification:');
                                print(
                                    '  - is_logged_in: ${prefs.getBool('is_logged_in')}');
                                print(
                                    '  - APP_rememberMe: ${prefs.getBool('APP_rememberMe')}');
                                print(
                                    '  - APP_saved_email: ${prefs.getString('APP_saved_email')}');

                                // 3. Redirect sesuai role
                                if (mounted) {
                                  if (role == 'admin') {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const AdminDashboard()));
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const DashboardPage()));
                                  }
                                }
                              } else {
                                // Login gagal
                                print('Login failed: ${data['message']}');

                                if (mounted) {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text("Gagal"),
                                      content: Text(data['message'] ??
                                          "Username atau password salah"),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("OK"))
                                      ],
                                    ),
                                  );
                                }
                                emailController.clear();
                                passwordController.clear();
                              }
                            } catch (e) {
                              print('Login error: $e');
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Terjadi kesalahan: $e")));
                              }
                            }
                          },
                          child: const Text("Login",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Belum punya akun ? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const RegisterScreen()));
                            },
                            child: const Text("Daftar sekarang",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)),
                          ),
                        ],
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
