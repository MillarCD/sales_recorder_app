import 'package:flutter/material.dart';

import 'package:register_sale_app/models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;
  

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  )),
                  if (product.brand != null) Text(product.brand!, style: const TextStyle(fontSize: 18)),
                  Text(product.code.toString()),
                ],
              ),
            ),
      
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text('\$${product.price}', style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  )),

                  Text('Cantidad: ${product.quantity}'),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}