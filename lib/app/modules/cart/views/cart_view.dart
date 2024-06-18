import 'package:ecom_group2/app/components/custom_appbar.dart';
import 'package:ecom_group2/app/modules/cart/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late Future<void> _fetchCartFuture;

  @override
  void initState() {
    super.initState();
    final cartController = Provider.of<CartController>(context, listen: false);
    _fetchCartFuture = cartController.fetchCart(1); // Assuming userId 1
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);

    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Shopping Cart',
        appBarType: AppBarType.cart,
      ),
      body: FutureBuilder(
        future: _fetchCartFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (cartController.cart == null ||
              cartController.cart!.products.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          } else {
            return ListView.builder(
              itemCount: cartController.cart!.products.length,
              itemBuilder: (context, index) {
                final item = cartController.cart!.products[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 15,
                  ),
                  child: ListTile(
                    leading: item.product != null
                        ? Image.network(
                            item.product?.image ?? '',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          ),
                    title: Text(item.product?.title ?? 'Loading ...'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price: \$${item.product?.price.toStringAsFixed(2) ?? 'Loading...'}',
                        ),
                        // const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total: \$${(item.product?.price ?? 0.0) * item.quantity}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Decrease quantity
                                    cartController
                                        .decreaseQuantity(item.productId);
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    size: 14,
                                  ),
                                ),
                                Text(item.quantity.toString()),
                                IconButton(
                                  onPressed: () {
                                    // Increase quantity
                                    cartController
                                        .increaseQuantity(item.productId);
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton.icon(
          onPressed: () {
            // Logic to proceed to checkout
          },
          label: const Text('Proceed to Checkout'),
          icon: const Icon(
            Icons.shopping_cart_checkout_outlined,
            size: 16,
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.blue[900]!),
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}
