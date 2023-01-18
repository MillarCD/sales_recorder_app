import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/providers/sale_provider.dart';
import 'package:register_sale_app/widgets/register_dialog.dart';
import 'package:register_sale_app/widgets/selected_product_card.dart';

class SaleScreen extends StatelessWidget {

  const SaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final SaleProvider saleProvider = Provider.of<SaleProvider>(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              color: Colors.greenAccent,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
          
                  ...saleProvider.products.entries.map((MapEntry<Product, int> entry) {
                    return SelectedProductCard(product: entry.key, quantity: entry.value);
                  }),
          
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, 'select_product'),
                      child: const Text('Agregar Producto', style: TextStyle(fontSize: 17)),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {}, // TODO: poner escaner
                      child: const Text('Escanear Producto', style: TextStyle(fontSize: 17)),
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.10,
                  )
                ],
              ),
            ),
          ),

          Positioned(
            left: -1,
            right: -1,
            bottom: 10,
            child: Container(
              height: size.height * .1,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                onPressed: () async {
                  // TODO: desplegar modal de confirmacion
                  print('[SALE SCREEN] registrar venta');
                  final res = await showDialog(
                    context: context,
                    builder: (context) => const RegisterDialog(total: 10),
                  );

                  print('[REGISTER SALE] res: $res');
                },
                child: const Text('Registrar Venta', style: TextStyle(fontSize: 21))
              ),
            ),
          )
        ]
      ),
    );
  }
}