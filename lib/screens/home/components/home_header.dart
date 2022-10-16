import 'package:ecom/product.dart';
import 'package:ecom/screens/Authentication/reuestuser.dart';
import 'package:ecom/screens/cart/cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({Key? key, required this.cartList}) : super(key: key);
  List<product> cartList = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
            child: Image.asset(
                'assets/images/WhatsApp_Image_2022-05-28_at_9.39.35_AM-removebg-preview-removebg-preview.png',
                width: 100,
                height: 50,
                fit: BoxFit.fill),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SearchField(),
              IconBtnWithCounter(
                svgSrc: "assets/icons/Cart Icon.svg",
                numOfItems: cartList.length,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(
                        cartList: cartList,
                      ),
                    ),
                  );
                },
              ),
              IconBtnWithCounter(
                svgSrc: "assets/icons/Bell.svg",
                numOfItems: 3,
                press: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
