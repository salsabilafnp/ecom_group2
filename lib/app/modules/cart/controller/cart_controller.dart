import 'dart:convert';

import 'package:ecom_group2/app/model/cart.dart';
import 'package:ecom_group2/app/model/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartController extends ChangeNotifier {
  Cart? _cart;
  Cart? get cart => _cart;

  static const String _baseUrl = 'https://fakestoreapi.com/carts';

  Future<void> fetchCart(int userId) async {
    final response = await http.get(Uri.parse('$_baseUrl/user/$userId'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      // Jika jsonResponse adalah List, ambil cart pertama dalam daftar
      if (jsonResponse is List) {
        if (jsonResponse.isNotEmpty) {
          _cart = Cart.fromJson(jsonResponse[0]);

          for (var item in _cart!.products) {
            item.product = await fetchProductDetail(item.productId);
          }
        }
      } else if (jsonResponse is Map) {
        _cart = Cart.fromJson(Map<String, dynamic>.from(jsonResponse));

        for (var item in _cart!.products) {
          item.product = await fetchProductDetail(item.productId);
        }
      } else {
        throw Exception('Unexpected JSON format');
      }

      notifyListeners();
    } else {
      throw Exception('Failed to load cart');
    }
  }

  Future<Product> fetchProductDetail(int productId) async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/$productId'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return Product.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load product detail');
    }
  }

  Future<void> addToCart(int userId, Product product) async {
    if (_cart == null) {
      _cart = Cart(
        id: 0,
        userId: userId,
        date: DateTime.now().toString(),
        products: [],
      );
    }

    int index =
        _cart!.products.indexWhere((item) => item.productId == product.id);
    if (index >= 0) {
      _cart!.products[index].quantity++;
    } else {
      _cart!.products.add(
          CartProducts(productId: product.id, quantity: 1, product: product));
    }

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(_cart!.toJson()),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      _cart = Cart.fromJson(jsonResponse);
      notifyListeners();
    } else {
      throw Exception('Failed to add product to cart');
    }
  }

  Future<void> increaseQuantity(int productId) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl/${_cart!.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'products': [
            {'productId': productId, 'quantity': _getQuantity(productId) + 1},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse is Map) {
          _cart = Cart.fromJson(Map<String, dynamic>.from(jsonResponse));
          // Load product details for each item in the cart
          for (var item in _cart!.products) {
            item.product = await fetchProductDetail(item.productId);
          }
          notifyListeners();
        } else {
          throw Exception('Failed to update quantity');
        }
      } else {
        throw Exception('Failed to update quantity');
      }
    } catch (e) {
      throw Exception('Failed to update quantity: $e');
    }
  }

  Future<void> decreaseQuantity(int productId) async {
    try {
      final currentQuantity = _getQuantity(productId);
      if (currentQuantity > 1) {
        final response = await http.patch(
          Uri.parse('$_baseUrl/${_cart!.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'products': [
              {'productId': productId, 'quantity': currentQuantity - 1},
            ],
          }),
        );

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          if (jsonResponse is Map) {
            _cart = Cart.fromJson(Map<String, dynamic>.from(jsonResponse));
            for (var item in _cart!.products) {
              item.product = await fetchProductDetail(item.productId);
            }
            notifyListeners();
          } else {
            throw Exception('Failed to update quantity');
          }
        } else {
          throw Exception('Failed to update quantity');
        }
      }
    } catch (e) {
      throw Exception('Failed to update quantity: $e');
    }
  }

  // Method untuk mendapatkan quantity saat ini berdasarkan productId
  int _getQuantity(int productId) {
    final item = _cart!.products.firstWhere(
      (element) => element.productId == productId,
      orElse: () => CartProducts(
        productId: productId,
        quantity: 0,
      ),
    );
    return item.quantity;
  }

  void clearCart() {
    _cart = null;
    notifyListeners();
  }
}
