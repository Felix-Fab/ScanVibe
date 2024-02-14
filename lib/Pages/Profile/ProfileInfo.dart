import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {

  @override
  Widget build(BuildContext context) {
    Size ScreenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Container(
            width: ScreenSize.width * 0.40,
            height: ScreenSize.width * 0.40,
            child: const Image(
              image: AssetImage("assets/MaleUser.png"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Column(
              children: [
                Text("Hallooo"),
                Container(
                  height: 2,
                  width: ScreenSize.width * 0.40,
                  color: Colors.grey,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
