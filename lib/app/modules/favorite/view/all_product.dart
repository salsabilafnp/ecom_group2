import 'package:ecom_group2/app/model/product.dart';
import 'package:ecom_group2/app/modules/favorite/controller/all_product.dart';
import 'package:flutter/material.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  bool isFavorite = false;

  void initState() {
    setState(() {
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchAllProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildView(snapshot.data as List<Product>);
          }
          return Text("Error ${snapshot.error}");
        });
  }

  Widget buildView(List<Product> data) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisExtent: 300),
        itemBuilder: (_, index) {
          final getData = data[index];
          return Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      // GAMBAR, LIKE, SHARE
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 9 / 10,
                              child: Image.network(
                                getData.image,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              top: 3,
                              left: 4,
                              child: GestureDetector(
                                child: const Icon(Icons.share),
                                onTap: () {
                                  print(
                                      "Anda Berhasil Melakukan Share Product");
                                },
                              ),
                            ),
                            Positioned(
                              top: 3,
                              right: 5,
                              child: GestureDetector(
                                  child: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border_outlined,
                                      color: isFavorite
                                          ? Colors.red
                                          : Colors.black),
                                  onTap: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                  } // Kalo ditekan produk hilang dari favorite,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      //INFO PRODUK
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              getData.title,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ), // Nama produk

                          Text("${getData.rating.rate}",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight:
                                      FontWeight.bold)), // Rating produk
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3),
                                child: Text("\$${getData.price}",
                                    style: TextStyle(
                                      fontSize: 15,
                                    )),
                              ),
                              Text("Stock: ${getData.rating.count}",
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
        });
  }
}
