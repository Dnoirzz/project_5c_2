import 'package:flutter/material.dart';
import '../../widgets/appBar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
        title: 'Kebijakan Privasi',
        showBackButton: true,
        showProfileMenu: false,
      ),
      body: const Center(child: Text('Isi kebijakan privasi di sini')),
    );
  }
}