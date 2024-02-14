import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ProfileInfo.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          centerTitle: true,
          title: const Text(
            style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700
            ),
            'Scanner',
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            )
          ],
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: const Color(0xff388e3c),
        ), //AppBar
        body: const Column(
          children: [
            ProfileInfo()
          ],
        )
      ),
    );
  }
}
