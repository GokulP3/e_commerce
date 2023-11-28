import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/service/network/get_api.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Product> productData = [];
  List<Product> cartData = [];
  List<Product> checkout = [];
  int currentImage = 0;
  bool isCart = false;

  getProductDetails() async {
    try {
      isLoading = true;
      notifyListeners();
      await _callProductDataApi();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("Error in get product details");
    }
  }

  // ******************  product details api call *********************
  _callProductDataApi() async {
    await GetProductAPI().getProductDetails().then((value) {
      List temp = value;
      productData = temp.map((element) => Product.fromJson(element)).toList();
    });
    notifyListeners();
  }

  // **************************** remove item in cart *********************

  void removeItemInCart(int index) {
    cartData.removeAt(index);
    notifyListeners();
  }

  // **************************** add to cart *******************************
  addToCart(int id) {
    int index = productData.indexWhere((element) => element.id == id);
    cartData.add(productData[index]);
    notifyListeners();
  }

  // ******************* product images index **********************

  void setProductImageIndex(int index) {
    currentImage = index;
    notifyListeners();
  }

  // ***************************** product wish list **********************

  addToWishList(int id) {
    int index = productData.indexWhere((element) => element.id == id);
    productData[index].isLike = !productData[index].isLike;
    notifyListeners();
  }

  // ************************ product cart increment ******************

  void addQuantity(index) {
    if (cartData[index].quantity < 10) {
      cartData[index].quantity = ++cartData[index].quantity;
      notifyListeners();
    }
  }

  // ************************ product cart increment ******************

  void removeQuantity(index) {
    if (cartData[index].quantity > 1) {
      cartData[index].quantity = --cartData[index].quantity;
    }
    notifyListeners();
  }

  // ********************** add product to checkout ***************************

  void addProductToCheckOut(bool iscart, {int id = 0}) {
    isCart = iscart;
    if (id > 0) {
      checkout.clear();
      int index = productData.indexWhere((element) => element.id == id);
      checkout.add(productData[index]);
      notifyListeners();
    }
    notifyListeners();
  }

  // **************** clear state ***************
  void clear() {
    productData = [];
    isLoading = false;
    notifyListeners();
  }
}
