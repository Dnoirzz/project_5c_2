import 'package:flutter/material.dart';
import '../../widgets/appBar.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
        title: 'Ketentuan Pengguna',
        showBackButton: true,
        showProfileMenu: false,
      ),
      body: const Center(child: Text('Isi ketentuan pengguna di sini')),
    );
  }
}