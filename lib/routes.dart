import 'package:ecom/screens/Favorite/favorite_screen.dart';
import 'package:ecom/screens/Splashscreen/splashscreen.dart';
import 'package:ecom/screens/details/details_screen.dart';
import 'package:ecom/screens/home/home_screen.dart';
import 'package:ecom/screens/loginscreen/signin.dart';
import 'package:ecom/screens/profile/profile_screen.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  //CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  //OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  //CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  FavoriteScreen.routeName: (context) => FavoriteScreen(),
  splashscreen.routeName: (context) => splashscreen(),
  signin.routeName: (context) => const signin(),
};
