import 'package:flutter/material.dart';
import 'package:werehouse/dashboard/components/dashboard.dart';
import 'package:werehouse/dashboard/components/info_lainnya.dart';
import 'package:werehouse/dashboard/components/menus.dart';
import 'package:werehouse/dashboard/components/news.dart';
import 'package:werehouse/dashboard/components/notif_permintaan.dart';
import 'package:werehouse/dashboard/components/search.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Search(),
            dashboard(),
            Menus(),
            GoCLub(),
            Akses(),
            News(),
          ],
        ),
      ),
       bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: Color.fromARGB(255, 214, 214, 214),
            height: 1,
            thickness: 1,
          ),
          BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.scanner),
                label: 'Scan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            selectedItemColor: Colors.blue, // Warna ikon yang dipilih
            unselectedItemColor: Colors.grey, // Warna ikon yang tidak dipilih
            currentIndex: 0, // Indeks ikon yang aktif secara default
            onTap: (index) {
              // Tambahkan logika untuk menangani ketika ikon ditekan
              // Contoh:
              // if (index == 0) {
              //   // Navigasi ke halaman home
              // } else if (index == 1) {
              //   // Navigasi ke halaman scan
              // } else if (index == 2) {
              //   // Navigasi ke halaman setting
              // }
            },
          ),
        ],
      ),
    );
  }
}