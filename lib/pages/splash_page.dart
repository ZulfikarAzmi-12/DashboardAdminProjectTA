import 'package:admin_dashboard/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});


  @override
  Widget build(BuildContext context) {

    Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Icon(
          Icons.inventory_2_outlined, // Logo kotak yang mirip di gambar
          size: 100,
          color: Color(0xFF8B2323),
        ),
      ),
    );
  }
}