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
                icon: Icon(Icons.qr_code_2),
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
        ],
      ),
    );
  }
}