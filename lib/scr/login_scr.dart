// import '../services/auth_servise.dart';
// import 'package:flutter/material.dart';
// import 'forgot_scr.dart';
// import 'register_scr.dart';
// import 'dashboard_scr.dart';
// import '../scr_admin/admin_dashboard.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool rememberMe = false;

//   @override
//   void initState() {
//     super.initState();
//     checkAutoLogin();

//     emailController.addListener(() => saveCredentialsOnChange());
//     passwordController.addListener(() => saveCredentialsOnChange());
//   }

//   Future<void> checkAutoLogin() async {
//     final prefs = await SharedPreferences.getInstance();
//     bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;
//     if (isLoggedIn) {
//       String role = prefs.getString('user_role') ?? 'mahasiswa';
//       // langsung masuk dashboard sesuai role
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (role == 'admin') {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (_) => const AdminDashboard()),
//           );
//         } else {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (_) => const DashboardPage()),
//           );
//         }
//       });
//       return;
//     }

//     // Load credentials jika remember me dicentang
//     setState(() {
//       rememberMe = prefs.getBool('rememberMe') ?? false;
//       if (rememberMe) {
//         emailController.text = prefs.getString('email') ?? '';
//         passwordController.text = prefs.getString('password') ?? '';
//       }
//     });
//   }

//   // Future<void> saveCredentials() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   if (rememberMe) {
//   //     await prefs.setString('email', emailController.text.trim());
//   //     await prefs.setString('password', passwordController.text.trim());
//   //     await prefs.setBool('rememberMe', true);
//   //   } else {
//   //     await prefs.remove('email');
//   //     await prefs.remove('password');
//   //     await prefs.setBool('rememberMe', false);
//   //   }
//   // }
//   Future<void> saveCredentialsOnChange() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (rememberMe) {
//       await prefs.setString('email', emailController.text.trim());
//       await prefs.setString('password', passwordController.text.trim());
//       await prefs.setBool('rememberMe', true);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF36566F),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 margin: const EdgeInsets.all(16),
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       const Icon(Icons.school,
//                           size: 50, color: Color(0xFF36566F)),
//                       const SizedBox(height: 10),
//                       const Text("Login",
//                           style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF36566F))),
//                       const SizedBox(height: 20),
//                       const Text(
//                           "Masuk ke Akun Anda\nMasukan email dan password untuk melanjutkan",
//                           textAlign: TextAlign.center,
//                           style:
//                               TextStyle(color: Colors.black54, fontSize: 14)),
//                       const SizedBox(height: 20),
//                       const Icon(Icons.email,
//                           size: 100, color: Color(0xFF36566F)),
//                       const SizedBox(height: 20),
//                       TextField(
//                         controller: emailController,
//                         decoration: const InputDecoration(
//                           prefixIcon:
//                               Icon(Icons.email, color: Color(0xFF36566F)),
//                           labelText: "Email",
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       TextField(
//                         controller: passwordController,
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                           prefixIcon:
//                               Icon(Icons.lock, color: Color(0xFF36566F)),
//                           labelText: "Password",
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               // Checkbox(
//                               //   value: rememberMe,
//                               //   onChanged: (val) {
//                               //     setState(() {
//                               //       rememberMe = val ?? false;
//                               //     });
//                               //   },
//                               // ),
//                               Checkbox(
//                                 value: rememberMe,
//                                 onChanged: (val) async {
//                                   setState(() {
//                                     rememberMe = val ?? false;
//                                   });
//                                   final prefs =
//                                       await SharedPreferences.getInstance();
//                                   if (rememberMe) {
//                                     // simpan email/password terakhir yang diketik
//                                     await prefs.setString(
//                                         'email', emailController.text.trim());
//                                     await prefs.setString('password',
//                                         passwordController.text.trim());
//                                     await prefs.setBool('rememberMe', true);
//                                   } else {
//                                     await prefs.remove('email');
//                                     await prefs.remove('password');
//                                     await prefs.setBool('rememberMe', false);
//                                   }
//                                 },
//                               ),
//                               // saveCredentialsOnChange();
//                               const Text("Remember me"),
//                             ],
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (_) => ForgotPasswordScreen()));
//                             },
//                             child: const Text("Lupa Password?",
//                                 style: TextStyle(color: Colors.blue)),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF36566F),
//                             padding: const EdgeInsets.symmetric(vertical: 15),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30)),
//                           ),
//                           onPressed: () async {
//                             try {
//                               var data = await ApiService.login(
//                                   emailController.text.trim(),
//                                   passwordController.text.trim());
//                               if (data['status'] == 'success') {
//                                 var user = data['data'];
//                                 String role = user['role'] ?? 'mahasiswa';

//                                 final prefs =
//                                     await SharedPreferences.getInstance();
//                                 await prefs.setString(
//                                     'user_email', user['email'] ?? '');
//                                 await prefs.setString('user_nama_lengkap',
//                                     user['nama_lengkap'] ?? '');
//                                 await prefs.setString('user_role', role);
//                                 await prefs.setBool('is_logged_in', true);

//                                 await saveCredentialsOnChange(); // simpan remember me

//                                 // redirect sesuai role
//                                 if (role == 'admin') {
//                                   Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (_) =>
//                                               const AdminDashboard()));
//                                 } else {
//                                   Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (_) =>
//                                               const DashboardPage()));
//                                 }
//                               } else {
//                                 emailController.clear();
//                                 passwordController.clear();
//                                 showDialog(
//                                   context: context,
//                                   builder: (_) => AlertDialog(
//                                     title: const Text("Gagal"),
//                                     content: Text(data['message'] ??
//                                         "Username atau password salah"),
//                                     actions: [
//                                       TextButton(
//                                           onPressed: () =>
//                                               Navigator.pop(context),
//                                           child: const Text("OK"))
//                                     ],
//                                   ),
//                                 );
//                               }
//                             } catch (e) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       content: Text("Terjadi kesalahan: $e")));
//                             }
//                           },
//                           child: const Text("Login",
//                               style:
//                                   TextStyle(fontSize: 18, color: Colors.white)),
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text("Belum punya akun ? "),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (_) => const RegisterScreen()));
//                             },
//                             child: const Text("Daftar sekarang",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.blue)),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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

  Future<void> _initialize() async {
    final prefs = await SharedPreferences.getInstance();

    print('=== INITIALIZE LOGIN SCREEN ===');
    print('is_logged_in: ${prefs.getBool('is_logged_in')}');
    print('APP_rememberMe: ${prefs.getBool('APP_rememberMe')}');
    print('APP_saved_email: ${prefs.getString('APP_saved_email')}');
    print('APP_saved_password: ${prefs.getString('APP_saved_password')}');

    // Cek apakah user sudah login
    bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    if (isLoggedIn) {
      // Auto-login: langsung redirect
      String role = prefs.getString('user_role') ?? 'mahasiswa';
      print('Auto-login detected, redirecting...');

      await Future.delayed(const Duration(milliseconds: 200));

      if (mounted) {
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
    } else {
      // Tidak auto-login: load remember me data
      print('Loading remember me data...');

      bool savedRememberMe = prefs.getBool('APP_rememberMe') ?? false;
      String savedEmail = prefs.getString('APP_saved_email') ?? '';
      String savedPassword = prefs.getString('APP_saved_password') ?? '';

      print('Loaded: rememberMe=$savedRememberMe, email=$savedEmail');

      setState(() {
        rememberMe = savedRememberMe;
        emailController.text = savedEmail;
        passwordController.text = savedPassword;
        _isChecking = false;
      });

      print('TextField updated');
    }
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

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool rememberMe = false;

//   @override
//   void initState() {
//     super.initState();
//     loadCredentials();
//   }

//   Future<void> loadCredentials() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       rememberMe = prefs.getBool('rememberMe') ?? false;
//       if (rememberMe) {
//         emailController.text = prefs.getString('email') ?? '';
//         passwordController.text = prefs.getString('password') ?? '';
//       }
//     });
//   }

//   Future<void> saveCredentials() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (rememberMe) {
//       await prefs.setString('email', emailController.text.trim());
//       await prefs.setString('password', passwordController.text.trim());
//       await prefs.setBool('rememberMe', true);
//     } else {
//       await prefs.remove('email');
//       await prefs.remove('password');
//       await prefs.setBool('rememberMe', false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF36566F),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 margin: const EdgeInsets.all(16),
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       // Ikon Top (cap wisuda)
//                       const Icon(
//                         Icons.school,
//                         size: 50,
//                         color: Color(0xFF36566F),
//                       ),

//                       const SizedBox(height: 10),
//                       const Text(
//                         "Login",
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF36566F),
//                         ),
//                       ),

//                       const SizedBox(height: 20),
//                       const Text(
//                         "Masuk ke Akun Anda\nMasukan email dan password untuk melanjutkan",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.black54, fontSize: 14),
//                       ),

//                       const SizedBox(height: 20),

//                       // Ilustrasi (email + shield)
//                       const Icon(
//                         Icons.email,
//                         size: 100,
//                         color: Color(0xFF36566F),
//                       ),

//                       const SizedBox(height: 20),

//                       // TextField Email
//                       TextField(
//                         controller: emailController,
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(
//                             Icons.email,
//                             color: Color(0xFF36566F),
//                           ),
//                           labelText: "Email",
//                           border: const OutlineInputBorder(),
//                         ),
//                       ),

//                       const SizedBox(height: 15),

//                       // TextField Password
//                       TextField(
//                         controller: passwordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(
//                             Icons.lock,
//                             color: Color(0xFF36566F),
//                           ),
//                           labelText: "Password",
//                           border: const OutlineInputBorder(),
//                         ),
//                       ),

//                       const SizedBox(height: 10),

//                       // Checkbox + Lupa Password
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Checkbox(value: false, onChanged: (val) {}),
//                               const Text("Remember me"),
//                             ],
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ForgotPasswordScreen(),
//                                 ),
//                               );
//                             },
//                             child: const Text(
//                               "Lupa Password?",
//                               style: TextStyle(color: Colors.blue),
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 10),

//                       // Tombol Login
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF36566F),
//                             padding: const EdgeInsets.symmetric(vertical: 15),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                           onPressed: () async {
//                             try {
//                               var data = await ApiService.login(
//                                 emailController.text.trim(),
//                                 passwordController.text.trim(),
//                               );

//                               if (data['status'] == 'success') {
//                                 var user = data['data'];
//                                 String role = user['role'] ?? 'mahasiswa';

//                                 // 🔹 Simpan data user ke SharedPreferences
//                                 final prefs =
//                                     await SharedPreferences.getInstance();
//                                 await prefs.setString(
//                                     'user_email', user['email'] ?? '');
//                                 await prefs.setString('user_nama_lengkap',
//                                     user['nama_lengkap'] ?? '');
//                                 await prefs.setString('user_role', role);
//                                 await prefs.setBool('is_logged_in', true);

//                                 // Simpan credentials jika remember me dicentang
//                                 await saveCredentials();

//                                 if (role == 'admin') {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) => AlertDialog(
//                                       title: const Text("Berhasil"),
//                                       content: const Text("Login berhasil!"),
//                                       actions: [
//                                         TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                             Navigator.pushReplacement(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const AdminDashboard()),
//                                             );
//                                           },
//                                           child: const Text("OK"),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 } else {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) => AlertDialog(
//                                       title: const Text("Berhasil"),
//                                       content: const Text("Login berhasil!"),
//                                       actions: [
//                                         TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                             Navigator.pushReplacement(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const DashboardPage()),
//                                             );
//                                           },
//                                           child: const Text("OK"),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 }
//                               } else {
//                                 emailController.clear();
//                                 passwordController.clear();
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialog(
//                                     title: const Text("Gagal"),
//                                     content: Text(data['message'] ??
//                                         "Username atau password salah"),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () => Navigator.pop(context),
//                                         child: const Text("OK"),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               }
//                             } catch (e) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content: Text("Terjadi kesalahan: $e")),
//                               );
//                             }
//                           },
//                           child: const Text(
//                             "Login",
//                             style: TextStyle(fontSize: 18, color: Colors.white),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 15),

//                       // Link daftar
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text("Belum punya akun ? "),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const RegisterScreen(),
//                                 ),
//                               );
//                             },
//                             child: const Text(
//                               "Daftar sekarang",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
