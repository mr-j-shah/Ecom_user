import 'package:ecom/screens/Splashscreen/body.dart/splashbody.dart';

import 'package:flutter/material.dart';

class splashscreen extends StatelessWidget {
  static String routeName = "/splash";
  const splashscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: splashbody(),
    );
  }
}
