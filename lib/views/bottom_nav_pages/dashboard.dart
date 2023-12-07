import 'package:e_commerce/provider/product_provider.dart';
import 'package:e_commerce/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../provider/bottom_navigation_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return CustomScrollView(
      slivers: [_sliverAppBar(), _sliverGrid()],
    );
  }

  Widget _sliverAppBar() {
    return SliverAppBar(
      snap: true,
      pinned: true,
      floating: true,
      automaticallyImplyLeading: false,
      centerTitle: false,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: false,
          background: Image.asset(
            "assets/images/banner-1.png",
            fit: BoxFit.fill,
          ),
          title: const Text("Hello There!",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600))),
      expandedHeight: 250,
      backgroundColor: Colors.blueAccent[400],
      leading: const Icon(
        Icons.shop,
        color: Colors.white,
      ),
      actions: [
        IconButton(
          icon: Badge(
            label: Text(
              '${Provider.of<ProductProvider>(context).cartData.length}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
            isLabelVisible:
                Provider.of<ProductProvider>(context).cartData.isNotEmpty,
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
          tooltip: 'Cart Icon',
          onPressed: () {
            Provider.of<BottomNavigatorProvider>(context, listen: false)
                .selectedPage(4);
          },
        ), //IconButton
      ],
    );
  }

  Widget _sliverGrid() {
    final product = Provider.of<ProductProvider>(context);
    return product.isLoading == true
        ? _loadingGrid()
        : SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.92),
            delegate: SliverChildBuilderDelegate(
                childCount: product.productData.length, (context, index) {
              return ProductCard(data: product.productData[index]);
            }),
          );
  }

  Widget _loadingGrid() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      delegate: SliverChildBuilderDelegate(childCount: 10, (context, index) {
        return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: const Card());
      }),
    );
  }
}
