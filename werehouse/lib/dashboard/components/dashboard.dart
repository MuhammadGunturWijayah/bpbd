import 'package:flutter/material.dart';
import 'package:werehouse/dashboard/fitur_button_dashboard.dart';
import 'package:werehouse/theme.dart';

class Gopay extends StatelessWidget {
  const Gopay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentImageIndex = 0;
    List<String> images3 = [
      "assets/images/1.png",
    ];

    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 30,
      ),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: blue1,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: 344,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(images3[
                          currentImageIndex]), // Ganti dengan path gambar dari list 'images3' dan indeks 'currentImageIndex'
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // Other widgets can go here if needed
          ],
        ),
      ),
    );
  }
}
