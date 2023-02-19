import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:register_sale_app/providers/login_provider.dart';
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

      floatingActionButton: (Provider.of<LoginProvider>(context, listen: false).selectedUser == 'Administrador') ? FloatingActionButton(
        child: const Icon( Icons.add ),
        onPressed: () => Navigator.pushNamed(context, 'create_product'),
      )
      : null,
    );
  }
}