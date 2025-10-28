// // import 'package:flutter/material.dart';
// // class ForgotPasswordScreen extends StatelessWidget {
// //   const ForgotPasswordScreen({super.key});
// //   // texteditingcontroller emailController = texteditingcontroller
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFF36566F),
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //       ),
// //       body: SafeArea(
// //         child: Container(
// //           width: double.infinity,
// //           margin: const EdgeInsets.all(16),
// //           padding: const EdgeInsets.all(20),
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(20),
// //           ),
// //           child: SingleChildScrollView(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.center,
// //               children: [
// //                 // Icon at the top
// //                 const Icon(
// //                   Icons.lock_reset,
// //                   size: 80,
// //                   color: Color(0xFF36566F),
// //                 ),

// //                 const SizedBox(height: 20),

// //                 // Title
// //                 const Text(
// //                   "Lupa Password",
// //                   style: TextStyle(
// //                     fontSize: 24,
// //                     fontWeight: FontWeight.bold,
// //                     color: Color(0xFF36566F),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 10),

// //                 // Subtitle
// //                 const Text(
// //                   "Reset Password",
// //                   style: TextStyle(
// //                     fontSize: 18,
// //                     color: Color(0xFF36566F),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 15),

// //                 // Description
// //                 const Text(
// //                   "Masukan email dan password baru\nuntuk melanjutkan, kami akan\nmengirimkan kode verifikasi ke email Anda",
// //                   textAlign: TextAlign.center,
// //                   style: TextStyle(
// //                     color: Colors.black54,
// //                     fontSize: 14,
// //                   ),
// //                 ),

// //                 const SizedBox(height: 30),

// //                 // Email TextField with Send Button
// //                 Container(
// //                   decoration: BoxDecoration(
// //                     border: Border.all(color: Colors.grey),
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                   child: Row(
// //                     children: [
// //                       const Padding(
// //                         padding: EdgeInsets.only(left: 12),
// //                         child: Icon(Icons.email, color: Color(0xFF36566F)),
// //                       ),

// //                       const SizedBox(height: 20),

// //                       const Icon(Icons.lock,
// //                           size: 80, color: Color(0xFF36566F)),

// //                       const SizedBox(height: 20),

// //                       // Input Email
// //                       TextField(
// //                         controller: emailController,
// //                         decoration: const InputDecoration(
// //                           prefixIcon:
// //                               Icon(Icons.email, color: Color(0xFF36566F)),
// //                           labelText: "Gmail.com",
// //                           border: OutlineInputBorder(),
// //                         ),
// //                       ),
// //                       const SizedBox(height: 15),

// //                       // Input New Password
// //                       TextField(
// //                         controller: newPasswordController,
// //                         obscureText: true,
// //                         decoration: const InputDecoration(
// //                           prefixIcon:
// //                               Icon(Icons.lock, color: Color(0xFF36566F)),
// //                           labelText: "new password",
// //                           border: OutlineInputBorder(),
// //                         ),
// //                       ),
// //                       const SizedBox(height: 15),

// //                       // Input Confirm Password
// //                       TextField(
// //                         controller: konfirmasiPasswordController,
// //                         obscureText: true,
// //                         // decoration: const InputDecoration(
// //                         //   prefixIcon: Icon(
// //                         //     Icons.lock_outline,
// //                         //   ),
// //                         decoration: InputDecoration(
// //                           prefixIcon:
// //                               Icon(Icons.security, color: Color(0xFF36566F)),
// //                           labelText: "confirm password",
// //                           border: OutlineInputBorder(),
// //                         ),
// //                       ),
// //                       const SizedBox(height: 15),

// //                       // Input Captcha
// //                       Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           const Text(
// //                             "code captcha*",
// //                             style: TextStyle(
// //                               color: Colors.red,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                           const SizedBox(height: 5),
// //                           Row(
// //                             children: [
// //                               Container(
// //                                 width: 100,
// //                                 height: 40,
// //                                 alignment: Alignment.center,
// //                                 decoration: BoxDecoration(
// //                                   color: Colors.grey[300],
// //                                   borderRadius: BorderRadius.circular(5),
// //                                 ),
// //                                 child: const Text(
// //                                   "A1B2C",
// //                                   style: TextStyle(
// //                                       fontWeight: FontWeight.bold,
// //                                       fontSize: 16),
// //                                 ),
// //                               ),
// //                               const SizedBox(width: 10),
// //                               const Expanded(
// //                                 child: TextField(
// //                                   decoration: InputDecoration(
// //                                     hintText: "Tulis code disamping",
// //                                     border: OutlineInputBorder(),
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),

// //                       const SizedBox(height: 25),

// //                       SizedBox(
// //                         width: double.infinity,
// //                         child: ElevatedButton(
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: const Color(0xFF36566F),
// //                             padding: const EdgeInsets.symmetric(vertical: 15),
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(30),
// //                             ),
// //                           ),
// //                           onPressed: () async {
// //                             try {
// //                               var data = await Apiservice.reset_password(
// //                                 emailController.text.trim(),
// //                                 newPasswordController.text.trim(),
// //                               );

// //                               if (data['status'] == 'success') {
// //                                 ScaffoldMessenger.of(context).showSnackBar(
// //                                   SnackBar(content: Text(data['message'])),
// //                                 );
// //                                 Navigator.pop(context);
// //                               } else {
// //                                 ScaffoldMessenger.of(context).showSnackBar(
// //                                   SnackBar(
// //                                     content: Text(data['message'] ??
// //                                         'Gagal reset password'),
// //                                   ),
// //                                 );
// //                               }
// //                             } catch (e) {
// //                               ScaffoldMessenger.of(context).showSnackBar(
// //                                 SnackBar(
// //                                   content: Text("Terjadi kesalahan: $e"),
// //                                 ),
// //                               );
// //                             }
// //                           },
// //                           child: const Text(
// //                             "Submit",
// //                             style: TextStyle(fontSize: 18, color: Colors.white),
// //                     //   Expanded(
// //                     //     child: TextField(
// //                     //       decoration: const InputDecoration(
// //                     //         hintText: "Email",
// //                     //         border: InputBorder.none,
// //                     //         contentPadding: EdgeInsets.symmetric(horizontal: 12),
// //                     //       ),
// //                     //     ),
// //                     //   ),
// //                     //   Container(
// //                     //     margin: const EdgeInsets.all(4),
// //                     //     decoration: BoxDecoration(
// //                     //       color: const Color(0xFF36566F),
// //                     //       borderRadius: BorderRadius.circular(6),
// //                     //     ),
// //                     //     child: IconButton(
// //                     //       icon: const Icon(Icons.send, color: Colors.white, size: 20),
// //                     //       onPressed: () {
// //                     //         // Handle send verification code
// //                     //       },
// //                     //     ),
// //                     //   ),
// //                     // ],
// //                   ),
// //                 )),

// //                 const SizedBox(height: 15),

// //                 // Token Verification TextField
// //                 TextField(
// //                   decoration: InputDecoration(
// //                     prefixIcon: const Icon(
// //                       Icons.pin,
// //                       color: Color(0xFF36566F),
// //                     ),
// //                     hintText: "Kode Verifikasi",
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(8),
// //                     ),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 15),

// //                 // New Password TextField
// //                 TextField(
// //                   obscureText: true,
// //                   decoration: InputDecoration(
// //                     prefixIcon: const Icon(
// //                       Icons.lock,
// //                       color: Color(0xFF36566F),
// //                     ),
// //                     hintText: "New Password",
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(8),
// //                     ),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 15),

// //                 // Confirm Password TextField
// //                 TextField(
// //                   obscureText: true,
// //                   decoration: InputDecoration(
// //                     prefixIcon: const Icon(
// //                       Icons.lock,
// //                       color: Color(0xFF36566F),
// //                     ),
// //                     hintText: "Confirm Password",
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(8),
// //                     ),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 30),

// //                 // Submit Button
// //                 SizedBox(
// //                   width: double.infinity,
// //                   child: ElevatedButton(
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: const Color(0xFF36566F),
// //                       padding: const EdgeInsets.symmetric(vertical: 15),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(8),
// //                       ),
// //                     ),
// //                     onPressed: () {
// //                       // Handle submit
// //                     },
// //                     child: const Text(
// //                       "Submit",
// //                       style: TextStyle(fontSize: 16, color: Colors.white),
// //                     ),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 15),

// //                 // Cancel Button
// //                 SizedBox(
// //                   width: double.infinity,
// //                   child: OutlinedButton(
// //                     style: OutlinedButton.styleFrom(
// //                       padding: const EdgeInsets.symmetric(vertical: 15),
// //                       side: const BorderSide(color: Color(0xFF36566F)),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(8),
// //                       ),
// //                     ),
// //                     onPressed: () {
// //                       Navigator.pop(context);
// //                     },
// //                     child: const Text(
// //                       "Cancel",
// //                       style: TextStyle(
// //                         fontSize: 16,
// //                         color: Color(0xFF36566F),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import '../services/auth_servise.dart';
// import 'package:flutter/material.dart';

// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController konfirmasiPasswordController =
//       TextEditingController();
//   final TextEditingController captchaController = TextEditingController();
//   final TextEditingController oldPasswordController = TextEditingController();

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
//               children: [
//                 const Icon(Icons.lock_reset,
//                     size: 80, color: Color(0xFF36566F)),
//                 const SizedBox(height: 15),
//                 const Text(
//                   "Lupa Password",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF36566F),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   "Masukkan email dan password baru Anda",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 14, color: Colors.black54),
//                 ),
//                 const SizedBox(height: 25),

//                 // Email
//                 TextField(
//                   controller: emailController,
//                   decoration: const InputDecoration(
//                     prefixIcon: Icon(Icons.email, color: Color(0xFF36566F)),
//                     labelText: "Email",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 15),

//                 // New password
//                 TextField(
//                   controller: newPasswordController,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     prefixIcon: Icon(Icons.lock, color: Color(0xFF36566F)),
//                     labelText: "Password Baru",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 15),

//                 // Confirm password
//                 TextField(
//                   controller: konfirmasiPasswordController,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     prefixIcon:
//                         Icon(Icons.lock_outline, color: Color(0xFF36566F)),
//                     labelText: "Konfirmasi Password",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Captcha
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Kode Captcha *",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Row(
//                       children: [
//                         Container(
//                           width: 100,
//                           height: 40,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: const Text(
//                             "A1B2C",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: TextField(
//                             controller: captchaController,
//                             decoration: const InputDecoration(
//                               hintText: "Tulis kode di samping",
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 25),

//                 // Tombol Submit
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
//                     onPressed: () async {
//                       if (newPasswordController.text !=
//                           konfirmasiPasswordController.text) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("Password tidak sama")),
//                         );
//                         return;
//                       }

//                       try {
//                         final data = await ApiService.reset_Password(
//                             emailController.text.trim(),
//                             oldPasswordController.text.trim(),
//                             newPasswordController.text.trim());

//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text(data['message'] ?? 'Gagal')),
//                         );

//                         if (data['status'] == 'success') {
//                           Navigator.pop(context);
//                         }
//                       } catch (e) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Terjadi kesalahan: $e')),
//                         );
//                       }
//                     },
//                     child: const Text(
//                       "Submit",
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),

//                 // Tombol Cancel
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
//                     onPressed: () => Navigator.pop(context),
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
// import 'package:flutter/material.dart';

// class ForgotPasswordScreen extends StatelessWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF36566F),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   const Text(
//                     "LUPA PASSWORD",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )
//                 ],
//               ),
//             ),

//             // Card Konten
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
//                       // Ikon cap wisuda
//                       const Icon(Icons.school,
//                           size: 50, color: Color(0xFF36566F)),
//                       const SizedBox(height: 10),

//                       const Text(
//                         "Lupa password",
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF36566F),
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       const Text(
//                         "Masukan email dan password baru untuk melanjutkan. "
//                         "Kami akan mengirimkan kode verifikasi ke email Anda.",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.black54, fontSize: 14),
//                       ),

//                       const SizedBox(height: 20),

//                       const Icon(Icons.lock,
//                           size: 80, color: Color(0xFF36566F)),

//                       const SizedBox(height: 20),

//                       // Input Email
//                       const TextField(
//                         decoration: InputDecoration(
//                           prefixIcon:
//                               Icon(Icons.email, color: Color(0xFF36566F)),
//                           labelText: "Gmail.com",
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       // Input Code Verifikasi
//                       const TextField(
//                         decoration: InputDecoration(
//                           prefixIcon:
//                               Icon(Icons.verified, color: Color(0xFF36566F)),
//                           labelText: "code verifikasi",
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       // Input New Password
//                       const TextField(
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           prefixIcon:
//                               Icon(Icons.lock, color: Color(0xFF36566F)),
//                           labelText: "new password",
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       // Input Confirm Password
//                       const TextField(
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.lock_outline,
//                               color: Color(0xFF36566F)),
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

//                       // Tombol Submit
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
//                           onPressed: () {},
//                           child: const Text(
//                             "Submit",
//                             style: TextStyle(fontSize: 18, color: Colors.white),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 10),

//                       // Tombol Cancel
//                       SizedBox(
//                         width: double.infinity,
//                         child: OutlinedButton(
//                           style: OutlinedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 15),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Text(
//                             "Cancel",
//                             style: TextStyle(fontSize: 18, color: Colors.black),
//                           ),
//                         ),
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
// import 'package:flutter/material.dart';

// class ForgotPasswordScreen extends StatelessWidget {
//   const ForgotPasswordScreen({super.key});

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
//                       Expanded(
//                         child: TextField(
//                           decoration: const InputDecoration(
//                             hintText: "Email",
//                             border: InputBorder.none,
//                             contentPadding:
//                                 EdgeInsets.symmetric(horizontal: 12),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF36566F),
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: IconButton(
//                           icon: const Icon(Icons.send,
//                               color: Colors.white, size: 20),
//                           onPressed: () {
//                             // Handle send verification code
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

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

// UDAH HAMPIR BETUL
// import 'package:flutter/material.dart';
// import 'package:SPMB/services/auth_servise.dart'; // pastikan nama file dan class-nya benar (auth_service.dart)

// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   bool isLoading = false;
//   bool otpSent = false;

//   @override
//   void dispose() {
//     emailController.dispose();
//     otpController.dispose();
//     newPasswordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }

//   void showSnack(String message) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(message)));
//   }

//   // Fungsi kirim OTP ke email
//   Future<void> sendOtp() async {
//     String email = emailController.text.trim();

//     if (email.isEmpty) {
//       showSnack("Email wajib diisi");
//       return;
//     }

//     setState(() => isLoading = true);

//     try {
//       var result = await ApiService.sendVerification(email);
//       showSnack(result['message']);

//       if (result['status'] == 'success') {
//         setState(() => otpSent = true);
//       }
//     } catch (e) {
//       showSnack("Terjadi kesalahan koneksi");
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   // Fungsi verifikasi OTP dan ubah password
//   Future<void> verifyAndReset() async {
//     String email = emailController.text.trim();
//     String otp = otpController.text.trim();
//     String newPass = newPasswordController.text.trim();
//     String confirmPass = confirmPasswordController.text.trim();

//     if ([email, otp, newPass, confirmPass].any((e) => e.isEmpty)) {
//       showSnack("Semua field wajib diisi");
//       return;
//     }

//     if (newPass != confirmPass) {
//       showSnack("Password tidak sama");
//       return;
//     }

//     setState(() => isLoading = true);

//     try {
//       // verifikasi otp
//       var verify = await ApiService.verifyOtp(email, otp);

//       if (verify['status'] == 'success') {
//         // reset password
//         var reset = await ApiService.forgotPassword(email, newPass);
//         showSnack(reset['message']);
//       } else {
//         showSnack(verify['message']);
//       }
//     } catch (e) {
//       showSnack("Gagal menghubungi server");
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

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
//                 const Icon(Icons.lock_reset,
//                     size: 80, color: Color(0xFF36566F)),
//                 const SizedBox(height: 20),
//                 const Text(
//                   "Lupa Password",
//                   style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF36566F)),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text("Reset Password",
//                     style: TextStyle(fontSize: 18, color: Color(0xFF36566F))),
//                 const SizedBox(height: 15),
//                 const Text(
//                   "Masukkan email Anda, kami akan mengirimkan\nkode verifikasi untuk reset password.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.black54, fontSize: 14),
//                 ),
//                 const SizedBox(height: 30),

//                 // Email field + send OTP
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
//                       Expanded(
//                         child: TextField(
//                           controller: emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: const InputDecoration(
//                             hintText: "Email",
//                             border: InputBorder.none,
//                             contentPadding:
//                                 EdgeInsets.symmetric(horizontal: 12),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF36566F),
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: IconButton(
//                           icon: isLoading
//                               ? const SizedBox(
//                                   height: 16,
//                                   width: 16,
//                                   child: CircularProgressIndicator(
//                                     color: Colors.white,
//                                     strokeWidth: 2,
//                                   ),
//                                 )
//                               : const Icon(Icons.send,
//                                   color: Colors.white, size: 20),
//                           onPressed: () async {
//                             String email = emailController.text.trim();
//                             if (email.isEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text("Email wajib diisi")),
//                               );
//                               return;
//                             }

//                             var result =
//                                 await ApiService.sendVerification(email);

//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text(result['message'])),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 if (otpSent) ...[
//                   const SizedBox(height: 20),

//                   // OTP Field
//                   TextField(
//                     controller: otpController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       prefixIcon:
//                           const Icon(Icons.pin, color: Color(0xFF36566F)),
//                       hintText: "Kode Verifikasi",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 15),

//                   // New Password
//                   TextField(
//                     controller: newPasswordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       prefixIcon:
//                           const Icon(Icons.lock, color: Color(0xFF36566F)),
//                       hintText: "Password Baru",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 15),

//                   // Confirm Password
//                   TextField(
//                     controller: confirmPasswordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       prefixIcon:
//                           const Icon(Icons.lock, color: Color(0xFF36566F)),
//                       hintText: "Konfirmasi Password",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   // Submit
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF36566F),
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: isLoading ? null : verifyAndReset,
//                       child: isLoading
//                           ? const SizedBox(
//                               height: 18,
//                               width: 18,
//                               child: CircularProgressIndicator(
//                                 color: Colors.white,
//                                 strokeWidth: 2,
//                               ),
//                             )
//                           : const Text(
//                               "Submit",
//                               style:
//                                   TextStyle(fontSize: 16, color: Colors.white),
//                             ),
//                     ),
//                   ),
//                 ],

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
//                     onPressed: () => Navigator.pop(context),
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

// SUDAH FIKS
import 'package:flutter/material.dart';
import 'package:SPMB/services/auth_servise.dart'; // pastikan file ini benar

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;
  bool otpSent = false;

  void showSnack(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // Kirim kode OTP ke email
  Future<void> sendOtp() async {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      showSnack("Email wajib diisi");
      return;
    }

    setState(() => isLoading = true);

    try {
      var result = await ApiService.sendVerification(email);
      showSnack(result['message']);

      if (result['status'] == 'success') {
        setState(() => otpSent = true);
      }
    } catch (e) {
      showSnack("Terjadi kesalahan koneksi");
    } finally {
      setState(() => isLoading = false);
    }
  }

  // Verifikasi OTP dan ubah password
  Future<void> verifyAndReset() async {
    String email = emailController.text.trim();
    String otp = otpController.text.trim();
    String newPass = newPasswordController.text.trim();
    String confirmPass = confirmPasswordController.text.trim();

    if ([email, otp, newPass, confirmPass].any((e) => e.isEmpty)) {
      showSnack("Semua field wajib diisi");
      return;
    }

    if (newPass != confirmPass) {
      showSnack("Password tidak sama");
      return;
    }

    setState(() => isLoading = true);

    try {
      var verify = await ApiService.verifyOtp(email, otp);

      if (verify['status'] == 'success') {
        var reset = await ApiService.forgotPassword(email, newPass);
        showSnack(reset['message']);
      } else {
        showSnack(verify['message']);
      }
    } catch (e) {
      showSnack("Gagal menghubungi server");
    } finally {
      setState(() => isLoading = false);
    }
  }

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
                const Icon(Icons.lock_reset,
                    size: 80, color: Color(0xFF36566F)),
                const SizedBox(height: 20),
                const Text(
                  "Lupa Password",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF36566F),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 18, color: Color(0xFF36566F)),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Masukan email dan password baru\nuntuk melanjutkan, kami akan\nmengirimkan kode verifikasi ke email Anda",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 30),

                // ====== EMAIL + SEND BUTTON ======
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
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Email",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
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
                          icon: isLoading
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.send,
                                  color: Colors.white, size: 20),
                          onPressed: isLoading ? null : sendOtp,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // ====== OTP FIELD ======
                TextField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.pin, color: Color(0xFF36566F)),
                    hintText: "Kode Verifikasi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // ====== NEW PASSWORD ======
                TextField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.lock, color: Color(0xFF36566F)),
                    hintText: "Password Baru",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // ====== CONFIRM PASSWORD ======
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.lock, color: Color(0xFF36566F)),
                    hintText: "Konfirmasi Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // ====== SUBMIT BUTTON ======
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
                    onPressed: isLoading ? null : verifyAndReset,
                    child: isLoading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Submit",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                ),

                const SizedBox(height: 15),

                // ====== CANCEL BUTTON ======
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
                      style: TextStyle(fontSize: 16, color: Color(0xFF36566F)),
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

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   bool isSending = false;
//   bool isSubmitting = false;

//   Future<void> sendVerificationCode() async {
//     if (emailController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Email wajib diisi")),
//       );
//       return;
//     }

//     setState(() => isSending = true);
//     final response = await http.post(
//       Uri.parse("http://44.220.159.46/api/send_email.php"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({"email": emailController.text}),
//     );

//     setState(() => isSending = false);
//     final data = jsonDecode(response.body);

//     if (data["status"] == "success") {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text("Kode verifikasi telah dikirim ke email Anda")),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(data["message"] ?? "Gagal mengirim kode")),
//       );
//     }
//   }

//   Future<void> resetPassword() async {
//     if (emailController.text.isEmpty ||
//         otpController.text.isEmpty ||
//         newPasswordController.text.isEmpty ||
//         confirmPasswordController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Semua field wajib diisi")),
//       );
//       return;
//     }

//     if (newPasswordController.text != confirmPasswordController.text) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Konfirmasi password tidak cocok")),
//       );
//       return;
//     }

//     // Konfirmasi sebelum reset password
//     final confirm = await showDialog<bool>(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Konfirmasi"),
//         content: const Text("Apakah Anda yakin ingin mereset password ini?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context, true),
//             child: const Text("Ya"),
//           ),
//         ],
//       ),
//     );

//     if (confirm != true) return; // Jika tekan Cancel

//     setState(() => isSubmitting = true);

//     final response = await http.post(
//       Uri.parse("http://44.220.159.46/api/forgot_password.php"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "email": emailController.text,
//         "otp": otpController.text,
//         "new_password": newPasswordController.text,
//       }),
//     );

//     setState(() => isSubmitting = false);
//     final data = jsonDecode(response.body);

//     if (data["status"] == "success") {
//       await showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: const Text("Berhasil"),
//           content: const Text(
//               "Password Anda berhasil direset. Silakan login kembali."),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("OK"),
//             ),
//           ],
//         ),
//       );
//       Navigator.pop(context); // Kembali ke halaman login
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(data["message"] ?? "Gagal mereset password")),
//       );
//     }
//   }

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
//                 const Icon(Icons.lock_reset,
//                     size: 80, color: Color(0xFF36566F)),
//                 const SizedBox(height: 20),
//                 const Text("Lupa Password",
//                     style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF36566F))),
//                 const SizedBox(height: 10),
//                 const Text("Reset Password",
//                     style: TextStyle(fontSize: 18, color: Color(0xFF36566F))),
//                 const SizedBox(height: 15),
//                 const Text(
//                   "Masukan email dan password baru\nuntuk melanjutkan, kami akan\nmengirimkan kode verifikasi ke email Anda",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.black54, fontSize: 14),
//                 ),
//                 const SizedBox(height: 30),

//                 // Email field + Send button
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
//                       Expanded(
//                         child: TextField(
//                           controller: emailController,
//                           decoration: const InputDecoration(
//                             hintText: "Email",
//                             border: InputBorder.none,
//                             contentPadding:
//                                 EdgeInsets.symmetric(horizontal: 12),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF36566F),
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: IconButton(
//                           icon: isSending
//                               ? const Icon(Icons.hourglass_empty,
//                                   color: Colors.white)
//                               : const Icon(Icons.send,
//                                   color: Colors.white, size: 20),
//                           onPressed: isSubmitting ? null : sendVerificationCode,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 15),

//                 TextField(
//                   controller: otpController,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.pin, color: Color(0xFF36566F)),
//                     hintText: "Kode Verifikasi",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8)),
//                   ),
//                 ),
//                 const SizedBox(height: 15),

//                 TextField(
//                   controller: newPasswordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     prefixIcon:
//                         const Icon(Icons.lock, color: Color(0xFF36566F)),
//                     hintText: "Password Baru",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8)),
//                   ),
//                 ),
//                 const SizedBox(height: 15),

//                 TextField(
//                   controller: confirmPasswordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     prefixIcon:
//                         const Icon(Icons.lock, color: Color(0xFF36566F)),
//                     hintText: "Konfirmasi Password",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8)),
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF36566F),
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                     ),
//                     onPressed: isSending ? null : resetPassword,
//                     child: isSubmitting
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text("Submit",
//                             style:
//                                 TextStyle(fontSize: 16, color: Colors.white)),
//                   ),
//                 ),
//                 const SizedBox(height: 15),

//                 SizedBox(
//                   width: double.infinity,
//                   child: OutlinedButton(
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       side: const BorderSide(color: Color(0xFF36566F)),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                     ),
//                     onPressed: () => Navigator.pop(context),
//                     child: const Text("Cancel",
//                         style:
//                             TextStyle(fontSize: 16, color: Color(0xFF36566F))),
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
