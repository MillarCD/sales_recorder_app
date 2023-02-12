import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/providers/sale_provider.dart';
import 'package:register_sale_app/utils/utils.dart';
import 'package:register_sale_app/widgets/product_quantity.dart';

class SelectedProductCard extends StatelessWidget {

  final Product product;
  final int quantity;
  
  const SelectedProductCard({super.key, required this.product, required this.quantity,});

  @override
  Widget build(BuildContext context) {
    
    final SaleProvider saleProvider = Provider.of<SaleProvider>(context);

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
                  Text('\$${printIntPrice(product.price)}', style: const TextStyle(fontSize: 17)),
                  Text('Total: \$${printIntPrice(quantity * product.price)}', style: const TextStyle(fontSize: 17)),
                ],
              ),
            ),

            Expanded(
              flex: 2,
              child: ProductQuantity(
                quantity: quantity,
                add: () {
                  saleProvider.addOneProduct(product);
                },
                rem: () {
                  saleProvider.removeOneProduct(product);
                }
              ),
            )
          ]
        ),
      ),
    );
  }
}