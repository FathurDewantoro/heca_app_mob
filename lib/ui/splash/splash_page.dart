import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heca_app_mob/services/auth/auth_gate.dart';
import 'package:heca_app_mob/ui/login/login_page.dart';
import 'package:heca_app_mob/utils/colors.dart';
import 'package:heca_app_mob/utils/screen_size.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Membuat delay 2 detik sebelum berpindah ke halaman berikutnya
    Timer(
      Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AuthGate()));
      }, // Ganti dengan halaman berikutnya
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Image.asset(
          'assets/images/logo/logo-square-white.png',
          width: ScreenSize.setWidth(context, 0.5),
        ),
      ),
    );
  }
}
