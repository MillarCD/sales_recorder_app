import 'package:flutter/material.dart';
import 'package:register_sale_app/widgets/products_list.dart';

class ProductsScreen extends StatelessWidget {

  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        elevation: 0,
      ),
      body: const ProductsList(),
    );
  }
}