import 'package:flutter/material.dart';
import '../../widgets/appBar.dart';
import 'reset_pass.dart';
import 'privacy_policy.dart';
import 'term_scr.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Settings',
        showBackButton: true,
        showProfileMenu: false,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Reset Password'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResetPasswordPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Kebijakan Privasi'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Ketentuan Pengguna'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TermsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
