import 'package:ecom_group2/app/components/custom_appbar.dart';
import 'package:ecom_group2/app/modules/cart/controller/cart_controller.dart';
import 'package:ecom_group2/flutter/packages/flutter/test/rendering/table_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
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
        title: 'Checkout Product',
        appBarType: AppBarType.cart,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Shipping Addreses",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Location",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("Addressing")
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {},
                      child: const Text(
                        "Change",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.black),
              const Text(
                "Choose Shipping",
                style: TextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  Transform.flip(
                    flipX: true,
                    child: const Icon(
                      Icons.local_shipping_outlined,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "COD",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("Estimated Arrival: 31 June 2024")
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {},
                      child: const Text(
                        "Change",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Order List",
                style: TextStyle(fontSize: 20),
              ),
              FutureBuilder(
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
                      shrinkWrap: true,
                      itemCount: cartController.cart!.products.length,
                      itemBuilder: (context, index) {
                        final item = cartController.cart!.products[index];

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                item.product != null
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
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          item.product?.title ?? 'Loading ...'),
                                      item.product?.category ==
                                                  "men's clothing" ||
                                              item.product?.category ==
                                                  "women's clothing"
                                          ? const Text(
                                              'Sized : M',
                                            )
                                          : const Text(""),
                                      Text(
                                          "Count : ${item.quantity.toString()}")
                                    ],
                                  ),
                                ),
                                // Spacer(),
                                Column(
                                  children: [
                                    const Text("Price"),
                                    Text(
                                        "\$${item.product!.price.toStringAsFixed(2)}"),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
              const Text("Total"),
              const Text("Count : 5"),
              const Text("price : \$"),
            ],
          ),
        ),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton.icon(
          onPressed: () {
            // Logic to proceed to checkout
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => CheckoutView()));
          },
          label: const Text('Continue  to payment'),
          // icon: const Icon(
          //   Icons.shopping_cart_checkout_outlined,
          //   size: 16,
          // ),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.blue[900]!),
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}
