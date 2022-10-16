import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants.dart';
import '../Authentication/authcontroller.dart';
import '../Authentication/reuestuser.dart';
import '../Splashscreen/body.dart/splashbody.dart';
import '../home/home_screen.dart';

class login extends StatefulWidget {
  login({
    Key? key,
    required this.num,
    required this.email,
  }) : super(key: key);
  String num;
  String email;
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool isloading = true;
  User u = new User();
  Authcontrol _auth = new Authcontrol();
  @override
  void initState() {
    getdata();
    super.initState();
  }

  Future<void> getdata() async {
    print(widget.num);
    await u.setNameDetails(widget.email);
    setState(() {
      isloading = false;
    });
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
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    u.Name != null ? 'Dear, ${u.Name}' : 'Dear, User',
                    // ignore: unnecessary_const
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  // ignore: unnecessary_const
                  child: const Text(
                    'Welcome Back to our Family!',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: DefaultButton(
                    text: 'SignUp',
                    press: () async {
                      await googlelogin();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  googlelogin() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (u.email != null && u.email == googleUser!.email) {
      print(googleUser.email);
      await _auth.signInWithGoogle(googleUser);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }
}
