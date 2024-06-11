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
                  '1             berfungsi untuk melakukan pendataan barang yang baru datang dari supplier.',
                  '2           berfungsi untuk pendataan baru terkait data supplier yang telah memberikan barang.',
                  '3             berfungsi untuk melakukan pengiriman barang kepada user.',
                  '4              berfungsi untuk menginput barang masuk ataupun barang keluar.',
                ].map((text) {
                  if (text.startsWith('1')) {
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
                              'assets/icons/laporan.svg',
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
                                    text: 'Fitur Logistik Masuk ',
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
                  } else if (text.startsWith('2')) {
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
                              'assets/icons/scan.svg',
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
                                    text: 'Fitur Data Supplier',
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
                  } else if (text.startsWith('3')) {
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
                              'assets/icons/bantuan.svg',
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
                                    text: 'Fitur Logistik Keluar',
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
                  } else if (text.startsWith('4')) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: green2,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/barang.svg',
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
                                    text: 'Fitur Barang',
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
                  } else {
                    return Container(); // Mengembalikan widget kosong jika tidak cocok dengan kondisi apapun
                  }
                }).toList(), // Menjadikan hasil dari map menjadi list
              ],
            ),
          ),
        ],
      ),
    );
  }
}
