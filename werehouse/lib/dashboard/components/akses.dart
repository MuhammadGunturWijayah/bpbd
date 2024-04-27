import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:werehouse/theme.dart';

class Akses extends StatelessWidget {
  const Akses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 16, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Info Lainnya',
            style: bold18.copyWith(color: dark1),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFFE8E8E8))),
            child: Column(
              children: [
                ...[
                  'Fitur laporan  berfungsi untuk mencetak laporan seperti pemasukan barang, pengeluaran barang dll.',
                  'Fitur Scan berfungsi untuk pendataan barang masuk maupun keluar',
                  'Fitur Bantua berfungsi untuk meminta barang kepada admin'
                ].map((text) {
                  if (text.startsWith('Fitur laporan')) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                color: blue1,
                                borderRadius: BorderRadius.circular(20)),
                            child: SvgPicture.asset(
                              'assets/icons/goride.svg',
                              color: Colors.white,
                              width: 24,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: RichText(
                              text: TextSpan(
                                style: regular14.copyWith(color: dark1),
                                children: [
                                  TextSpan(
                                    text: 'Fitur laporan',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: text.substring(14),
                                    style: regular14.copyWith(color: dark1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (text.startsWith('Fitur Scan')) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                color: green2,
                                borderRadius: BorderRadius.circular(20)),
                            child: SvgPicture.asset(
                              'assets/icons/goride.svg',
                              color: Colors.white,
                              width: 24,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: RichText(
                              text: TextSpan(
                                style: regular14.copyWith(color: dark1),
                                children: [
                                  TextSpan(
                                    text: 'Fitur Scan',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: text.substring(10),
                                    style: regular14.copyWith(color: dark1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                color: red,
                                borderRadius: BorderRadius.circular(20)),
                            child: SvgPicture.asset(
                              'assets/icons/goride.svg',
                              color: Colors.white,
                              width: 24,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: RichText(
                              text: TextSpan(
                                style: regular14.copyWith(color: dark1),
                                children: [
                                  TextSpan(
                                    text: 'Fitur Bantuan',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: text.substring(12),
                                    style: regular14.copyWith(color: dark1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
