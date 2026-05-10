import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Icon(
          Icons.inventory_2_outlined, // Logo kotak yang mirip di gambar
          size: 100,
          color: AppColor.primary,
        ),
      ),
    );
  }
}
