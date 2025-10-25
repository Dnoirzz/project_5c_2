// import 'package:flutter/material.dart';
// class ForgotPasswordScreen extends StatelessWidget {
//   const ForgotPasswordScreen({super.key});
//   // texteditingcontroller emailController = texteditingcontroller
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF36566F),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           width: double.infinity,
//           margin: const EdgeInsets.all(16),
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Icon at the top
//                 const Icon(
//                   Icons.lock_reset,
//                   size: 80,
//                   color: Color(0xFF36566F),
//                 ),

//                 const SizedBox(height: 20),

//                 // Title
//                 const Text(
//                   "Lupa Password",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF36566F),
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 // Subtitle
//                 const Text(
//                   "Reset Password",
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Color(0xFF36566F),
//                   ),
//                 ),

//                 const SizedBox(height: 15),

//                 // Description
//                 const Text(
//                   "Masukan email dan password baru\nuntuk melanjutkan, kami akan\nmengirimkan kode verifikasi ke email Anda",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.black54,
//                     fontSize: 14,
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 // Email TextField with Send Button
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(left: 12),
//                         child: Icon(Icons.email, color: Color(0xFF36566F)),
//                       ),

//                       const SizedBox(height: 20),

//                       const Icon(Icons.lock,
//                           size: 80, color: Color(0xFF36566F)),

//                       const SizedBox(height: 20),

//                       // Input Email
//                       TextField(
//                         controller: emailController,
//                         decoration: const InputDecoration(
//                           prefixIcon:
//                               Icon(Icons.email, color: Color(0xFF36566F)),
//                           labelText: "Gmail.com",
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       // Input New Password
//                       TextField(
//                         controller: newPasswordController,
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                           prefixIcon:
//                               Icon(Icons.lock, color: Color(0xFF36566F)),
//                           labelText: "new password",
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       // Input Confirm Password
//                       TextField(
//                         controller: konfirmasiPasswordController,
//                         obscureText: true,
//                         // decoration: const InputDecoration(
//                         //   prefixIcon: Icon(
//                         //     Icons.lock_outline,
//                         //   ),
//                         decoration: InputDecoration(
//                           prefixIcon:
//                               Icon(Icons.security, color: Color(0xFF36566F)),
//                           labelText: "confirm password",
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       // Input Captcha
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "code captcha*",
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           Row(
//                             children: [
//                               Container(
//                                 width: 100,
//                                 height: 40,
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey[300],
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: const Text(
//                                   "A1B2C",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16),
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               const Expanded(
//                                 child: TextField(
//                                   decoration: InputDecoration(
//                                     hintText: "Tulis code disamping",
//                                     border: OutlineInputBorder(),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 25),

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
//                               var data = await Apiservice.reset_password(
//                                 emailController.text.trim(),
//                                 newPasswordController.text.trim(),
//                               );

//                               if (data['status'] == 'success') {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text(data['message'])),
//                                 );
//                                 Navigator.pop(context);
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: Text(data['message'] ??
//                                         'Gagal reset password'),
//                                   ),
//                                 );
//                               }
//                             } catch (e) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text("Terjadi kesalahan: $e"),
//                                 ),
//                               );
//                             }
//                           },
//                           child: const Text(
//                             "Submit",
//                             style: TextStyle(fontSize: 18, color: Colors.white),
//                     //   Expanded(
//                     //     child: TextField(
//                     //       decoration: const InputDecoration(
//                     //         hintText: "Email",
//                     //         border: InputBorder.none,
//                     //         contentPadding: EdgeInsets.symmetric(horizontal: 12),
//                     //       ),
//                     //     ),
//                     //   ),
//                     //   Container(
//                     //     margin: const EdgeInsets.all(4),
//                     //     decoration: BoxDecoration(
//                     //       color: const Color(0xFF36566F),
//                     //       borderRadius: BorderRadius.circular(6),
//                     //     ),
//                     //     child: IconButton(
//                     //       icon: const Icon(Icons.send, color: Colors.white, size: 20),
//                     //       onPressed: () {
//                     //         // Handle send verification code
//                     //       },
//                     //     ),
//                     //   ),
//                     // ],
//                   ),
//                 )),

//                 const SizedBox(height: 15),

//                 // Token Verification TextField
//                 TextField(
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(
//                       Icons.pin,
//                       color: Color(0xFF36566F),
//                     ),
//                     hintText: "Kode Verifikasi",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 15),

//                 // New Password TextField
//                 TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(
//                       Icons.lock,
//                       color: Color(0xFF36566F),
//                     ),
//                     hintText: "New Password",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 15),

//                 // Confirm Password TextField
//                 TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(
//                       Icons.lock,
//                       color: Color(0xFF36566F),
//                     ),
//                     hintText: "Confirm Password",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 // Submit Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF36566F),
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: () {
//                       // Handle submit
//                     },
//                     child: const Text(
//                       "Submit",
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 15),

//                 // Cancel Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: OutlinedButton(
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       side: const BorderSide(color: Color(0xFF36566F)),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text(
//                       "Cancel",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Color(0xFF36566F),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:SPMB/services/auth_servise.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController konfirmasiPasswordController =
      TextEditingController();
  final TextEditingController captchaController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();

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
              children: [
                const Icon(Icons.lock_reset,
                    size: 80, color: Color(0xFF36566F)),
                const SizedBox(height: 15),
                const Text(
                  "Lupa Password",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF36566F),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Masukkan email dan password baru Anda",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 25),

                // Email
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Color(0xFF36566F)),
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),

                // New password
                TextField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF36566F)),
                    labelText: "Password Baru",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),

                // Confirm password
                TextField(
                  controller: konfirmasiPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon:
                        Icon(Icons.lock_outline, color: Color(0xFF36566F)),
                    labelText: "Konfirmasi Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // Captcha
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kode Captcha *",
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
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: captchaController,
                            decoration: const InputDecoration(
                              hintText: "Tulis kode di samping",
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
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      if (newPasswordController.text !=
                          konfirmasiPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Password tidak sama")),
                        );
                        return;
                      }

                      try {
                        final data = await ApiService.reset_Password(
                            emailController.text.trim(),
                            oldPasswordController.text.trim(),
                            newPasswordController.text.trim());

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(data['message'] ?? 'Gagal')),
                        );

                        if (data['status'] == 'success') {
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Terjadi kesalahan: $e')),
                        );
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 16, color: Colors.white),
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
                      side: const BorderSide(color: Color(0xFF36566F)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
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
