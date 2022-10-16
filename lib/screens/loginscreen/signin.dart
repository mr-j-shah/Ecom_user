import 'package:ecom/screens/loginscreen/signinbody.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class signin extends StatelessWidget {
  const signin({Key? key}) : super(key: key);
  static String routeName = "/signin";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: siginbody(),
    );
  }
}
