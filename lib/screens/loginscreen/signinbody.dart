import 'package:ecom/screens/loginscreen/detailform.dart';
import 'package:ecom/screens/loginscreen/login.dart';
import 'package:ecom/screens/loginscreen/wait.dart';
import 'package:ecom/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../components/default_button.dart';
import '../Authentication/authcontroller.dart';

class siginbody extends StatefulWidget {
  siginbody({Key? key}) : super(key: key);

  @override
  State<siginbody> createState() => _siginbodyState();
}

class _siginbodyState extends State<siginbody> {
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String p = "+91";
    final iskeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return SafeArea(
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                //TO DO Change name of Company
                'BUDGET BAZAR',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.03),
              ),
            ),
          ),
          if (!iskeyboard)
            Expanded(
                child: Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              //TO DO Company Icon
              child: Image(image: AssetImage('assets/images/splash_3.png')),
            )),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: kPrimaryColor),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Hello !',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Please Enter country code and Enter your phone number',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Container(
                          color: Colors.white10,
                          child: IntlPhoneField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            initialCountryCode: 'IN',
                            onChanged: (phone) {
                              print(phone.completeNumber);
                              p = phone.completeNumber;
                            },
                            onTap: () {
                              print(iskeyboard);
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: DefaultButton(
                        text: 'Next',
                        press: () async {
                          final GoogleSignInAccount? googleUser =
                              await GoogleSignIn().signIn();
                          bool checkuser = await Authcontrol()
                              .checkUserExists(googleUser!.email.toString());
                          bool checReq = await Authcontrol()
                              .checkReuestExist(googleUser.email.toString());
                          if (p.length == 13) {
                            checkuser
                                ? Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => login(
                                        num: p,
                                        email: googleUser.email,
                                      ),
                                    ),
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => checReq
                                          ? wait(
                                              num: p,
                                              email: googleUser.email,
                                            )
                                          : detailform(
                                              number: p,
                                              email: googleUser.email,
                                            ),
                                    ),
                                  );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
