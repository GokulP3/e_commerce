import 'package:e_commerce/views/bottom_nav_pages/categories.dart';
import 'package:e_commerce/views/bottom_nav_pages/dashboard.dart';
import 'package:e_commerce/views/bottom_nav_pages/mycart.dart';
import 'package:e_commerce/views/bottom_nav_pages/notifications.dart';
import 'package:e_commerce/views/bottom_nav_pages/settings.dart';
import 'package:flutter/material.dart';

class BottomNavigatorProvider extends ChangeNotifier {
  int currentIndex = 0;
  void selectedPage(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void clear() {
    currentIndex = 0;
    notifyListeners();
  }

  Widget getPages() {
    List bottomPages = [
      const Dashboard(),
      const Categories(),
      const Notifications(),
      const UserSettings(),
      const MyCart(),
    ];
    return bottomPages[currentIndex];
  }

  Widget get currentPage => getPages();
}
