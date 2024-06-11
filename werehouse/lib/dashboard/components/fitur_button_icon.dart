import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:werehouse/dashboard/component_laporan/fitur_laporan.dart';
import 'package:werehouse/dashboard/component_pengiriman_barang/accept_barang.dart';
import 'package:werehouse/dashboard/component_setting/screens/account_screen.dart';
import 'package:werehouse/dashboard/components/cobaLogistikMasuk.dart';
import 'package:werehouse/dashboard/components/logistik_keluar.dart';
import 'package:werehouse/dashboard/components/data_logistik.dart';
import 'package:werehouse/dashboard/components/logistik_masuk.dart';
import 'package:werehouse/dashboard/components/data_supplier.dart';
import 'package:werehouse/dashboard/profile.dart';

class ButtonIcon {
  final String icon;
  final String title;
  final Color? color;
  final Function(BuildContext) onPressed;

  ButtonIcon({
    required this.icon,
    required this.title,
    this.color,
    required this.onPressed,
  });
}

IconData getIcon(String iconName) {
  switch (iconName) {
    case 'bantuan':
      return Icons.help;
    case 'barang':
      return Icons.shopping_basket;
    case 'setting':
      return Icons.settings;
    case 'akun':
      return Icons.account_circle;
    case 'goclub':
      return Icons.group_add;
    case 'other':
      return Icons.apps;
    default:
      return Icons.error;
  }
}

List<ButtonIcon> menuIcons = [
  ButtonIcon(
    icon: 'bantuan',
    title: 'Logistik Keluar',
    color: Colors.blue,
    onPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => barang_keluar()), // Ganti dengan rute yang sesuai
      ).then((_) {
        // Panggil parentSetState jika diperlukan untuk memperbarui state dari widget induk
      });
    },
  ),
  ButtonIcon(
    icon: 'setting',
    title: 'Pengaturan',
    color: Colors.green,
    onPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AccountScreen()),
      );
    },
  ),
  
  ButtonIcon(
    icon: 'barang',
    title: 'Data Logistik',
    color: Colors.red,
    onPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DataLogistik()),
      );
    },
  ),
   ButtonIcon(
    icon: 'akun',
    title: 'Logistik Masuk',
    color: Colors.blue,
    onPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LogistikMasuk()),
      );
    },
  ),
   ButtonIcon(
    icon: 'notif',
    title: 'Pesan',
    color: Colors.green,
    onPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  AcceptBarang()),
      );
    },
  ),
  ButtonIcon(
    icon: 'barang',
    title: 'Data Supplier',
    color: Colors.red,
    onPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DataSupplier()),
      );
    },
  ),
   
  // Daftar tombol lainnya disini
];
class Menus extends StatelessWidget {
  final void Function() onPressed;
  final void Function() parentSetState;

  const Menus({
    Key? key,
    required this.onPressed,
    required this.parentSetState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1), // Atur padding
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Atur posisi start agar mulai dari atas
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            children: menuIcons.take(3).map((icon) {
              return buildMenuIcon(icon, context);
            }).toList(),
          ),
          
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            children: menuIcons.skip(3).map((icon) {
              return buildMenuIcon(icon, context);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildMenuIcon(ButtonIcon icon, BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text("Loading ..."),
                  ],
                ),
                duration: Duration(seconds: 1),
              ),
            );

            Future.delayed(Duration(seconds: 1), () {
              icon.onPressed(context);
            });
          },
          child: Container(
            width: 44,
            height: 45,
            decoration: BoxDecoration(
              color: icon.icon == 'goclub' ? Colors.white : icon.color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SvgPicture.asset(
              'assets/icons/${icon.icon}.svg',
              color: icon.icon == 'goclub'
                  ? icon.color
                  : icon.icon == 'other'
                      ? Colors.black
                      : Colors.white,
              width: 24,
            ),
          ),
        ),
        const SizedBox(height: 4), // Mengurangi jarak antara icon dan teks
        Text(
          icon.title,
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
