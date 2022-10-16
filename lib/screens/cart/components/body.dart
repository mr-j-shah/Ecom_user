import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  Body({Key? key, required this.cartList}) : super(key: key);
  List<product> cartList = [];
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void dispose() {
    // Hive.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: widget.cartList.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(widget.cartList[index].name.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                final user = FirebaseAuth.instance.currentUser!.email;
                FirebaseFirestore.instance
                    .collection('user')
                    .doc(user)
                    .collection('cart')
                    .doc(widget.cartList[index].name)
                    .delete();
                widget.cartList.removeAt(index);
              });
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(cart: widget.cartList[index]),
          ),
        ),
      ),
    );
  }
}
