import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListLikeProduct extends StatelessWidget {
  const ListLikeProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey[600], borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                // GAMBAR, LIKE, SHARE
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      Image.network(
                        "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 3,
                        left: 4,
                        child: GestureDetector(
                          child: const Icon(Icons.share),
                          onTap: () {
                            print("Anda Berhasil Melakukan Share Product");
                          },
                        ),
                      ),
                      Positioned(
                        top: 3,
                        right: 5,
                        child: GestureDetector(
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onTap:
                                () {} // Kalo ditekan produk hilang dari favorite,
                            ),
                      ),
                    ],
                  ),
                ),

                //INFO PRODUK
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Mens Cotton Jacket",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ), // Nama produk

                    Text("4.7",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold)), // Rating produk
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          child: Text("\$55.99",
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        Text("Stock: 500",
                            style: TextStyle(
                              fontSize: 15,
                            )),
                      ],
                    ),
                    Icon(Icons.shopping_cart_outlined)
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
