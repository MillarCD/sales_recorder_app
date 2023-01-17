import 'package:flutter/material.dart';

import 'package:register_sale_app/models/product.dart';

class SelectedProductCard extends StatelessWidget {
  final Product product;
  const SelectedProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                  if (product.brand != null) Text(product.brand!, style: const TextStyle(fontSize: 19)),
                  Text('\$${product.price.toString()}', style: const TextStyle(fontSize: 19)),
                  const Text('Total: ', style: TextStyle(fontSize: 19)),
                ],
              ),
            ),

            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('- | 2 | +'),
              ),
            )
          ]
        ),
      ),
    );
  }
}