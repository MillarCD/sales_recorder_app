import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/providers/order_provider.dart';
import 'package:register_sale_app/widgets/add_product_button.dart';
import 'package:register_sale_app/widgets/dismissible_background.dart';
import 'package:register_sale_app/widgets/form_dialog.dart';
import 'package:register_sale_app/widgets/ordered_product_card.dart';
import 'package:register_sale_app/widgets/register_dialog.dart';

class OrderScreen extends StatelessWidget {

  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    final Size size = MediaQuery.of(context).size;

    if (orderProvider.isRegistering) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          ),
        )
      );
    }
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        height: size.height,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [              
                    ...orderProvider.products.entries.map((MapEntry<Product, List<double>> entry) {

                      return Dismissible(
                        key: UniqueKey(),
                        background: const DismissibleBackGround(alignment: Alignment.centerLeft),
                        secondaryBackground: const DismissibleBackGround(alignment: Alignment.centerRight),
                        confirmDismiss: (direction) async {
                          final bool res = orderProvider.deleteProduct(entry.key);
                          return res;
                        },
                        child: OrderedProductCard(
                          product: entry.key, 
                          quantity: entry.value[0].round(),
                          price: entry.value[1],
                        )
                      );
                    }),
                    
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10,),

            AddProductButton(
              size: size,
              title: 'Agregar Producto',
              onPressed: () async {
                final Product? product = await Navigator.pushNamed(
                  context, 'select_product',
                  arguments: orderProvider.getProducts()
                ) as Product?;
                if (product==null) return;
              
                double? res = double.tryParse(await showDialog(context: context, builder: (context) {
                  return enterPriceDialog();
                }) ?? '');

                if (res == null) return;
                
                orderProvider.addNewProduct(product, res);

              }
            ),
            
            const SizedBox(height: 5,),
            
            AddProductButton(
              size: size,
              title: 'Escanear Producto',
              onPressed: () async {
                final Product? product = await Navigator.pushNamed(context, 'barcode_reader') as Product?;
                if (product == null) return;

                double? res = double.tryParse(await showDialog(context: context, builder: (context) {
                  return enterPriceDialog();
                }) ?? '');

                if (res == null) return;
                
                orderProvider.addNewProduct(product, res);

              },
            ),

            const SizedBox(height: 10),
        
            MaterialButton(
              minWidth: double.infinity,
              height: size.height * .1,
              color: Theme.of(context).colorScheme.secondary,
              onPressed: (orderProvider.products.isEmpty) ? null : () async {
                print('[SALE SCREEN] registrar venta');
                final scaffoldMessenger = ScaffoldMessenger.of(context).showSnackBar;
                // TODO: show dialog to enter proovedor
                final double? total = orderProvider.getTotal();
                if (total == null) return;
            

                String? res = await showDialog(context: context, builder: (context) {
                    return FormDialog(
                      title: 'Ingrese un proveedor para registrar pedido',
                      hintText: 'Proveedor',
                      keyboardType: TextInputType.text,
                      validate: (value) {
                        if (value == null) return 'Debe ingresar un texto valido';
                    
                        return null;
                      },
                    );
                });
        
                if (res == null)  return;

                final bool wasRegister = await orderProvider.registerOrder(res);

                if (!wasRegister) return;
                scaffoldMessenger(const SnackBar(content: Text('Pedido registrado'),));
              },

              child: Text('Registrar Pedido (\$${orderProvider.getTotal()})', style: const TextStyle(fontSize: 21))
            )
          ]
        ),
      ),
    );
  }

    Widget enterPriceDialog() {
      return FormDialog(
        title: 'Ingresar Precio',
        hintText: '\$100',
        keyboardType: const TextInputType.numberWithOptions(),
        validate: (value) {
          if (double.tryParse(value ?? '') == null) {
            return 'Debe ingresar un numero valido';
          } else if (double.parse(value!) <= 0) {
            return 'El precio debe ser mayor a 0';
          }
          return null;
        },
      );

  }

}