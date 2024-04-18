import 'package:flutter/material.dart';
import 'dart:async';
import 'package:werehouse/introduction_animation/introduction_animation_screen.dart'; // Ganti dengan lokasi file IntroductionAnimationScreen.dart Anda

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => IntroductionAnimationScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffF7EBE1),// Ganti dengan warna latar belakang yang diinginkan
        ),
        child: Center(
        child: Image.asset(
          'assets/introduction_animation/logo_bpbd.png',
          width: 150, // Sesuaikan dengan lebar yang diinginkan
          height: 150, // Sesuaikan dengan tinggi yang diinginkan
          fit: BoxFit.contain, // Atur sesuai kebutuhan Anda
        ),
      ),
      ),
    );
  }
}