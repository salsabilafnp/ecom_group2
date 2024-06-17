import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final int productId;
  final String imageUrl;
  final String title;
  final double rating;
  final double price;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onCardTap;

  const ProductCard({
    super.key,
    required this.productId,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.price,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Card(
        color: const Color.fromARGB(255, 190, 190, 190),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fitHeight,
                      width: double.infinity,
                      height: 150,
                    ),
                  ),
                  GestureDetector(
                    onTap: onFavoriteToggle,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_outline,
                        size: 17,
                        color: isFavorite ? Colors.red : null,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 13),
                  ),
                  const Icon(
                    Icons.star,
                    size: 13,
                    color: Color(0xffFFFF00),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$${price.toStringAsFixed(2)}"),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
