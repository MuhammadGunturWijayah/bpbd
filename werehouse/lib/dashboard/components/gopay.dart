import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:werehouse/dashboard/HomePageButton.dart';
import 'package:werehouse/theme.dart';

class Gopay extends StatelessWidget {
  const Gopay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 15,
        ),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
              color: blue1, borderRadius: BorderRadius.circular(15)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
             //gunturwijaya
            ],
          ),
        ));
  }
}
