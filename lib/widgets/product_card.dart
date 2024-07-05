import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shop_app/blocs/cart/cart_bloc.dart';
import 'package:shop_app/blocs/wishlist/wishlist_bloc.dart';

import 'package:shop_app/models/timbu_product.dart';
import 'package:shop_app/screens/product_screen.dart';

class ProductCard extends StatelessWidget {
  final Item product;
  final double widthFactor;
  final bool? isWishlist;

  const ProductCard({
    Key? key,
    required this.product,
    this.widthFactor = 2.5,
    this.isWishlist = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthValue = MediaQuery.of(context).size.width / widthFactor;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductScreen(
              product: product,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://api.timbu.cloud/images/${product.photos[0].url}",
                    ))),
            height: 200,
            width: widthValue,
          ),
          Positioned(
            top: 85,
            // left: 5,
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(color: Colors.white),
                          ),
                          Text(
                            'NGN${product.currentPrice[0].currencyPrice["NGN"][0]}',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartLoading) {
                          return Center(
                              child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator()));
                        }
                        if (state is CartLoaded) {
                          return Expanded(
                            child: IconButton(
                              icon: Icon(Icons.add_circle, color: Colors.white),
                              onPressed: () {
                                context
                                    .read<CartBloc>()
                                    .add(CartProductAdded(product));
                                Fluttertoast.showToast(
                                  msg: "Item added to cart.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.black,
                                  fontSize: 16.0,
                                );
                              },
                            ),
                          );
                        } else {
                          return Text('Something went wrong.');
                        }
                      },
                    ),
                    isWishlist!
                        ? Expanded(
                            child: BlocBuilder<WishlistBloc, WishlistState>(
                              builder: (context, state) {
                                return IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<WishlistBloc>(context).add(
                                      RemoveWishlistProduct(product),
                                    );
                                    Fluttertoast.showToast(
                                      msg: "Item deleted from wishlist.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.black,
                                      fontSize: 16.0,
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
