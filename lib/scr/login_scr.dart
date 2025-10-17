import 'package:flutter/material.dart';
import 'forgot_scr.dart';
import 'register_scr.dart';
import 'dashboard_scr.dart';
import '../scr_admin/admin_dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // controller untuk ambil input dari TextField
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF36566F), // warna biru background
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Ikon Top (cap wisuda)
                      const Icon(
                        Icons.school,
                        size: 50,
                        color: Color(0xFF36566F),
                      ),

                      const SizedBox(height: 10),
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF36566F),
                        ),
                      ),

                      const SizedBox(height: 20),
                      const Text(
                        "Masuk ke Akun Anda\nMasukan email dan password untuk melanjutkan",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),

                      const SizedBox(height: 20),

                      // Ilustrasi (email + shield)
                      const Icon(
                        Icons.email,
                        size: 100,
                        color: Color(0xFF36566F),
                      ),

                      const SizedBox(height: 20),

                      // TextField Email
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Color(0xFF36566F),
                          ),
                          labelText: "Email",
                          border: const OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // TextField Password
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color(0xFF36566F),
                          ),
                          labelText: "Password",
                          border: const OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Checkbox + Lupa Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(value: false, onChanged: (val) {}),
                              const Text("Remember me"),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Lupa Password?",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Tombol Login
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF36566F),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          //     onPressed: () {
                          //       String email = emailController.text.trim();
                          //       String password = passwordController.text.trim();

                          //       if (email == '' && password == 'admin') {
                          //         // Login sebagai Admin
                          //         Navigator.pushReplacement(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) => const AdminDashboard(),
                          //           ),
                          //         );
                          //       } else if (email == 'user' && password == 'user') {
                          //         // Login sebagai User
                          //         Navigator.pushReplacement(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) => const DashboardPage(),
                          //           ),
                          //         );
                          //       } else {
                          //         // Jika login salah
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //           const SnackBar(
                          //             content: Text(
                          //                 'Email atau password salah! Coba lagi.'),
                          //           ),
                          //         );
                          //       }
                          //     },
                          //     child: const Text(
                          //       "Login",
                          //       style: TextStyle(fontSize: 18, color: Colors.white),
                          //     ),
                          //   ),
                          // ),
                          onPressed: () async {
                            var url = Uri.parse(
                              "http://44.220.144.82/api/login.php",
                            );

                            try {
                              var response = await http.post(
                                url,
                                headers: {"Content-Type": "application/json"},
                                body: jsonEncode({
                                  "username": emailController.text.trim(),
                                  "password": passwordController.text.trim(),
                                }),
                              );

                              if (response.statusCode == 200) {
                                var data = json.decode(response.body);

                                //   if (data['status'] == 'success') {
                                //     showDialog(
                                //       context: context,
                                //       builder: (context) => AlertDialog(
                                //         title: Text("Berhasil"),
                                //         content: Text("Login Berhasil"),
                                //         actions: [
                                //           TextButton(
                                //             onPressed: () =>
                                //                 Navigator.pop(context),
                                //             child: Text("OK"),
                                //           ),
                                //         ],
                                //       ),
                                //     );
                                //     Navigator.pushReplacement(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             const DashboardPage(),
                                //       ),
                                //     );
                                if (data['status'] == 'success') {
                                  var user = data['data'];
                                  String role = user['role'] ?? 'mahasiswa';

                                  if (role == 'admin') {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Berhasil"),
                                        content: Text(
                                          "Login Berhasil sebagai Admin",
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text("OK"),
                                          ),
                                        ],
                                      ),
                                    );
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AdminDashboard()),
                                    );
                                  } else {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DashboardPage()),
                                    );
                                  }
                                } else {
                                  emailController.clear();
                                  passwordController.clear();
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("Gagal"),
                                      content: Text(
                                        "Username atau password salah",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("OK"),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Gagal terhubung ke server"),
                                  ),
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Terjadi kesalahan: $e"),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      //     onPressed: () async {
                      //       var url = Uri.parse(
                      //         "http://44.220.144.82/api/login.php",
                      //       );

                      //       try {
                      //         var response = await http.post(
                      //           url,
                      //           headers: {"Content-Type": "application/json"},
                      //           body: jsonEncode({
                      //             "username": emailController.text.trim(),
                      //             "password": passwordController.text.trim(),
                      //           }),
                      //         );

                      //         if (response.statusCode == 200) {
                      //           var data = json.decode(response.body);

                      //           if (data['status'] == 'success') {
                      //             showDialog(
                      //               context: context,
                      //               builder: (context) => AlertDialog(
                      //                 title: Text("Berhasil"),
                      //                 content: Text("Login Berhasil"),
                      //                 actions: [
                      //                   TextButton(
                      //                     onPressed: () =>
                      //                         Navigator.pop(context),
                      //                     child: Text("OK"),
                      //                   ),
                      //                 ],
                      //               ),
                      //             );
                      //             Navigator.pushReplacement(
                      //               context,
                      //               MaterialPageRoute(
                      //                 builder: (context) =>
                      //                     const DashboardPage(),
                      //               ),
                      //             );
                      //           } else {
                      //             emailController.clear();
                      //             passwordController.clear();
                      //             showDialog(
                      //               context: context,
                      //               builder: (context) => AlertDialog(
                      //                 title: Text("Gagal"),
                      //                 content: Text(
                      //                   "Username atau password salah",
                      //                 ),
                      //                 actions: [
                      //                   TextButton(
                      //                     onPressed: () =>
                      //                         Navigator.pop(context),
                      //                     child: Text("OK"),
                      //                   ),
                      //                 ],
                      //               ),
                      //             );
                      //           }
                      //         } else {
                      //           ScaffoldMessenger.of(context).showSnackBar(
                      //             const SnackBar(
                      //               content: Text("Gagal terhubung ke server"),
                      //             ),
                      //           );
                      //         }
                      //       } catch (e) {
                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //           SnackBar(
                      //             content: Text("Terjadi kesalahan: $e"),
                      //           ),
                      //         );
                      //       }
                      //     },
                      //     child: const Text(
                      //       "Login",
                      //       style: TextStyle(fontSize: 18, color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 15),

                      // Link daftar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Belum punya akun ? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Daftar sekarang",
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
