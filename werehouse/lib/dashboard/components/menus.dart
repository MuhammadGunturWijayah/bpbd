import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Your App'),
      ),
      body: YourWidget(),
    ),
  ));
}

class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: menuIcons.map((button) {
          return GestureDetector(
            onTap: () async {
              setState(() {
                isLoading = true;
              });
              await Future.delayed(Duration(seconds: 1)); // Tunggu 1 detik
              setState(() {
                isLoading = false;
              });
              button.onPressed(context); // Jalankan aksi setelah loading
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(getIcon(button.icon)),
                  SizedBox(width: 8.0),
                  Text(button.title),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
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
}

List<ButtonIcon> menuIcons = [
  ButtonIcon(
    icon: 'laporan',
    title: 'Laporan',
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
  final bool isLoading;
  final void Function(bool) setState;
  final void Function() onPressed;
  final void Function() parentSetState;

  const Menus({
    Key? key,
    required this.isLoading,
    required this.setState,
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
                      setState(true);
                      await Future.delayed(const Duration(seconds: 1));
                      setState(false);
                      onPressed();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
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
