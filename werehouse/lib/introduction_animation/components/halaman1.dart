import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  final AnimationController animationController;

  const SplashView({Key? key, required this.animationController})
      : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final _introductionanimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _introductionanimation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
             child: Padding(
              padding: EdgeInsets.only(top: 25.0), // Sesuaikan nilai top sesuai kebutuhan
              child: Image.asset(
                'assets/introduction_animation/orang1.png',
                fit: BoxFit.contain,
                width: 350.0,
                height: 350.0,
              ),
            ),
            ),
            SizedBox(height: 70),
           Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "WEREHOUSE BPBD",
                    style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ),

            Padding(
              padding: EdgeInsets.only(left: 64, right: 64),
              child: Text(
                "Badan Penanggulangan Bencana Daerah Kabupaten Jember.",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 48,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16),
              child: InkWell(
                onTap: () {
                  widget.animationController.animateTo(0.2);
                },
                child: Container(
                  height: 58,
                  padding: EdgeInsets.only(
                    left: 56.0,
                    right: 56.0,
                    top: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38.0),
                    color: Color.fromARGB(255, 48, 86, 210),
                  ),
                  child: Text(
                    "Selanjutnya",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
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
}