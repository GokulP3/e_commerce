import 'package:e_commerce/provider/product_provider.dart';
import 'package:e_commerce/utils/responsive.dart';
import 'package:e_commerce/views/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product data;
  const ProductCard({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ProductProvider>(context, listen: false)
            .setProductImageIndex(0);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetails(data: data)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _productImage(context),
              _productName(),
              _rating(),
              _productPrice(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productImage(BuildContext context) {
    final width = Responsive(context).width;
    final height = Responsive(context).height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: width * 0.2,
          height: height * 0.15,
          child: Image.network(
            data.productImages[0],
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
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  Widget _productName() {
    return Row(
      children: [
        Text(
          data.title,
          style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17,
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  Widget _rating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.star,
          color: Colors.orangeAccent,
          size: 26,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          double.parse(data.rating.toString()).toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        )
      ],
    );
  }

  Widget _productPrice(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "₹${data.price}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        InkWell(
          onTap: () {
            Provider.of<ProductProvider>(context, listen: false)
                .addToWishList(data.id);
          },
          child: Icon(
            data.isLike == true
                ? CupertinoIcons.heart_fill
                : CupertinoIcons.suit_heart,
            color: data.isLike == true ? Colors.red : null,
          ),
        )
      ],
    );
  }
}
