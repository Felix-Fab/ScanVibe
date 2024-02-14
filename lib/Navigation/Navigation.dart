import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:scanvibe/Pages/ProductSearch/ProductSearch.dart';
import 'package:scanvibe/Pages/Scanner.dart';

import '../Pages/Profile/Profile.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  User? user = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;

  final List<Widget> pages = <Widget>[
    const ProductSearch(),
    const Scanner(),
    const Profile()
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
        var message = '';

        if (context.mounted) {
          QuickAlert.show(
              context: context,
              type: QuickAlertType.custom,
              title: 'Username',
              text: 'Bestimme deinen Username',
              barrierDismissible: true,
              confirmBtnText: 'Save',
              disableBackBtn: true,
              widget: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        hintText: "Enter Username",
                        prefixIcon: Icon(Icons.drive_file_rename_outline)),
                    textInputAction: TextInputAction.done,
                    onChanged: (value) => message = value,
                  )),
              onConfirmBtnTap: () async {
                if (message.isEmpty) {
                  await QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    text: 'Username is required',
                  );
                  return;
                }

                try {
                  user
                      ?.updateDisplayName(message)
                      .then((value) => Navigator.pop(context));
                } catch (error) {
                  if (context.mounted) {
                    await QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      text: 'An unknown error has occurred',
                    );
                  }
                }
              });
        }
      }
    });

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
      photoURL = const AssetImage('assets/MaleUser.png');
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
                      radius: 30, // Image radius
                      backgroundImage: photoURL,
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
