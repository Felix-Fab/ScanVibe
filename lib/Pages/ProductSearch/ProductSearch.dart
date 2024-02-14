import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scanvibe/Pages/ProductSearch/ProductItem.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          centerTitle: true,
          title: const Text(
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
            'Suchen',
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
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xff388E3C)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xff388E3C)),
                    ),
                    hintText: 'Enter a search term',
                    label: Text("Produkt"),
                    labelStyle: TextStyle(color: Color(0xff388E3C))),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView(
                  children: const [ProductItem(), ProductItem(), ProductItem()],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
