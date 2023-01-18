import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/providers/products_provider.dart';
import 'package:register_sale_app/providers/sale_provider.dart';
import 'package:register_sale_app/widgets/product_card.dart';

class SelectProductScreen extends StatelessWidget {

  const SelectProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ProductProvider productProvider = Provider.of<ProductProvider>(context);
    final SaleProvider saleProvider = Provider.of<SaleProvider>(context);
    
    return Scaffold(
      body: (productProvider.products == null) 
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: productProvider.products!.length,
          itemBuilder: (context, index) {
            final Product product = productProvider.products![index];

            return GestureDetector(
              child: ProductCard(product: product),
              onTap:() {
                print('[GESTURE DETECTOR] product: ${product.name}');
                saleProvider.addNewProduct(product);
                Navigator.pop(context);
              },
            );
          },
        )
    );
  }
}