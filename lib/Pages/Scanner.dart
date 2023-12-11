import 'package:flutter/material.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});


  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String _scanType = "Barcode";

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

  bool light0 = false;

  final MaterialStateProperty<Icon?> thumbIcon =
  MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.check);
    },
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 75, // Set this height
            title: const Center(
                child: Text(
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700
                  ),
                  'Scanner',
                )
            ),
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            backgroundColor: Colors.red,
          ), //AppBar
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, //NOT WORKING!
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                    child: Text(
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.normal,
                        ),
                        "Halten sie den Scanner über den " + _scanType
                    )
                ),
              ),
              Center(
                  child: Container(
                    width: 275,
                    height: 275,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Center(
                        child: Icon(Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 100.0,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                      ),
                    ),
                  )
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Center(
                      child: Text(
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.normal,
                          ),
                          "Barcode"
                      )
                  ),
                  Switch(
                    value: light0,
                    onChanged: (bool value) {
                      setState(() {
                        light0 = value;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}