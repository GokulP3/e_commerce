import 'package:e_commerce/provider/bottom_navigation_provider.dart';
import 'package:e_commerce/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
      create: (BuildContext context) => BottomNavigatorProvider()),
  ChangeNotifierProvider(create: (BuildContext context) => ProductProvider())
];
