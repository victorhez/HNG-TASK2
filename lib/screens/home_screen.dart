import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:shop_app/widgets/hero_carousel.dart';
import 'package:shop_app/widgets/product_carousel.dart';
import 'package:shop_app/widgets/section_title.dart';

import '../blocs/product/product_bloc.dart';
import '../blocs/product/product_event.dart';
import '../blocs/product/product_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => ProductBloc()..add(FetchProducts()),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                print(state);
                return Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.4),
                  child: Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Please Wait...")
                      ],
                    ),
                  ),
                );
              } else if (state is ProductLoadSuccess) {
                print(state.products);
                state.products.items.shuffle();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 1.5,
                        viewportFraction: 0.9,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        enableInfiniteScroll: false,
                      ),
                      items: state.products.items
                          .map((category) => HeroCarousel(product: category))
                          .toList(),
                    ),
                    SectionTitle(
                      title: AppLocalizations.of(context)!
                          .recommended
                          .toUpperCase(),
                    ),
                    ProductCarousel(
                      products: state.products,
                    ),
                    SectionTitle(
                      title: 'MOST POPULAR',
                    ),
                    ProductCarousel(
                      products: state.products,
                    ),
                  ],
                );
              } else if (state is ProductLoadFailure) {
                print(state.error);
                return Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.4),
                  child: Center(child: Text(state.error)),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
