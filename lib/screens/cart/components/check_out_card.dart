import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../home/home_screen.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CheckoutCard extends StatelessWidget {
  CheckoutCard({
    Key? key,
    required this.length,
    required this.u,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
  }) : super(key: key);

  String name;
  String address;
  String email;
  String phone;

  List<Map<String, dynamic>> u = [];
  int length;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                const Text("Add voucher code"),
                const SizedBox(width: 10),
                // ignore: prefer_const_constructors
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: length != 0
                        ? () async {
                            await placeOrder();
                            Navigator.pushReplacementNamed(
                                context, HomeScreen.routeName);
                          }
                        : () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> placeOrder() async {
    DateTime today = new DateTime.now();
    final user = FirebaseAuth.instance.currentUser!.email;
    // ignore: avoid_print
    print(u);
    await FirebaseFirestore.instance
        .collection('order')
        .doc(email + DateFormat('dd-MM-yyyy').format(today))
        .set({
      'cartList': u,
      'Name': name,
      'address': address,
      'email': email,
      'phone': phone,
      'time': today.toString(),
      'isAccept': false,
      'date': DateFormat('dd-MM-yyyy').format(today)
    });
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user)
        .collection('order')
        .doc(today.toString())
        .set({'cartList': u, 'isAccepted': false});
    // ignore: avoid_print
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user)
        .collection('cart')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot d in snapshot.docs) {
        d.reference.delete();
      }
    });
    print('complete');
  }
}
