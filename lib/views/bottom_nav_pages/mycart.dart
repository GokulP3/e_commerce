import 'package:e_commerce/provider/product_provider.dart';
import 'package:e_commerce/utils/responsive.dart';
import 'package:e_commerce/views/product_checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return _scaffold();
  }

  Widget _scaffold() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Cart Item"),
      ),
      body: _body(),
      floatingActionButton: _floatingButton(),
    );
  }

  Widget _body() {
    final provider = Provider.of<ProductProvider>(context);
    return provider.cartData.isEmpty ? _emptyCart() : _cartItems();
  }

  Widget _emptyCart() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              color: Colors.blue,
              size: 50,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your cart is empty!",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  letterSpacing: 0.8),
            )
          ],
        ),
      ],
    );
  }

  Widget _cartItems() {
    final provider = Provider.of<ProductProvider>(context);
    return ListView.builder(
        itemCount: provider.cartData.length,
        itemBuilder: (BuildContext context, int index) {
          return _cartItem(index);
        });
  }

  Widget _cartItem(index) {
    final width = Responsive(context).width;
    return SizedBox(
      width: width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [_productDetails(index)],
          ),
        ),
      ),
    );
  }

  Widget _productDetails(index) {
    return Row(
      children: [
        Column(
          children: [
            _productImage(index),
            _addQuantity(index),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _productDesc(index),
            _priceAndDiscount(index),
            _deliveryOn(),
            _buyAndRemoveItem(index)
          ],
        )
      ],
    );
  }

  Widget _productImage(index) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Image.network(Provider.of<ProductProvider>(context, listen: false)
          .cartData[index]
          .productImages[0]),
    );
  }

  Widget _productDesc(index) {
    return Text(
      Provider.of<ProductProvider>(context).cartData[index].title,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
    );
  }

  Widget _priceAndDiscount(index) {
    final provider = Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            "₹${provider.cartData[index].price * provider.cartData[index].quantity}/",
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(
            double.parse(((provider.cartData[index].price +
                            (provider.cartData[index].price *
                                (provider.cartData[index].discPerc / 100))) *
                        provider.cartData[index].quantity)
                    .toString())
                .toStringAsFixed(2),
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough),
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.discount_rounded,
            color: Colors.green,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "${double.parse((provider.cartData[index].discPerc * provider.cartData[index].quantity).toString()).toStringAsFixed(2)}%",
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w800, color: Colors.green),
          )
        ],
      ),
    );
  }

  Widget? _floatingButton() {
    return Provider.of<ProductProvider>(context).cartData.isEmpty
        ? null
        : FloatingActionButton.extended(
            onPressed: () {
              Provider.of<ProductProvider>(context, listen: false)
                  .addProductToCheckOut(true);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProductCheckOut()));
            },
            label: const Text("Checkout"),
            icon: const Icon(Icons.check_circle),
            // shape: const Icon(Icons.save),
          );
  }

  Widget _addQuantity(index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          _decreaseQuantity(index),
          _quantity(index),
          _increaseQuantity(index),
        ],
      ),
    );
  }

  Widget _quantity(index) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Text(
        Provider.of<ProductProvider>(context)
            .cartData[index]
            .quantity
            .toString(),
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      ),
    );
  }

  Widget _decreaseQuantity(index) {
    return InkWell(
        onTap: () {
          Provider.of<ProductProvider>(context, listen: false)
              .removeQuantity(index);
        },
        child: Container(
            margin: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
                color: Colors.black12, shape: BoxShape.circle),
            child: const Center(
                child: Icon(
              Icons.remove,
              size: 22,
            ))));
  }

  Widget _increaseQuantity(index) {
    return InkWell(
        onTap: () {
          Provider.of<ProductProvider>(context, listen: false)
              .addQuantity(index);
        },
        child: Container(
            margin: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
                color: Colors.black12, shape: BoxShape.circle),
            child: const Center(
                child: Icon(
              Icons.add,
              size: 22,
            ))));
  }

  Widget _deliveryOn() {
    return Text(
      "\tDelivery in 2 days, ${DateFormat('EEEE').format(DateTime.now().add(const Duration(days: 2)))}",
      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
    );
  }

  Widget _buyAndRemoveItem(index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _removeItem(index),
        _buyNow(index),
      ],
    );
  }

  Widget _buyNow(index) {
    return TextButton(
        onPressed: () {
          Provider.of<ProductProvider>(context, listen: false)
              .addProductToCheckOut(
                  false,
                  id: Provider.of<ProductProvider>(context, listen: false)
                      .cartData[index]
                      .id);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProductCheckOut()));
        },
        child: const Text("Buy Now"));
  }

  Widget _removeItem(index) {
    return TextButton(
        onPressed: () {
          showConfirmDialogForCart(index);
        },
        child: const Text("Remove Item"));
  }

  /// ********** Automation Confirmation dialog  Widget **********
  showConfirmDialogForCart(index) async {
    final height = Responsive(context).height;
    Widget cancelButton = ElevatedButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = Padding(
      padding: const EdgeInsets.only(left: 10),
      child: FilledButton(
          child: const Text(
            "Yes",
          ),
          onPressed: () async {
            Provider.of<ProductProvider>(context, listen: false)
                .removeItemInCart(index);
            Navigator.of(context).pop();
          }),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      actionsPadding:
          EdgeInsets.only(bottom: height * 0.01, top: height * 0.01),
      titlePadding: const EdgeInsets.all(8),
      shape: const RoundedRectangleBorder(),
      insetPadding: EdgeInsets.zero,
      // buttonPadding: EdgeInsets.zero,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Remove Item",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),

      content: const Text("Are you sure want to remove this item"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cancelButton,
            continueButton,
          ],
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
