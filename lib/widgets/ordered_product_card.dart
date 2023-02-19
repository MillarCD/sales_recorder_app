import 'package:flutter/material.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/utils/utils.dart';

class OrderedProductCard extends StatelessWidget {

  final Product product;
  final double price;
  final int quantity;
  
  const OrderedProductCard({super.key, required this.product, required this.quantity, required this.price});

  @override
  Widget build(BuildContext context) {
    
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name, style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondaryContainer,   
            )),

            if (product.brand != null) Text(product.brand!, style: const TextStyle(fontSize: 17)),

            Text(
              '\$${printDoublePrice(price)} x $quantity = \$${printDoublePrice(quantity * price)}',
              style: const TextStyle(fontSize: 17)
            ),
          ],
        ),
      ),
    );
  }
}