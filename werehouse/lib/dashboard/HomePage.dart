import 'package:flutter/material.dart';
import 'package:werehouse/dashboard/components/akses.dart';
import 'package:werehouse/dashboard/components/goclub.dart';
import 'package:werehouse/dashboard/components/gopay.dart';
import 'package:werehouse/dashboard/components/header.dart';
import 'package:werehouse/dashboard/components/menus.dart';
import 'package:werehouse/dashboard/components/news.dart';
import 'package:werehouse/dashboard/components/search.dart';
import 'package:werehouse/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: green2,
          elevation: 0,
          toolbarHeight: 71,
          title: const Header()),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [Search(), Gopay(), Menus(), GoCLub(), Akses(), News()],
      )),
    );
  }
}
