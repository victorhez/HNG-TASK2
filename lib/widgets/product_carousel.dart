import 'package:flutter/material.dart';

import 'package:shop_app/models/timbu_product.dart';
import 'package:shop_app/widgets/product_card.dart';

class ProductCarousel extends StatelessWidget {
  final ProductResponse products;

  const ProductCarousel({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    products.items.shuffle();
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 165,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: ProductCard(
                product: products.items[index],
              ),
            );
          },
          itemCount: products.items.length,
        ),
      ),
    );
  }
}
