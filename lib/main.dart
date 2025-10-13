import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'scr/splash_scr.dart'; // contoh halaman awal kamu

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null); // 🔥 tambahkan ini
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // sesuaikan dengan halaman awal kamu
    );
  }
}
