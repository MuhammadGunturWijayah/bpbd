import 'package:flutter/material.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  int currentImageIndex = 0;
  List<String> images3 = [
    "assets/images/iklan1.png",
    "assets/images/iklan_1.png",
    "assets/images/iklan1.png",
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
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              itemCount: images3.length,
              onPageChanged: (index) {
                setState(() {
                  currentImageIndex = index;
                });
                // Check if user reached the last image, then reset to the first image
                if (index == images3.length - 1) {
                  Future.delayed(Duration(milliseconds: 500), () {
                    // Add a delay to give smooth transition effect
                    _resetToFirstImage();
                  });
                }
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
            Positioned(
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images3.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentImageIndex == index
                          ? const Color.fromARGB(255, 255, 255, 255) // Warna untuk menandakan gambar aktif
                          : Colors.grey, // Warna untuk menandakan gambar tidak aktif
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to reset the PageView to the first image
  void _resetToFirstImage() {
    setState(() {
      currentImageIndex = 0;
    });
  }
}