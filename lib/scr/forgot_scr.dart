import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF36566F),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    "LUPA PASSWORD",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),

            // Card Konten
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
                      // Ikon cap wisuda
                      const Icon(Icons.school,
                          size: 50, color: Color(0xFF36566F)),
                      const SizedBox(height: 10),

                      const Text(
                        "Lupa password",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF36566F),
                        ),
                      ),
                      const SizedBox(height: 15),

                      const Text(
                        "Masukan email dan password baru untuk melanjutkan. "
                        "Kami akan mengirimkan kode verifikasi ke email Anda.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),

                      const SizedBox(height: 20),

                      const Icon(Icons.lock,
                          size: 80, color: Color(0xFF36566F)),

                      const SizedBox(height: 20),

                      // Input Email
                      const TextField(
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.email, color: Color(0xFF36566F)),
                          labelText: "Gmail.com",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Input Code Verifikasi
                      const TextField(
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.verified, color: Color(0xFF36566F)),
                          labelText: "code verifikasi",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Input New Password
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.lock, color: Color(0xFF36566F)),
                          labelText: "new password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Input Confirm Password
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.security, color: Color(0xFF36566F)),
                          labelText: "confirm password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Input Captcha
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "code captcha*",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text(
                                  "A1B2C",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Tulis code disamping",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // Tombol Submit
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
                          onPressed: () {},
                          child: const Text(
                            "Submit",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Tombol Cancel
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
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
