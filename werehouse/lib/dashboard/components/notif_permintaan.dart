import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:werehouse/dashboard/component_pengiriman_barang/accept_barang.dart';
import 'package:werehouse/dashboard/component_setting/setting_title.dart';
import 'package:werehouse/dashboard/component_setting/settings_screen.dart';
import 'package:werehouse/dashboard/components/bantuan.dart';
import 'package:werehouse/dashboard/components/barang.dart';
import 'package:werehouse/dashboard/profile.dart';
import 'package:werehouse/login/login_screen.dart';
import 'package:werehouse/login/welcome_screen.dart';
import 'package:werehouse/theme.dart';


class GoCLub extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? parentSetState; // Perbarui tipe properti menjadi VoidCallback
  const GoCLub({Key? key, this.onPressed, this.parentSetState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 19, left: 15, right: 15),
      child: GestureDetector(
        onTap: () {
          // Tampilkan indikator loading
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 1, // Atur ketebalan garis di sini
                    ),
                  ),
                  SizedBox(width: 16),
                  Text("Loading ..."),
                ],
              ),
              duration: Duration(seconds: 1), // Atur durasi sesuai kebutuhan
            ),
          );

          // Setelah loading selesai, tampilkan tampilan RootApp
          Future.delayed(Duration(seconds: 1), () {
            parentSetState?.call(); // Panggil setState dari parent widget
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AcceptBarang()), // Ganti dengan rute yang sesuai
            );
          });
        },
        child: Container(
          height: 65,
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFEAF3F6), Colors.white]),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: const Color(0xFFE8E8E8))),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/animasi_info.svg',
                      height: 40,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '5 Permintaan Untuk Dikirim',
                            style: semibold14.copyWith(color: dark1),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: LinearProgressIndicator(
                              backgroundColor: dark3,
                              color: green1,
                              value: .6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    SvgPicture.asset(
                      'assets/icons/left.svg',
                      height: 24,
                      color: dark1,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
