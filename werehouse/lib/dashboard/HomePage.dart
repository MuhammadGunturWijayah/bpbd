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
      bottomNavigationBar: BottomNavigationBar(
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
        selectedItemColor: Colors.blue, 
        unselectedItemColor: Colors.grey, 
        currentIndex: 0, 
        onTap: (index) {
         
        },
      ),
    );
  }
}

