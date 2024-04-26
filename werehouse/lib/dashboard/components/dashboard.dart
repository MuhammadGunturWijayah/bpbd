import 'package:flutter/material.dart';
import 'package:werehouse/dashboard/fitur_button_dashboard.dart';
import 'package:werehouse/theme.dart';

class Gopay extends StatefulWidget {
  const Gopay({Key? key}) : super(key: key);

  @override
  _GopayState createState() => _GopayState();
}

class _GopayState extends State<Gopay> {
  int currentImageIndex = 0;
  List<String> images3 = [
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 30,
      ),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: PageView.builder(
          itemCount: images3.length,
          onPageChanged: (index) {
            setState(() {
              currentImageIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: 344,
                  height: 180,
                  child: Image.asset(
                    images3[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
