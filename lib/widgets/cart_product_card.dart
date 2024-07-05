import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/cart/cart_bloc.dart';

import 'package:shop_app/models/timbu_product.dart';

class CartProductCard extends StatelessWidget {
  final Item product;
  final int quantity;

  const CartProductCard({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Image.network(
            "https://api.timbu.cloud/images/${product.photos[0].url}",
            width: 100,
            height: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  'NGN${product.currentPrice[0].currencyPrice["NGN"][0]}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<CartBloc>().add(CartProductRemoved(product));
                    },
                    icon: Icon(Icons.remove_circle),
                  ),
                  Text(
                    '$quantity',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<CartBloc>().add(CartProductAdded(product));
                    },
                    icon: Icon(Icons.add_circle),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
