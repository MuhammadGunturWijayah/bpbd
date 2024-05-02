import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:werehouse/dashboard/component_laporan/fitur_laporan.dart';
import 'package:werehouse/dashboard/component_setting/settings_screen.dart';
import 'package:werehouse/dashboard/components/bantuan.dart';
import 'package:werehouse/dashboard/components/barang.dart';
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
    icon: 'scan',
    title: 'Scan',
    color: Colors.blue,
    onPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RootApp()),
      );
    },
  ),
  ButtonIcon(
    icon: 'bantuan',
    title: 'Bantuan',
    color: Colors.red,
    onPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                bantuan()), // Ganti dengan rute yang sesuai
      ).then((_) {
        // Panggil parentSetState jika diperlukan untuk memperbarui state dari widget induk
      });
    },
  ),
  ButtonIcon(
    icon: 'barang',
    title: 'Barang Masuk',
    color: Colors.green,
    onPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Barang()),
      );
    },
  ),
  ButtonIcon(
    icon: 'barangkeluar',
    title: 'Barang Keluar',
    color: Colors.green,
    onPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      );
    },
  ),
  ButtonIcon(
    icon: 'setting',
    title: 'Pengaturan',
    color: Colors.blue,
    onPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      );
    },
  ),
  ButtonIcon(
    icon: 'bantuan',
    title: 'Bantuan',
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
    title: 'Buat Akun',
    color: Colors.green,
    onPressed: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RootApp()),
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
                      // Tampilkan Snackbar dengan indikator loading
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

                      // Panggil onPressed dari ButtonIcon yang sesuai
                      icon.onPressed(context);
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
                  Text(
                    icon.title,
                    style: TextStyle(color: Colors.black),
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
