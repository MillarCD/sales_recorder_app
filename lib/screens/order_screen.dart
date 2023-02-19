import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:register_sale_app/models/product.dart';
import 'package:register_sale_app/providers/order_provider.dart';
import 'package:register_sale_app/utils/utils.dart';
import 'package:register_sale_app/widgets/add_product_button.dart';
import 'package:register_sale_app/widgets/dismissible_background.dart';
import 'package:register_sale_app/widgets/form_dialog.dart';
import 'package:register_sale_app/widgets/loading_widget.dart';
import 'package:register_sale_app/widgets/ordered_product_card.dart';
import 'package:register_sale_app/widgets/snack_bar_content.dart';

class OrderScreen extends StatelessWidget {

  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    final Size size = MediaQuery.of(context).size;

    if (orderProvider.isRegistering) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: const LoadingWidget()
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
              title: 'Agregar Producto',
              onPressed: () async {
                final Product? product = await Navigator.pushNamed(
                  context, 'select_product',
                  arguments: {
                    'list': orderProvider.getProducts(),
                    'showZeros': true,
                  }
                ) as Product?;
                if (product==null) return;
              
                Map<String, dynamic>? res = await showDialog(context: context, builder: (context) {
                  return const _EnterPriceDialog();
                });

                if (res == null) return;
                
                orderProvider.addNewProduct(product, res['price'], res['quantity']);

              }
            ),
            
            const SizedBox(height: 5,),
            
            AddProductButton(
              title: 'Escanear Producto',
              onPressed: () async {
                final Product? product = await Navigator.pushNamed(context, 'barcode_reader') as Product?;
                if (product == null) return;

                Map<String, dynamic>? res = await showDialog(context: context, builder: (context) {
                  return const _EnterPriceDialog();
                });

                if (res == null) return;
                
                orderProvider.addNewProduct(product, res['price'], res['quantity']);

              },
            ),

            const SizedBox(height: 10),
        
            MaterialButton(
              minWidth: double.infinity,
              height: 60,
              color: Theme.of(context).colorScheme.secondary,
              onPressed: (orderProvider.products.isEmpty) ? null : () async {
                final scaffoldMessenger = ScaffoldMessenger.of(context).showSnackBar;
                final double? total = orderProvider.getTotal();
                if (total == null) {
                  scaffoldMessenger( noRegister() );
                  return;
                }
            
                Map<String, dynamic>? res = await showDialog(context: context, builder: (context) {
                    String supplier = '';
                    
                    return FormDialog(
                      title: 'Ingrese un proveedor para registrar pedido',
                      ifIsValidForm: () => Navigator.pop(context, {'supplier': supplier}),
           
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Prooveedor',
                          ),
                          validator: (value) {
                            if (value == null || value == '') return 'Debe ingresar un texto valido';

                            supplier = value;
                            return null;
                          },
                        ),
                      ],
                    );
                });
                if (res == null)  {
                  scaffoldMessenger( noRegister() );
                  return;
                }

                final bool wasRegister = await orderProvider.registerOrder(res['supplier']);

                if (!wasRegister) {
                  scaffoldMessenger( noRegister() );
                  return;
                }

                scaffoldMessenger(
                  const SnackBar(
                    content: SnackBarContent(
                      icon: Icons.check_circle_outline,
                      iconColor: Colors.green,
                      message: 'Pedido registrado',
                    )
                  )
                );
              },

              child: Text('Registrar Pedido (\$${printDoublePrice(orderProvider.getTotal() ?? 0)})', style: const TextStyle(fontSize: 21))
            )
          ]
        ),
      ),
    );
  }

  SnackBar noRegister() {
    return const SnackBar(
      content: SnackBarContent(
      icon: Icons.cancel_outlined,
      iconColor: Colors.red,
      message: 'No se pudo registrar el pedido',
      )
    );
  }

}

class _EnterPriceDialog extends StatelessWidget {
  const _EnterPriceDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int quantity = 0;
    double price = 0;

    return FormDialog(
      title: 'Ingresar Precio (sin impuesto)',

      ifIsValidForm: () => Navigator.pop(context, {'price': price, 'quantity': quantity}),

      children: [

        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Precio'
          ),
          keyboardType: const TextInputType.numberWithOptions(),
          validator: (value) {
            double? v;

            if ((v = double.tryParse(value ?? '')) == null) {
              return 'Debe ingresar un numero valido';
            } else if (v! <= 0) {
              return 'El precio debe ser mayor a 0';
            }

            price = v;
            return null;
          },
        ),

        const SizedBox(height: 10,),

        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Cantidad'
          ),
          keyboardType: const TextInputType.numberWithOptions(),
          validator: (value) {
            int? v;

            if ((v = int.tryParse(value ?? '')) == null) {
              return 'Debe ingresar un numero valido';
            } else if (v! <= 0) {
              return 'La cantidad debe ser mayor a 0';
            }

            quantity = v;
            return null;
          },
        ),

      ],
    );
  }
}