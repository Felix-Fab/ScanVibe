import 'dart:ffi';

import 'package:flutter/material.dart';
import 'Firebase/firebase_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseController.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _scanType = "";

  void _setScanType(bool isBarcode) {
    if (isBarcode) {
      setState(() {
        _scanType = "Barcode";
      });
    } else {
      setState(() {
        _scanType = "QR-Code";
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 75, // Set this height
            title: Center(
                child: Text(
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700
                  ),
                  'Scanner',
                )
            ),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            backgroundColor: Colors.red,
          ), //AppBar
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, //NOT WORKING!
            children: [
              Center(
                  child: Text(
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.normal,
                      ),
                      "Halten sie den Scanner über den QR-code"
                  )
              ),
              Center(
                  child: FloatingActionButton(onPressed: () {

                  },
                      child: PhysicalShape(
                        elevation: 5.0,
                        clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        color: Colors.orange,
                      )
                  )
              ),
              Center(
                  child: Text(
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.normal,
                      ),
                      "Barcode"
                  )
              )
            ],
          ),


        )
    );
  }
}
