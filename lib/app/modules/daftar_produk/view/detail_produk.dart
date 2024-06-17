import 'package:ecom_group2/app/model/product.dart';
import 'package:flutter/material.dart';

import '../controller/daftar_produk_controller.dart';

class DetailProductView extends StatefulWidget {
  final int productId;
  const DetailProductView({super.key, required this.productId});

  @override
  State<DetailProductView> createState() => _DetailProductViewState();
}

class _DetailProductViewState extends State<DetailProductView> {
  late Future<Product> _futureProduct;
  late DaftarProdukController _controller;

  @override
  void initState() {
    super.initState();
    _futureProduct =
        DaftarProdukController().fetchProductDetail(widget.productId);
    _controller = DaftarProdukController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product'),
        centerTitle: true,
        actions: [
          // Favorite Button
          IconButton(
            icon: Icon(
              _controller.isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: _controller.isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              setState(() {
                _controller.isFavorite = !_controller.isFavorite;
              });
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<Product>(
        future: _futureProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Product not found'));
          } else {
            final product = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  Center(
                    child: Image.network(
                      product.image,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Category
                      Text(
                        product.category.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // Rating
                      Row(
                        children: [
                          // Rating
                          Row(
                            children: [
                              Text(
                                product.rating.rate.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: Color(0xffFFFF00),
                              ),
                            ],
                          ),
                          const SizedBox(width: 5),
                          const Text("from"),
                          const SizedBox(width: 5),
                          // Rating
                          Text(
                            product.rating.count.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Product Name
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Product Details
                  const Text(
                    "Product Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(product.description),
                  const Spacer(),
                  // Price and Add to Cart Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Logic to add product to cart
                        },
                        label: const Text('Add to Cart'),
                        icon: const Icon(
                          Icons.add_shopping_cart_outlined,
                          size: 16,
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.blue[900]!),
                          foregroundColor:
                              WidgetStateProperty.all<Color>(Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
