import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/providers/sale_provider.dart';
import 'package:register_sale_app/widgets/selected_product_card.dart';

class SaleScreen extends StatelessWidget {

  const SaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final SaleProvider saleProvider = Provider.of<SaleProvider>(context);

    return Scaffold(
      body: Container(
        color: Colors.greenAccent,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [

            ...saleProvider.products.map((Product product) {
              return SelectedProductCard(product: product);
            }),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {}, // TODO: desplegar modal con productos
                child: const Text('Agregar Producto'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {}, // TODO: poner escaner
                child: const Text('Escanear Producto'),
              ),
            )
          ],
        ),
      ),
    );
  }
}