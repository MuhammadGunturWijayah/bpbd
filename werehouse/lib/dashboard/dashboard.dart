import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:werehouse/pages/home_page.dart';
import 'package:werehouse/pages/settings_page.dart';
import 'package:werehouse/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool isDark =
      (await SharedPreferences.getInstance()).getBool('isDark') ?? true;

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(isDark: isDark),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int selectedIndex = 0;
  final destinationViews = const [
    HomePage(),
    SizedBox(),
    SizedBox(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeNotifier>(context, listen: true);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData.getTheme(),
      home: Scaffold(
        body: destinationViews[selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          indicatorColor: Colors.white,
          destinations: [
            NavigationDestination(
              tooltip: "Home",
              selectedIcon: Icon(
                IconlyBold.home,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: Icon(
                IconlyLight.home,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: "Home",
            ),
            NavigationDestination(
              selectedIcon: Icon(
                IconlyBold.wallet,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: Icon(
                Icons.inventory_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: "Stok",
            ),
            NavigationDestination(
              selectedIcon: Icon(
                IconlyBold.graph,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: Icon(
                IconlyBold.scan,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: "Scan",
            ),
            NavigationDestination(
              selectedIcon: Icon(
                IconlyBold.setting,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: Icon(
                IconlyLight.setting,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Color indicatorColor;
  final List<NavigationDestination> destinations;

  const NavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.indicatorColor,
    required this.destinations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onDestinationSelected,
      selectedItemColor: indicatorColor,
      items: destinations.map((destination) {
        return BottomNavigationBarItem(
          icon: destination.icon,
          label: destination.label,
          tooltip: destination.tooltip,
        );
      }).toList(),
    );
  }
}

class NavigationDestination {
  final String label;
  final String? tooltip;
  final Icon icon;
  final Icon? selectedIcon;

  NavigationDestination({
    required this.label,
    this.tooltip,
    required this.icon,
    this.selectedIcon,
  });
}
