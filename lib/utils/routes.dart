import 'package:e_commerce/views/bottom_nav_pages/nav_bar.dart';
import 'package:e_commerce/views/intro_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();
  //static variables
  static const String splash = '/splash';
  static const String home = '/home';
  static const String productDetails = '/productDetails';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => const SplashScreen(),
    home: (BuildContext context) => const HomePage(),
  };
}
