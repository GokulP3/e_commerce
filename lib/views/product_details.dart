import 'package:e_commerce/provider/product_provider.dart';
import 'package:e_commerce/utils/responsive.dart';
import 'package:e_commerce/views/product_checkout_page.dart';
import 'package:e_commerce/widgets/back_button.dart';
import 'package:e_commerce/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../model/product_model.dart';
import '../provider/bottom_navigation_provider.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({Key? key, required this.data}) : super(key: key);
  final Product data;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return _scaffold(context);
  }

  Widget _scaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyBackButton(),
        title: Text(data.title),
      ),
      body: _body(context),
      floatingActionButton: _floatingButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _body(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              _productImages(data.productImages, context),
              _dotIndicator(data.productImages, context),
              _productTitle(),
              _productDescription(),
              _priceAndDiscount(),
              _rating(),
              _productPlus(),
            ],
          ),
        )
      ],
    );
  }

  Widget _productImages(List images, BuildContext context) {
    final height = Responsive(context).height;
    final width = Responsive(context).width;
    return CarouselSlider(
      carouselController: _controller,
      items: images
          .map((image) => Column(
                children: [
                  SizedBox(
                    height: height * 0.35,
                    width: width * 0.5,
                    child: Image.network(
                      image,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ))
          .toList(),
      options: CarouselOptions(
          autoPlay: false,
          height: height * 0.4,
          viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            Provider.of<ProductProvider>(context, listen: false)
                .setProductImageIndex(index);
          }),
    );
  }

  Widget _dotIndicator(List images, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: images.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _controller.animateToPage(entry.key),
          child: Container(
            width: 12.0,
            height: 12.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                    .withOpacity(
                        Provider.of<ProductProvider>(context).currentImage ==
                                entry.key
                            ? 0.9
                            : 0.4)),
          ),
        );
      }).toList(),
    );
  }

  Widget _floatingButton(BuildContext context) {
    final width = Responsive(context).width;
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _cartButton(context, width),
          const SizedBox(
            width: 5,
          ),
          _buyNow(context, width),
        ],
      ),
    );
  }

  Widget _cartButton(BuildContext context, width) {
    return SizedBox(
      width: width * 0.48,
      height: 50,
      child: FloatingActionButton(
          heroTag: "cartBtn",
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey)),
          onPressed: () {
            if (_isAdded(context)) {
              Provider.of<BottomNavigatorProvider>(context, listen: false)
                  .selectedPage(4);
              Navigator.of(context).pop();
            } else {
              Provider.of<ProductProvider>(context, listen: false)
                  .addToCart(data.id);
              SnackBarWidget().snackBar(context, "Product added successfully");
            }
          },
          child: Text(
            // "Edit"
            _isAdded(context) ? "Go to cart" : "Add to cart",
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          )),
    );
  }

  Widget _buyNow(BuildContext context, width) {
    return SizedBox(
      width: width * 0.48,
      height: 50,
      child: FloatingActionButton(
          heroTag: "buyNowBtn",
          elevation: 3,
          foregroundColor: Colors.black,
          backgroundColor: Colors.amberAccent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey)),
          onPressed: () {
            Provider.of<ProductProvider>(context, listen: false)
                .addProductToCheckOut(false, id: data.id);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProductCheckOut()));
          },
          child: const Text(
            // "Edit"
            "Buy now",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          )),
    );
  }

  _productTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
            child: Text(
              "${data.brand}-${data.title}",
              style: const TextStyle(
                  overflow: TextOverflow.fade,
                  fontSize: 24,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productDescription() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(data.desc),
    );
  }

  Widget _priceAndDiscount() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            "₹${data.price}/",
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          Text(
            double.parse((data.price + (data.price * (data.discPerc / 100)))
                    .toString())
                .toStringAsFixed(2),
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
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
            "${data.discPerc}%",
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w800, color: Colors.green),
          )
        ],
      ),
    );
  }

  Widget _rating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.star,
          color: Colors.orangeAccent,
          size: 28,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          double.parse(data.rating.toString()).toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        )
      ],
    );
  }

  Widget _productPlus() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100.0, top: 20),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(4),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _replacement(),
            _cashOnDelivery(),
            _assuredProduct(),
          ],
        ),
      ),
    );
  }

  _replacement() {
    return const Column(
      children: [
        Icon(
          Icons.repeat_rounded,
          size: 28,
          color: Colors.orange,
        ),
        Text("7 Days Replacement ")
      ],
    );
  }

  Widget _cashOnDelivery() {
    return const Column(
      children: [
        Icon(
          Icons.monetization_on,
          size: 28,
          color: Colors.blueAccent,
        ),
        Text("Cash on delivery")
      ],
    );
  }

  Widget _assuredProduct() {
    return const Column(
      children: [
        Icon(
          Icons.trending_up,
          weight: 10,
          size: 28,
          color: Colors.green,
        ),
        Text("100% Assured")
      ],
    );
  }

  bool _isAdded(context) {
    int index = Provider.of<ProductProvider>(context, listen: false)
        .cartData
        .indexWhere((element) => element.id == data.id);
    return index != -1 ? true : false;
  }
}
