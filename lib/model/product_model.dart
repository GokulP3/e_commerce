class Product {
  final int id;
  final String title;
  final String desc;
  final dynamic price;
  final dynamic discPerc;
  final dynamic rating;
  final int stock;
  final String brand;
  final String category;
  final List productImages;
  bool isLike;
  int quantity;
  Product(
      {required this.brand,
      required this.price,
      required this.title,
      required this.id,
      required this.category,
      required this.desc,
      required this.discPerc,
      required this.productImages,
      required this.rating,
      required this.stock,
      required this.isLike,
      required this.quantity});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      brand: json['brand'],
      price: json['price'],
      title: json['title'],
      id: json['id'],
      category: json['category'],
      desc: json['description'],
      discPerc: json['discount_percentage'],
      productImages: json['images'],
      rating: json['rating'],
      stock: json['stock'],
      quantity: json['quantity'] ?? 1,
      isLike: json['is_like'] ?? false);
}
