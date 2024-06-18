import 'dart:convert';

import 'package:ecom_group2/app/model/product.dart';
import 'package:http/http.dart' as http;

class HistoryTransaksiController {
  List<Product> products = [];
  bool isLoading = false;
  bool isFavorite = false;

  Future<Map<String, dynamic>> fetchProducts() async {
    String url = "https://fakestoreapi.com/products";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        products = body.map((dynamic item) => Product.fromJson(item)).toList();
        return {'products': products};
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
