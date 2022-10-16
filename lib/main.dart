import 'package:ecom/routes.dart';
import 'package:ecom/screens/Splashscreen/splashscreen.dart';
import 'package:ecom/screens/localstorage.dart';
import 'package:ecom/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(cartproductAdapter());
  Hive.openBox<cartproduct>('products');
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? splashscreen.routeName
          : HomeScreen.routeName,
      routes: routes,
    );
  }
}
