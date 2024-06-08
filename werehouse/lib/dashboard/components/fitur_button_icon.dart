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
    case 'laporan':
      return Icons.description;
    case 'scan':
      return Icons.scanner;
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
    icon: 'laporan',
    title: 'Laporan',
    color: Colors.green,
    onPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => fitur_laporan()),
      );
    },
  ),
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
    icon: 'scan',
    title: 'Scan',
    color: Colors.red,
    onPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RootApp()),
      );
    },
  ),
   ButtonIcon(
    icon: 'akun',
    title: 'Logistik Masuk',
    color: Colors.green,
    onPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LogistikMasuk()),
      );
    },
  ),
  ButtonIcon(
    icon: 'barang',
    title: 'Data Logistik',
    color: Colors.green,
    onPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DataLogistik()),
      );
    },
  ),
   ButtonIcon(
    icon: 'notif',
    title: 'Pesan',
    color: Colors.blue,
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
      padding: const EdgeInsets.only(left: 27, right: 27, top: 32),
      child: SizedBox(
        height: 157,
        child: GridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          children: [
            ...menuIcons.map(
              (icon) => Column(
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
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            icon.icon == 'goclub' ? Colors.white : icon.color,
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
                  const SizedBox(height: 9),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      icon.title,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}