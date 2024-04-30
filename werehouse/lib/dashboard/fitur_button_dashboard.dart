import 'package:flutter/material.dart';
import 'package:werehouse/dashboard/profile.dart';

class button_icon {
  final String icon;
  final String title;
  final Color? color;
  final Function(BuildContext) onPressed; // Change to Function(BuildContext)

  button_icon({
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

class YourWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: menuIcons.map((button) {
        return IconButton(
          icon: Icon(getIcon(button.icon)), // Use appropriate icon
          onPressed: () {
            if(button.onPressed != null) {
              button.onPressed!(context); // Pass the context here
            }
          },
        );
      }).toList(),
    );
  }

  IconData getIcon(String iconName) {
    switch(iconName) {
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

List<button_icon> menuIcons = [
  button_icon(
    icon: 'laporan',
    title: 'Laporan',
    color: Colors.green,
    onPressed: (context) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => RootApp()),);
    },
  ),
  // Daftar tombol lainnya disini
];

