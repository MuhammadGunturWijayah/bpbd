import 'package:flutter/material.dart';
import 'package:werehouse/dashboard/component_pengiriman_barang/accept_barang.dart';
import 'package:werehouse/dashboard/component_setting/screens/account_screen.dart';
import 'package:werehouse/dashboard/components/iklan.dart';
import 'package:werehouse/dashboard/components/info_lainnya.dart';
import 'package:werehouse/dashboard/components/fitur_button_icon.dart';
import 'package:werehouse/dashboard/components/news.dart';
import 'package:werehouse/dashboard/components/notif_permintaan.dart';
import 'package:werehouse/dashboard/components/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Search(),
                const dashboard(),
                Menus(
                  onPressed: () {
                    // Implementasi logika yang diinginkan saat tombol di dalam Menus ditekan
                  },
                  parentSetState: () {
                    setState(() {}); // Contoh pemanggilan setState
                  },
                ),
                notif_permintaan(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    Future.delayed(const Duration(seconds: 1), () {
                      setState(() {
                        _isLoading = false;
                      });
                    });
                  },
                  parentSetState: () {
                    setState(
                        () {}); // Menggunakan lambda expression untuk setState
                  },
                ),
                const Akses(),
                const News(),
              ],
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                color: Color.fromARGB(255, 233, 233, 233),
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
                    icon: Icon(Icons.notifications_active),
                    label: 'Pesan',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
                onTap: (index) {
                  if (index == 1) {
                    // Jika item 'Settings' di tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AcceptBarang()),
                    );
                  } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountScreen()),
                      );
                    };
                },
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                currentIndex: 0,
              ),
            ],
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
