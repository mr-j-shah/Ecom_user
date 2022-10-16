import 'package:ecom/screens/Splashscreen/splashscreen.dart';
import 'package:ecom/screens/profile/components/profile_menu.dart';
import 'package:ecom/screens/profile/components/profile_pic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
    required this.image,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
  }) : super(key: key);
  String image;
  String name;
  String address;
  String email;
  String phone;

  @override
  Widget build(BuildContext context) {
    print(name);
    //CollectionReference user = FirebaseFirestore.instance.collection('user');
    return Column(
      children: [
        ProfilePic(
          image: image,
        ),
        // ignore: prefer_const_constructors
        SizedBox(
          height: 20,
        ),
        ProfileMenu(
          icon: "assets/icons/User Icon.svg",
          text: "Name: ${name}",
          press: () {},
        ),
        ProfileMenu(
          icon: "assets/icons/User Icon.svg",
          text: "Address: ${address}",
          press: () {},
        ),
        ProfileMenu(
          icon: "assets/icons/User Icon.svg",
          text: "Email ID: ${email}",
          press: () {},
        ),
        ProfileMenu(
          icon: "assets/icons/User Icon.svg",
          text: "Phone No: ${phone}",
          press: () {},
        ),
        ProfileMenu(
          icon: "assets/icons/Log out.svg",
          text: "Log Out",
          press: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, splashscreen.routeName);
          },
        ),
      ],
    );
  }
}
