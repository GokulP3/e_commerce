import 'package:e_commerce/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/bottom_navigation_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navBarListen = Provider.of<BottomNavigatorProvider>(context);
    final navBarProvider =
        Provider.of<BottomNavigatorProvider>(context, listen: false);
    final productProvider = Provider.of<ProductProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        if (navBarProvider.currentIndex == 0) return true;
        navBarProvider.selectedPage(0);
        return false;
      },
      child: Scaffold(
        appBar: null,
        body: navBarListen.currentPage,
        bottomNavigationBar: NavigationBar(
            height: 55,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            selectedIndex: navBarListen.currentIndex,
            destinations: [
              NavigationDestination(
                  label: "Dashboard",
                  icon: Icon(navBarProvider.currentIndex == 0
                      ? Icons.home_rounded
                      : Icons.home_outlined)),
              NavigationDestination(
                label: "Categories",
                icon: Icon(navBarProvider.currentIndex == 1
                    ? Icons.dashboard_rounded
                    : Icons.dashboard_outlined),
              ),
              NavigationDestination(
                  label: "Notification",
                  icon: Badge(
                    label: const Text(
                      '10',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    isLabelVisible: true,
                    child: Icon(navBarProvider.currentIndex == 3
                        ? Icons.notifications
                        : Icons.notifications_none_outlined),
                  )),
              NavigationDestination(
                label: "account",
                icon: Icon(
                  navBarProvider.currentIndex == 2
                      ? Icons.person_rounded
                      : Icons.person_outline_rounded,
                ),
              ),
              NavigationDestination(
                  label: "Cart",
                  icon: Badge(
                    label: Text(
                      '${productProvider.cartData.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    isLabelVisible: productProvider.cartData.isNotEmpty,
                    child: Icon(navBarProvider.currentIndex == 4
                        ? Icons.shopping_cart
                        : Icons.shopping_cart_outlined),
                  )),
            ],
            onDestinationSelected: (int i) {
              navBarListen.selectedPage(i);
            }),
      ),
    );
  }
}
