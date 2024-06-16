import 'dart:convert';

import 'package:ecom_group2/app/model/product.dart';
import 'package:http/http.dart' as http;

class HomeController {
  List<Product> products = [];
  bool isLoading = false;
  bool isFavorite = false;

  Future<void> fetchProducts(String category) async {
    isLoading = true;

    String url = "https://fakestoreapi.com/products";
    if (category != 'all') {
      url = 'https://fakestoreapi.com/products/category/$category';
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        products = body.map((dynamic item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      // Handle error
      throw Exception('Failed to load products: $e');
    } finally {
      isLoading = false;
    }
  }
}
