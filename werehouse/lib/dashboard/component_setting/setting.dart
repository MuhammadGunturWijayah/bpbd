import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:werehouse/dashboard/HomePage.dart';
import 'package:werehouse/dashboard/component_setting/personal_data/personal_data.dart';

class Setting {
  final String title;
  final String route; // Merubah tipe dari Map<String, WidgetBuilder> menjadi String
  final IconData icon;

  Setting({
    required this.title,
    required this.route,
    required this.icon,
  });
}

final List<Setting> settings = [
  Setting(
    title: "Personal Data",
    route: '/PersonalDataPage', // Menggunakan string sebagai route
    icon: CupertinoIcons.person_fill,
  ),
  Setting(
    title: "Settings",
    route: '/SettingsPage',
    icon: Icons.settings,
  ),
  Setting(
    title: "E-Statements",
    route: '/EStatementsPage',
    icon: CupertinoIcons.doc_fill,
  ),
  Setting(
    title: "Referral Code",
    route: '/ReferralCodePage',
    icon: CupertinoIcons.heart_fill,
  ),
];

final List<Setting> settings2 = [
  Setting(
    title: "FAQ",
    route: '/FAQPage',
    icon: CupertinoIcons.ellipsis_vertical_circle_fill,
  ),
  Setting(
    title: "Our Handbook",
    route: '/HandbookPage',
    icon: CupertinoIcons.pencil_circle_fill,
  ),
  Setting(
    title: "Community",
    route: '/CommunityPage',
    icon: CupertinoIcons.person_3_fill,
  ),
];


void main() {
  runApp(MaterialApp(
    routes: {
      '/PersonalDataPage': (context) => PersonalDataPage(),
     
    },
    home:  HomePage(),
  ));
}