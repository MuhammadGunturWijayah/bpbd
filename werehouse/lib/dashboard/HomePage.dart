import 'package:flutter/material.dart';
import 'package:werehouse/dashboard/components/dashboard.dart';
import 'package:werehouse/dashboard/components/info_lainnya.dart';
import 'package:werehouse/dashboard/components/menus.dart';
import 'package:werehouse/dashboard/components/news.dart';
import 'package:werehouse/dashboard/components/notif_permintaan.dart';
import 'package:werehouse/dashboard/components/search.dart';
import 'package:werehouse/dashboard/components/notif_permintaan.dart';

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
                  isLoading: _isLoading,
                  setState: (bool value) {
                    setState(() {
                      _isLoading = value;
                    });
                  },
                  onPressed: () async {
                   
                     Future.delayed(const Duration(seconds: 1));
                    setState(() {
                      _isLoading = false;
                    });
                    // Implement your onPressed logic here
                  },
                  parentSetState: () {
                    setState(() {});
                  },
                ),
                GoCLub(
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
                  // Handle bottom navigation taps
                },
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
