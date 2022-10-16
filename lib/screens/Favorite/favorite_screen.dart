import 'package:flutter/material.dart';

import '../../components/coustom_bottom_nav_bar.dart';
import '../../components/product_card.dart';
import '../../enums.dart';
import '../../models/Product.dart';
import '../details/details_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  static String routeName = '/favorite';
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite items'),
      ),
      body: Body(),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }
}

class Body extends StatelessWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              demoProducts.length,
              (index) {
                if (demoProducts[index].isFavourite)
                  // ignore: curly_braces_in_flow_control_structures
                  return ProductCard(
                    product: demoProducts[index],
                    press: () => Navigator.pushNamed(
                      context, DetailsScreen.routeName,
                      // arguments: ProductDetailsArguments(
                      // product: demoProducts[index])
                    ),
                  );
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
