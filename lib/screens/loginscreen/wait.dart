import 'package:flutter/material.dart';

import '../../constants.dart';
import '../Authentication/reuestuser.dart';

class wait extends StatefulWidget {
  wait({Key? key, required this.num, required this.email}) : super(key: key);
  String num;
  String email;
  @override
  State<wait> createState() => _waitState();
}

class _waitState extends State<wait> {
  bool isloading = true;
  Requestuser r = new Requestuser();

  @override
  void initState() {
    getdata();
    super.initState();
  }

  Future<void> getdata() async {
    print(widget.num);
    await r.setNameDetails(widget.email);
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
            child: isloading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          r.Name != null ? 'Dear, ${r.Name}' : 'Dear, User',
                          // ignore: unnecessary_const
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        // ignore: unnecessary_const
                        child: const Text(
                          'Your Application under scrutiny, You need permission from Admin. We from admin side processing your application. Please co-operate with us.\nFor further query contacl Admin - +919090909090',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
