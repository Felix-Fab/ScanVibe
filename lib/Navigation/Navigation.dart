import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:scanvibe/Pages/ProductSearch/ProductSearch.dart';
import 'package:scanvibe/Pages/Scanner.dart';

import '../Pages/Profile/Profile.dart';
import '../QuickAlerts/ProfileEdit.dart';

class Navigation extends StatefulWidget {
  final String? pageId;

  const Navigation(this.pageId, { super.key });

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  User? user = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;

  final List<Widget> pages = <Widget>[
    const ProductSearchWidget(),
    const Scanner(),
    const ProfileWidget()
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      user = FirebaseAuth.instance.currentUser;

      if (user?.displayName == null || user?.displayName == "") {

        if (context.mounted) {
          ProfileEdit.openUserNameEditor(context, true);
        }
      }
    });

    if(widget.pageId != null){
      _selectedIndex = int.parse(widget.pageId!);
    }

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
            onDestinationSelected: (int newIndex) {
              setState(() {
                _selectedIndex = newIndex;
              });
            },
            selectedIndex: _selectedIndex,
            destinations: navigation,
          ),
        ),
        endDrawer: NavDrawer());
  }
}

class NavDrawer extends StatelessWidget {
  NavDrawer({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var photoURL;
    if (user?.photoURL != null) {
      String? picture = user?.photoURL;
      photoURL = NetworkImage(picture!);
    } else {
      photoURL =
          const AssetImage('assets/Account/ProfilePicturePlaceholderWhite.png');
    }

    return Drawer(
        child: Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xff388e3c),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: photoURL,
                      backgroundColor: Colors.transparent,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text('${user?.displayName}',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white, height: 1.2)),
                    ),
                    const Text("20.000 Bewertungen",
                        style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              ListTile(
                title: const Text('Freunde'),
                leading: const Icon(Icons.group),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Inbox'),
                leading: const Icon(Icons.message),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Meine Bewertungen'),
                leading: const Icon(Icons.thumb_up),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Premium'),
                leading: const Icon(Icons.stars, color: Color(0xffe5aa17)),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Hilfe'),
                leading: const Icon(Icons.help),
                onTap: () {},
              ),
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView(
            reverse: true,
            children: [
              ListTile(
                title: const Text("Log out"),
                leading: const Icon(Icons.logout),
                onTap: () async {
                  await auth.signOut().then((value) => context.go('/'));
                },
              ),
              ListTile(
                title: const Text("Einstellungen"),
                leading: const Icon(Icons.settings),
                onTap: () {},
              ),
            ],
          ),
        )
      ],
    ));
  }
}
