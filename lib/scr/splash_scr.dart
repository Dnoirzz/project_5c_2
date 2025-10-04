import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'login_scr.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double radius = 90;
    List<IconData> icons = [
      Icons.menu_book,
      Icons.assignment,
      Icons.calendar_today,
      Icons.account_circle,
      Icons.notifications,
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF38536A),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            RotationTransition(
              turns: _rotationController,
              child: Stack(
                alignment: Alignment.center,
                children: List.generate(icons.length, (index) {
                  final angle = (2 * pi / icons.length) * index;

                  return Transform(
                    transform:
                        Matrix4.identity()
                          ..translate(radius * cos(angle), radius * sin(angle))
                          // rotasi tambahan agar sisi besar menghadap pusat
                          ..rotateZ(angle + pi),
                    alignment: Alignment.center,
                    child: Icon(icons[index], size: 40, color: Colors.white70),
                  );
                }),
              ),
            ),
            // Icon tengah tetap diam
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.school, size: 60, color: Colors.white),
            ),
            // Teks di bawah
            Positioned(
              bottom: 100,
              child: Column(
                children: const [
                  Text(
                    'PORTAL MAHASISWA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'POLNEP',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
