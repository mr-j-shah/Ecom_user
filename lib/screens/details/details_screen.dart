import 'package:ecom/product.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";
  // product pro;
  // DetailsScreen({required this.pro});
  @override
  Widget build(BuildContext context) {
    final product pro = ModalRoute.of(context)!.settings.arguments as product;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: 4.8
            // TO DO CHNAGE THE VALUE OF RATING BASED ON USER
            ),
      ),
      body: Body(
        pro: pro,
      ),
    );
  }
}
