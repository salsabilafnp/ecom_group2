import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/product.dart';

Future<List<Product>> fetchAllProduct() async {
  final response =
      await http.get(Uri.parse("https://fakestoreapi.com/products"));

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    final listProduct = responseBody as List;
    final result = listProduct.map((e) => Product.fromJson(e)).toList();
    return result;
  } else {
    throw Exception("Failed to load data");
  }
}
