import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF36566F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
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
                // Icon at the top
                const Icon(
                  Icons.lock_reset,
                  size: 80,
                  color: Color(0xFF36566F),
                ),

                const SizedBox(height: 20),

                // Title
                const Text(
                  "Lupa Password",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF36566F),
                  ),
                ),

                const SizedBox(height: 10),

                // Subtitle
                const Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF36566F),
                  ),
                ),

                const SizedBox(height: 15),

                // Description
                const Text(
                  "Masukan email dan password baru\nuntuk melanjutkan, kami akan\nmengirimkan kode verifikasi ke email Anda",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 30),

                // Email TextField with Send Button
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Icon(Icons.email, color: Color(0xFF36566F)),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Email",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF36566F),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white, size: 20),
                          onPressed: () {
                            // Handle send verification code
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // Token Verification TextField
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.pin,
                      color: Color(0xFF36566F),
                    ),
                    hintText: "Kode Verifikasi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // New Password TextField
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color(0xFF36566F),
                    ),
                    hintText: "New Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Confirm Password TextField
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color(0xFF36566F),
                    ),
                    hintText: "Confirm Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF36566F),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Handle submit
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Cancel Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side: const BorderSide(color: Color(0xFF36566F)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF36566F),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
