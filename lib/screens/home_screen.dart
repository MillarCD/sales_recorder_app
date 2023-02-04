import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_sale_app/providers/products_provider.dart';
import 'package:register_sale_app/services/spreadsheet_service.dart';
import 'package:register_sale_app/widgets/no_connection_dialog.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: productProvider.isLoadingProduct
        ? Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary))
        : SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _MenuButton(
              title: 'Registrar Venta',
              onPressed: () async => navigateIfConnected(context, 'sale'),
            ),

            const SizedBox(height: 50,),

            _MenuButton(
              title: 'Registrar Pedido',
              onPressed: () async => await navigateIfConnected(context, 'order'),
            ),

            const SizedBox(height: 50,),


            _MenuButton(
              title: 'Ver Productos',
              onPressed: () async => await navigateIfConnected(context, 'products'),
            )
          ],
        ),
      )
    );
  }

  Future<void> navigateIfConnected(BuildContext context, String route) async {
    final ProductProvider productProvider = Provider.of<ProductProvider>(context, listen: false);

    if (SpreadsheetService.ssService.isConnected) {
      Navigator.pushNamed(context, route);
      return;
    }

    await showDialog(
      context: context, 
      builder: (context) => const NoConnectionDialog()
    );

    await productProvider.loadProducts();
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({
    Key? key,
    required this.title,
    this.onPressed
  }) : super(key: key);

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .1,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: MaterialButton(
        color: Theme.of(context).colorScheme.secondary,
        onPressed: onPressed,
        child: Text(title, style: const TextStyle(fontSize: 21))
      ),
    );
  }
}