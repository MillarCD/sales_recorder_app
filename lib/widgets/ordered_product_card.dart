import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/providers/order_provider.dart';
import 'package:register_sale_app/utils/utils.dart';
import 'package:register_sale_app/widgets/product_quantity.dart';

class OrderedProductCard extends StatelessWidget {

  final Product product;
  final double price;
  final int quantity;
  
  const OrderedProductCard({super.key, required this.product, required this.quantity, required this.price});

  @override
  Widget build(BuildContext context) {
    
    final OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  )),
                  if (product.brand != null) Text(product.brand!, style: const TextStyle(fontSize: 17)),
                  Text('\$${price.toString()}', style: const TextStyle(fontSize: 17)),
                  Text('Total: \$${printDoublePrice(quantity * price)}', style: const TextStyle(fontSize: 17)),
                ],
              ),
            ),

            Expanded(
              flex: 2,
              child: ProductQuantity(
                quantity: quantity,
                add: () {
                  orderProvider.addOneProduct(product);
                },
                rem: () {
                  orderProvider.removeOneProduct(product);
                }
              ),
            )
          ]
        ),
      ),
    );
  }
}