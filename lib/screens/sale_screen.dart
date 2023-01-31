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

    if (saleProvider.isRegistering) {
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
      body: SizedBox(
        height: size.height,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
                
                      _AddProductButton(
                        size: size,
                        title: 'Agregar Producto',
                        onPressed: () => Navigator.pushNamed(context, 'select_product'),
                      ),

                      const SizedBox(height: 5,),

                      _AddProductButton(
                        size: size,
                        title: 'Escanear Producto',
                        onPressed: () async {
                            final Product? product = await Navigator.pushNamed(context, 'barcode_reader') as Product?;
        
                            if (product != null) saleProvider.addNewProduct(product);
                          },
                      ),
                      
                     
                      SizedBox(
                        height: size.height * 0.12,
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
                  child: MaterialButton(
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: (saleProvider.products.isEmpty) ? null : () async {
                      final scaffoldMessenger = ScaffoldMessenger.of(context).showSnackBar;

                      final int? total = saleProvider.getTotal();
                      if (total == null) return;
                  
                      final bool? res = await showDialog(
                        context: context,
                        builder: (context) => RegisterDialog(total: total),
                      );
        
                      if (res == null || !res)  return;
                      final bool wasRegister = await saleProvider.registerSale();

                      if (!wasRegister) return;
                      scaffoldMessenger(const SnackBar(content: Text('Venta registrada'),));
                    },

                    child: const Text('Registrar Venta', style: TextStyle(fontSize: 21))
                  ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }

}

class _AddProductButton extends StatelessWidget {
  const _AddProductButton({
    Key? key,
    required this.size,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  final Size size;
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: size.height * .1,
      child: MaterialButton(
        color: Theme.of(context).colorScheme.primary,
        textColor: Theme.of(context).colorScheme.secondaryContainer,
        onPressed: onPressed,
        child: Text(title, style: const TextStyle(fontSize: 17)),
      ),
    );
  }
}