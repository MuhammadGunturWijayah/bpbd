import 'package:flutter/material.dart';

class BankCard extends StatelessWidget {
  final String cardBgAsset;
  final String balance;
  final String cardNumber;
  const BankCard({
    super.key,
    required this.cardBgAsset,
    required this.balance,
    required this.cardNumber,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
            image: AssetImage(cardBgAsset),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              ],
            ),
          ],
        ),
      ),
    );
  }
}
