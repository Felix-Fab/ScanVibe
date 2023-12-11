import 'package:flutter/material.dart';
import 'package:scanvibe/Pages/Scanner.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  final List<Widget> pages = <Widget>[
    const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Search"),
          Icon(Icons.search),
        ],
      ),
    ),
    const Scanner(),
    const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Profil"),
          Icon(Icons.account_circle_rounded),
        ],
      ),
    ),
  ];

  final List<NavigationDestination> navigation = <NavigationDestination>[
    const NavigationDestination(
      selectedIcon: Icon(Icons.search),
      icon: Icon(Icons.search_outlined, color: Color(0xffffffff)),
      label: "Suche",
    ),
    const NavigationDestination(
      selectedIcon: Icon(Icons.qr_code),
      icon: Icon(Icons.qr_code_2_outlined, color: Color(0xffffffff)),
      label: "Scan",
    ),
    const NavigationDestination(
      selectedIcon: Icon(Icons.account_circle_rounded),
      icon: Icon(Icons.account_circle_outlined, color: Color(0xffffffff)),
      label: "Profil",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: pages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: const NavigationBarThemeData(
            indicatorColor: Color(0xffffffff),

          ),
          child: NavigationBar(
            backgroundColor: const Color(0xff388e3c),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            height: 60,
            onDestinationSelected: (int newIndex){
              setState(() {
                _selectedIndex = newIndex;
              });
            },
            selectedIndex: _selectedIndex,
            destinations: navigation,

          ),
        )
    );
  }
}