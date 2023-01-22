import 'package:flutter/material.dart';

import 'package:register_sale_app/models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    this.color
  }) : super(key: key);

  final Product product;
  final Color? color;
  

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                    if (product.brand != null) Text(product.brand!, style: const TextStyle(fontSize: 19)),
                    Text(product.code.toString()),
                  ],
                ),
              ),
            ),
      
            Expanded(
              flex: 1,
              child: Container(
                child: Center(child: Text('\$${product.price}', style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold))),
              ),
            )
          ],
        ),
      )
    );
  }
}