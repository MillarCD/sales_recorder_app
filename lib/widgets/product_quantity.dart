import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:register_sale_app/providers/sale_provider.dart';
import 'package:register_sale_app/models/product.dart';

class ProductQuantity extends StatelessWidget {

  final Product product;

  const ProductQuantity({
    Key? key,
    required this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final SaleProvider saleProvider = Provider.of<SaleProvider>(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 2),
        borderRadius: BorderRadius.circular(10)
      ),
 //     color: Colors.blue,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                HapticFeedback.mediumImpact();
                saleProvider.removeOneProduct(product);
              },
              icon: const Icon(Icons.remove),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(child: Text("${saleProvider.products[product]}", style: const TextStyle(fontSize: 19))),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                HapticFeedback.mediumImpact();
                saleProvider.addOneProduct(product);
              },
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}