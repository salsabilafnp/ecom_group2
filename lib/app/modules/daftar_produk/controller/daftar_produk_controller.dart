import 'dart:convert';

import 'package:ecom_group2/app/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DaftarProdukController {
  List<Product> products = [];
  bool isLoading = false;
  bool isFavorite = false;

  Future<String> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? category = prefs.getString('category') ?? 'all';
    return category;
  }

  Future<Map<String, dynamic>> fetchProducts() async {
    String category = await getData();
    category = category.toLowerCase();

    String url = "https://fakestoreapi.com/products";
    if (category != 'all') {
      url = 'https://fakestoreapi.com/products/category/$category';
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        products = body.map((dynamic item) => Product.fromJson(item)).toList();
        return {'category': category, 'products': products};
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    } finally {
      isLoading = false;
    }
  }
}
