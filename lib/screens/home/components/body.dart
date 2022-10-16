import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/product.dart';
import 'package:ecom/screens/home/components/discount_banner.dart';
import 'package:ecom/screens/home/components/home_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'popular_products.dart';
import 'special_offers.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<product> cartList = [];
  @override
  void initState() {
    cartlist().then((value) {
      setState(() {
        cartList = value;
      });
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);

      throw error!;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: getProportionateScreenWidth(20),
          ),
          HomeHeader(
            cartList: cartList,
          ),
          SizedBox(
            height: getProportionateScreenWidth(30),
          ),
          DiscountBanner(),
          SizedBox(
            height: getProportionateScreenWidth(30),
          ),
          Categories(),
          SizedBox(
            height: getProportionateScreenWidth(30),
          ),
          SpecialOffers(),
          SizedBox(
            height: getProportionateScreenWidth(30),
          ),
          PopularProducts(),
          SizedBox(
            height: getProportionateScreenWidth(30),
          ),
        ],
      ),
    ));
  }

  Future<List<product>> cartlist() async {
    final User = FirebaseAuth.instance.currentUser;
    List<product> u = [];
    final snapShot = await FirebaseFirestore.instance
        .collection('user')
        .doc(User!.email)
        .collection('cart')
        .get();
    for (final doc in snapShot.docs) {
      u.add(product.fromCart(doc));
    }
    return u;
  }
}
