import 'package:e_commerce/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:checkout_screen_ui/checkout_page.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class ProductCheckOut extends StatefulWidget {
  const ProductCheckOut({Key? key}) : super(key: key);

  @override
  State<ProductCheckOut> createState() => _ProductCheckOutState();
}

class _ProductCheckOutState extends State<ProductCheckOut> {
  @override
  Widget build(BuildContext context) {
    return _scaffold();
  }

  Widget _scaffold() {
    return Scaffold(
      appBar: AppBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return CheckoutPage(
      priceItems: _product(),
      payToName: _payToName,
      displayNativePay: true,
      onNativePay: () => _nativePayClicked(context),
      displayCashPay: true,
      onCashPay: () => _cashPayClicked(context),
      isApple: _isApple,
      onCardPay: (results) => _creditPayClicked(results),
      payBtnKey: _payBtnKey,
      displayTestData: true,
      countriesOverride: const <String>["India"],
      footer: _footer,
    );
  }

  List<PriceItem> _product({int id = 0}) {
    final provider = Provider.of<ProductProvider>(context);
    if (provider.isCart) {
      List<PriceItem> data = provider.cartData
          .map((e) => PriceItem(
              name: e.title, quantity: e.quantity, totalPriceCents: e.price))
          .toList();
      return data;
    } else {
      List<PriceItem> data = provider.checkout
          .map((e) => PriceItem(
              name: e.title, quantity: e.quantity, totalPriceCents: e.price))
          .toList();
      return data;
    }
  }

  final demoOnlyStuff = DemoOnlyStuff();
  Future<void> _creditPayClicked(CardFormResults results) async {
    // you can update the pay button to show somthing is happening
    _payBtnKey.currentState?.updateStatus(CardPayButtonStatus.processing);

    // This is where you would implement you Third party credit card
    // processing api
    demoOnlyStuff.callTransactionApi(_payBtnKey);

    // ignore: avoid_print
    print(results);
    // WARNING: you should NOT print the above out using live code
  }

  static const String _payToName = 'Product(s)';

  final _isApple = Platform.isIOS;

  Future<void> _cashPayClicked(BuildContext context) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Cash Pay requires setup')));
  }

  static const _footer = CheckoutPageFooter(
    // These are example url links only. Use your own links in live code
    privacyLink: 'https://stripe.com/privacy',
    termsLink: 'https://stripe.com/payment-terms/legal',
    note: 'Powered By Not_Stripe',
    noteLink: 'https://stripe.com/',
  );

  Future<void> _nativePayClicked(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Native Pay requires setup')));
  }

  final GlobalKey<CardPayButtonState> _payBtnKey =
      GlobalKey<CardPayButtonState>();
}

class DemoOnlyStuff {
  bool shouldSucceed = true;
  Future<void> provideSomeTimeBeforeReset(
      GlobalKey<CardPayButtonState> _payBtnKey) async {
    await Future.delayed(const Duration(seconds: 2), () {
      _payBtnKey.currentState?.updateStatus(CardPayButtonStatus.ready);
      return;
    });
  }

  Future<void> callTransactionApi(
      GlobalKey<CardPayButtonState> _payBtnKey) async {
    await Future.delayed(const Duration(seconds: 2), () {
      if (shouldSucceed) {
        _payBtnKey.currentState?.updateStatus(CardPayButtonStatus.success);
        shouldSucceed = false;
      } else {
        _payBtnKey.currentState?.updateStatus(CardPayButtonStatus.fail);
        shouldSucceed = true;
      }
      provideSomeTimeBeforeReset(_payBtnKey);
      return;
    });
  }
}
