import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/constants.dart';
import 'package:ecom/product.dart';
import 'package:ecom/screens/details/components/product_images.dart';
import 'package:ecom/screens/localstorage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import '../../Splashscreen/body.dart/splashbody.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';

class Body extends StatefulWidget {
  Body({
    Key? key,
    required this.pro,
  }) : super(key: key);
  final product pro;
  String root = "";
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int count = 0;
  bool isCart = false;
  bool isLoading = true;
  @override
  void initState() {
    intialCount();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isStock() {
      if (widget.pro.quantity != 0) {
        return true;
      }
      return false;
    }

    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          )
        : ListView(
            children: [
              ProductImages(pro: widget.pro),
              TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  children: [
                    ProductDescription(
                      pro: widget.pro,
                      pressOnSeeMore: () {},
                    ),
                    TopRoundedContainer(
                      color: Color(0xFFF6F7F9),
                      child: Column(
                        children: [
                          // ColorDots(product: pro), TO DO BASED ON COLOER
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20)),
                            child: Row(
                              children: [
                                Text(
                                  "Price  ",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                          getProportionateScreenHeight(20)),
                                ),
                                Text(
                                  widget.pro.price.toString() + ' INR',
                                  style: TextStyle(
                                      // color: kPrimaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                          getProportionateScreenHeight(20)),
                                ),
                              ],
                            ),
                          ),
                          TopRoundedContainer(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.15,
                                right: SizeConfig.screenWidth * 0.15,
                                bottom: getProportionateScreenWidth(10),
                                top: getProportionateScreenWidth(10),
                              ),
                              child: SizedBox(
                                width: 110.0,
                                height: 44.0,
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xddFFFFFF),
                                        border: Border.all(
                                            color: Colors.orange, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(22.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            updateCount(-1);
                                          },
                                          child: Container(
                                            width: 40.0,
                                            // ignore: prefer_const_constructors
                                            child: Center(
                                              // ignore: prefer_const_constructors
                                              child: Text(
                                                '-',
                                                // ignore: prefer_const_constructors
                                                style: TextStyle(
                                                    fontSize: 25.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.orange,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                              child: Text(
                                            '$count',
                                            // ignore: prefer_const_constructors
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orange,
                                                decoration:
                                                    TextDecoration.none),
                                          )),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            updateCount(1);
                                          },
                                          child: Container(
                                            width: 40.0,
                                            // ignore: prefer_const_constructors
                                            child: Center(
                                              // ignore: prefer_const_constructors
                                              child: Text(
                                                '+',
                                                // ignore: prefer_const_constructors
                                                style: TextStyle(
                                                    fontSize: 25.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.orange,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TopRoundedContainer(
                            color: Color(0xFFF6F7F9),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: SizeConfig.screenWidth * 0.15,
                                    right: SizeConfig.screenWidth * 0.15,
                                    bottom: getProportionateScreenWidth(10),
                                    top: getProportionateScreenWidth(10),
                                  ),
                                  child: isStock()
                                      ? DefaultButton(
                                          text: !isCart
                                              ? "Add To Cart"
                                              : "Update",
                                          press: count != 0
                                              ? () async {
                                                  await addToCart(widget.pro);
                                                  await addToCartLocal(
                                                      widget.pro);
                                                  setState(() {
                                                    isCart = true;
                                                  });
                                                }
                                              : () {},
                                        )
                                      : const Text(
                                          'Not in Stock!!',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20),
                                        ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: SizeConfig.screenWidth * 0.15,
                                    right: SizeConfig.screenWidth * 0.15,
                                    bottom: getProportionateScreenWidth(40),
                                    top: getProportionateScreenWidth(10),
                                  ),
                                  child: isCart
                                      ? DefaultButton(
                                          text: 'Remove Cart',
                                          press: () async {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            await removeToCart(widget.pro);
                                          },
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }

  intialCount() async {
    final User = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(User!.email)
        .collection('cart')
        .doc(widget.pro.name)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          isCart = true;
          isLoading = false;
          count = documentSnapshot['Quantity'];
        });
      } else {
        setState(() {
          count = 0;
          isLoading = false;
        });
      }
    });
  }

  addToCart(product pro) async {
    final User = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(User!.email)
        .collection('cart')
        .doc(pro.name)
        .set({
      'Description': pro.description,
      'Image': pro.imagelink,
      'Name': pro.name,
      'Price': pro.price,
      'Quantity': count,
      'category': pro.category,
    });
  }

  removeToCart(product pro) async {
    final User = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(User!.email)
        .collection('cart')
        .doc(pro.name)
        .delete();
    setState(() {
      isCart = false;
      count = 0;
      isLoading = false;
    });
  }

  void updateCount(int addValue) {
    if (count + addValue >= 0) {
      setState(() {
        count += addValue;
      });
    }
  }
}
