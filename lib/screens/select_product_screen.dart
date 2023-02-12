import 'package:flutter/material.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/widgets/products_list.dart';

class SelectProductScreen extends StatelessWidget {

  const SelectProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    List<Product> registeredProducts = args['list'];
    bool showZeros = args['showZeros'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona un producto'),
        elevation: 0,
      ),
      body: ProductsList(
        filter: (lista) {
          return [
            ...lista.where((product) {
            final int code = product.code;
            return (showZeros) 
              ? [...registeredProducts.where((p) => p.code == code)].isEmpty
              : product.quantity!=0 && [...registeredProducts.where((p) => p.code == code)].isEmpty;
          })];
        },
        returnProduct: true,
      ),
    );
  }
}