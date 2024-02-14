import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 120,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(0, 1), // Shadow position
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 120,
              color: Colors.black,
              child: const Image(
                image: AssetImage("assets/Picture.png"),
              ),
            ),
            const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: ProductInfo(),
                )
            )
          ],
        ),
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 60,
          alignment: Alignment.center,
          child: const Text(
            "Grünländer Käse Mild & Nussig",
            style: TextStyle(
              fontSize: 24.0,
              height: 1.1,
            ),
          ),
        ),
        Container(
          child: Text("Type | Lebensmittel"),
        ),
        Container(
          child: RatingBarIndicator(
            rating: 2.75,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 36.0,
            direction: Axis.horizontal,
          ),
        )
      ],
    );
  }
}
