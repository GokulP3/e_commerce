import 'package:e_commerce/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/internet_checker.dart';
import '../../utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternet();
  }

  void _navigateTo() {
    Future.delayed(const Duration(seconds: 3), () {
      Provider.of<ProductProvider>(context, listen: false).getProductDetails();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routes.home, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return const Center(
      child: Icon(
        Icons.flutter_dash_rounded,
        color: Colors.blue,
        size: 80,
      ),
    );
  }

  // Check Internet connection

  void checkInternet() async {
    int statusCode = await InternetChecker().checkInternet();
    if (statusCode != 200) {
      Future.delayed(const Duration(seconds: 3), () {
        showInternetDialog();
      });
    } else {
      _navigateTo();
    }
  }

  void recheckInternet() async {
    int statusCode = await InternetChecker().checkInternet();
    if (200 == statusCode) {
      _navigateTo();
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  showInternetDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
        child: WillPopScope(
          onWillPop: () => Future.value(false),
          child: Container(
              width: 300,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Connection not available.\nKindly check your connectivity.",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'ubuntu',
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  // you can replace
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(150, 40),
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white),
                            onPressed: () {
                              recheckInternet();
                            },
                            child: const Text("Try again")),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
