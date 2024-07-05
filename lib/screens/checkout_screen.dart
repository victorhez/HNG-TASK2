import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/widgets/custom_app_bar.dart';
import 'package:shop_app/widgets/order_summary.dart';

import '../blocs/cart/cart_bloc.dart';
import 'tabs_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  static const String routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController countryController = TextEditingController();
    final TextEditingController ziCodeController = TextEditingController();

    Padding _buildTextFormField(
      BuildContext context,
      String labelText,
      TextEditingController controller,
    ) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: 75,
              child: Text(
                labelText,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.only(left: 10),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_checkout,
              size: 150,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Thanks for shopping, you order has been successfully marked paid, you will get it delivered to your house",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<CartBloc>().add(CartStarted());
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (ctx) => TabsScreen()),
                        (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 0,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Scaffold(
    //   resizeToAvoidBottomInset: false,
    //   appBar: CustomAppBar(title: 'Checkout'),
    //   body: Padding(
    //     padding: const EdgeInsets.all(20.0),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'CUSTOMER INFORMATION',
    //           style: Theme.of(context).textTheme.headline3,
    //         ),
    //         _buildTextFormField(context, 'Email', emailController),
    //         _buildTextFormField(context, 'Full Name', nameController),
    //         Text(
    //           'DELIVERY INFORMATION',
    //           style: Theme.of(context).textTheme.headline3,
    //         ),
    //         _buildTextFormField(context, 'Address', addressController),
    //         _buildTextFormField(context, 'City', cityController),
    //         _buildTextFormField(context, 'Country', countryController),
    //         _buildTextFormField(context, 'Zip Code', ziCodeController),
    //         Text(
    //           'ORDER SUMMARY',
    //           style: Theme.of(context).textTheme.headline3,
    //         ),
    //         OrderSummary(),
    //         SizedBox(height: 20),
    // ElevatedButton(
    //   onPressed: () {},
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: Colors.white,
    //     shape: RoundedRectangleBorder(),
    //     elevation: 0,
    //   ),
    //   child: Align(
    //     alignment: Alignment.center,
    //     child: Text(
    //       'ORDER NOW',
    //       style: Theme.of(context).textTheme.headline5,
    //     ),
    //   ),
    // ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
