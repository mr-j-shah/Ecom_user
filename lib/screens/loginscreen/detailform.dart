import 'package:ecom/screens/loginscreen/signup.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class detailform extends StatefulWidget {
  String email;

  detailform({Key? key, required this.number, required this.email})
      : super(key: key);
  String number;
  @override
  State<detailform> createState() => _detailformState();
}

class _detailformState extends State<detailform> {
  bool userExist = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        // ignore: prefer_const_constructors
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: kPrimaryColor,
      ),
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              // border: Border.all(color: kPrimaryColor),
              // ignore: unnecessary_const
              borderRadius: const BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.8,
            child: signup(
              num: widget.number,
            ),
          ),
        ),
      ),
    );
  }
}
