import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/providers/products_provider.dart';
import 'package:register_sale_app/widgets/product_card.dart';


class ProductsScreen extends StatelessWidget {

  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      body: (productProvider.products.isEmpty) 
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: productProvider.products.length,
          itemBuilder: (context, index) {
            final Product product = productProvider.products[index];
            return ProductCard(product: product);
          },
        ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.shopping_cart_outlined),
        onPressed: () {
          Navigator.pushNamed(context, 'sale');
        },
      ),
    );
  }
}