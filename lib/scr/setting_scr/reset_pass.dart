import 'package:flutter/material.dart';
import '../../widgets/appBar.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Scaffold(
      backgroundColor: const Color(
        0xFF0F3C4C,
      ), // warna biru gelap seperti desain
      appBar: const CustomAppBar(
        title: 'Reset Password',
        showBackButton: true,
        showProfileMenu: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Ubah Kata Sandi",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Icon(Icons.lock_outline, size: 100, color: Colors.white70),
              const SizedBox(height: 40),

              // Kata sandi lama
              buildPasswordField(
                label: "Kata sandi lama",
                icon: Icons.vpn_key,
                controller: oldPasswordController,
              ),

              const SizedBox(height: 20),

              // Kata sandi baru
              buildPasswordField(
                label: "Kata sandi baru",
                icon: Icons.lock,
                controller: newPasswordController,
              ),

              const SizedBox(height: 20),

              // Konfirmasi kata sandi baru
              buildPasswordField(
                label: "Konfirmasi kata sandi baru",
                icon: Icons.lock,
                controller: confirmPasswordController,
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  // logika ubah kata sandi di sini
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0F3C4C),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text("*", style: TextStyle(color: Colors.red)),
          ],
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.black87),
            hintText: label,
            hintStyle: const TextStyle(color: Colors.black45),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
