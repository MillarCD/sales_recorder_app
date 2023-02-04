import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/providers/order_provider.dart';
import 'package:register_sale_app/widgets/add_product_button.dart';
import 'package:register_sale_app/widgets/dismissible_background.dart';
import 'package:register_sale_app/widgets/form_dialog.dart';
import 'package:register_sale_app/widgets/register_dialog.dart';
import 'package:register_sale_app/widgets/selected_product_card.dart';

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
                        child: SelectedProductCard(product: entry.key, quantity: entry.value[0].round())
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
                final Product? product = await Navigator.pushNamed(context, 'select_product') as Product?;
                if (product==null) return;
                

                await showDialog(context: context, builder: (context) {
                  return const FormDialog(title: 'Ingrese Precio', hintText: '\$100');
                });

                // TODO: show dialog to enter price
                orderProvider.addNewProduct(product, 100);
              }
            ),
            
            const SizedBox(height: 5,),
            
            AddProductButton(
              size: size,
              title: 'Escanear Producto',
              onPressed: () async {
                  final Product? product = await Navigator.pushNamed(context, 'barcode_reader') as Product?;
                  if (product == null) return;
                  
                  // TODO: show dialog to enter price
                  orderProvider.addNewProduct(product, 100);
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
            
                final bool? res = await showDialog(
                  context: context,
                  builder: (context) => RegisterDialog(title: '¿Registrar Pedido?', content: 'Total: $total'),
                );
        
                if (res == null || !res)  return;
                final bool wasRegister = await orderProvider.registerSale();

                if (!wasRegister) return;
                scaffoldMessenger(const SnackBar(content: Text('Pedido registrado'),));
              },

              child: const Text('Registrar Pedido', style: TextStyle(fontSize: 21))
            )
          ]
        ),
      ),
    );
  }

}