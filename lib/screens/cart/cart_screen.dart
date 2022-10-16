import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key, required List<product> cartList}) : super(key: key);
  static String routeName = "/cart";
  List<product> cartList = [];
  List<Map<String, dynamic>> u = [];
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int length = 0;
  @override
  void initState() {
    getcartlist().then((value) {
      setState(() {
        widget.cartList = value;
        length = value.length;
      });
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);

      throw error!;
    });
    cartList().then((value) {
      setState(() {
        widget.u = value;
      });
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);

      throw error!;
    });
    print(widget.u);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(
        cartList: widget.cartList,
      ),
      bottomNavigationBar: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(User!.email.toString())
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return new Text("Loading");
            var user = snapshot.data;
            return CheckoutCard(
              u: widget.u,
              length: length,
              name: (user as dynamic)['Name'],
              address: (user as dynamic)['address'],
              email: (user as dynamic)['email'],
              phone: (user as dynamic)['phone'],
            );
          }),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // ignore: prefer_const_constructors
              Text(
                "Your Cart",
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                "${widget.cartList.length} items",
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          Container(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  getcartlist().then((value) {
                    setState(() {
                      widget.cartList = value;
                      length = value.length;
                    });
                  }).onError((error, stackTrace) {
                    print(error);
                    print(stackTrace);

                    throw error!;
                  });
                  cartList().then((value) {
                    setState(() {
                      widget.u = value;
                    });
                  }).onError((error, stackTrace) {
                    print(error);
                    print(stackTrace);

                    throw error!;
                  });
                  print(widget.u);
                },
                icon: Icon(Icons.refresh)),
          )
        ],
      ),
    );
  }

  Future<List<product>> getcartlist() async {
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

  Future<List<Map<String, dynamic>>> cartList() async {
    final User = FirebaseAuth.instance.currentUser;
    final snapShot = await FirebaseFirestore.instance
        .collection('user')
        .doc(User!.email)
        .collection('cart')
        .get();
    List<Map<String, dynamic>> u = [];
    for (final doc in snapShot.docs) {
      u.add(doc.data());
    }
    return u;
  }
}
