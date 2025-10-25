// class ResetPasswordPage extends StatelessWidget {
//   const ResetPasswordPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController oldPasswordController = TextEditingController();
//     final TextEditingController newPasswordController = TextEditingController();
//     final TextEditingController confirmPasswordController =
//         TextEditingController();

//     return Scaffold(
//       backgroundColor: const Color(
//         0xFF4F6C7A,
//       ), // warna biru gelap seperti desain
//       appBar: const CustomAppBar(
//         title: 'Reset Password',
//         showBackButton: true,
//         showProfileMenu: false,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const Text(
//                 "Ubah Kata Sandi",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Icon(Icons.lock_outline, size: 100, color: Colors.white70),
//               const SizedBox(height: 40),

//               // Kata sandi lama
//               buildPasswordField(
//                 label: "Kata sandi lama",
//                 icon: Icons.vpn_key,
//                 controller: oldPasswordController,
//               ),

//               const SizedBox(height: 20),

//               // Kata sandi baru
//               buildPasswordField(
//                 label: "Kata sandi baru",
//                 icon: Icons.lock,
//                 controller: newPasswordController,
//               ),

//               const SizedBox(height: 20),

//               // Konfirmasi kata sandi baru
//               buildPasswordField(
//                 label: "Konfirmasi kata sandi baru",
//                 icon: Icons.lock,
//                 controller: confirmPasswordController,
//               ),

//               const SizedBox(height: 40),

//               ElevatedButton(
//                 onPressed: () {
//                   // logika ubah kata sandi di sini
//                   String oldPass = oldPasswordController.text.trim();
//                   String newPass = newPasswordController.text.trim();
//                   String confirm = confirmPasswordController.text.trim();

//                   if (oldPass.isEmpty || newPass.isEmpty || confirm.isEmpty) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("Semua kolom wajib diisi")),
//                     );
//                     return;
//                   }

//                   if (newPass != confirm) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                           content: Text("Konfirmasi password tidak cocok")),
//                     );
//                     return;
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: const Color(0xFF0F3C4C),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 50,
//                     vertical: 15,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   "Simpan Perubahan",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildPasswordField({
//     required String label,
//     required IconData icon,
//     required TextEditingController controller,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(
//               label,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const Text("*", style: TextStyle(color: Colors.red)),
//           ],
//         ),
//         const SizedBox(height: 5),
//         TextField(
//           controller: controller,
//           obscureText: true,
//           decoration: InputDecoration(
//             prefixIcon: Icon(icon, color: Colors.black87),
//             hintText: label,
//             hintStyle: const TextStyle(color: Colors.black45),
//             filled: true,
//             fillColor: Colors.white,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide.none,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_servise.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  Future<void> resetPassword() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('user_email'); // ambil email user login

    String oldPass = oldPasswordController.text.trim();
    String newPass = newPasswordController.text.trim();
    String confirm = confirmPasswordController.text.trim();

    if (oldPass.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua kolom wajib diisi")),
      );
      return;
    }
    // if (newPass == oldPass) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //         content: Text("Password baru tidak boleh sama dengan lama")),
    //   );
    //   return;
    // }
    if (newPass != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Konfirmasi password tidak cocok")),
      );
      return;
    }

    if (email == null || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email pengguna tidak ditemukan")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      var response = await ApiService.reset_Password(email, oldPass, newPass);

      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Kata sandi berhasil diperbarui")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(response['message'] ?? "Gagal memperbarui sandi")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4F6C7A),
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

              // input lama, baru, konfirmasi
              buildPasswordField(
                label: "Kata sandi lama",
                icon: Icons.vpn_key,
                controller: oldPasswordController,
              ),
              const SizedBox(height: 20),
              buildPasswordField(
                label: "Kata sandi baru",
                icon: Icons.lock,
                controller: newPasswordController,
              ),
              const SizedBox(height: 20),
              buildPasswordField(
                label: "Konfirmasi kata sandi baru",
                icon: Icons.lock,
                controller: confirmPasswordController,
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: isLoading ? null : resetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0F3C4C),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Simpan Perubahan",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
