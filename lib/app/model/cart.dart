import 'package:ecom_group2/app/model/product.dart';

class Cart {
  final int id;
  final int userId;
  final String date;
  final List<CartProducts> products;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id']?.toInt() ?? 0,
      userId: json['userId']?.toInt() ?? 0,
      date: json['date'].toString(),
      products: (json['products'] as List)
          .map((item) => CartProducts.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['date'] = date;
    data['products'] = products.map((item) => item.toJson()).toList();
    return data;
  }
}

class CartProducts {
  final int productId;
  int quantity;
  Product? product;

  CartProducts({
    required this.productId,
    required this.quantity,
    this.product,
  });

  factory CartProducts.fromJson(Map<String, dynamic> json) {
    return CartProducts(
      productId: json['productId']?.toInt(),
      quantity: json['quantity']?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}
