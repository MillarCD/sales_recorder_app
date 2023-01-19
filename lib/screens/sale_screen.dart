import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/providers/sale_provider.dart';
import 'package:register_sale_app/widgets/dismissible_background.dart';
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
                    return Dismissible(
                      key: UniqueKey(),
                      background: const DismissibleBackGround(alignment: Alignment.centerLeft),
                      secondaryBackground: const DismissibleBackGround(alignment: Alignment.centerRight),
                      confirmDismiss: (direction) async {
                        final bool res = saleProvider.deleteProduct(entry.key);
                        return res;
                      },
                      child: SelectedProductCard(product: entry.key, quantity: entry.value)
                    );
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
                  print('[SALE SCREEN] registrar venta');
                  final int? total = saleProvider.getTotal();
                  if (total == null) return;

                  final bool? res = await showDialog(
                    context: context,
                    // TODO: pasar total
                    // TODO: confirmar que se añadieron productos
                    builder: (context) => RegisterDialog(total: total),
                  );

                  if (res == null || !res) {
                    print('[REGISTER SALE] $res: no pasa nada');
                    return;
                  }

                  // TODO: registrar venta con googleapi y borrar datos de saleProvider
                  print('[REGISTER SALE] $res: registrar venta y resetear saleProvider');
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