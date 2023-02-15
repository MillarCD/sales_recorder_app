import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:register_sale_app/providers/login_provider.dart';
import 'package:register_sale_app/providers/products_provider.dart';
import 'package:register_sale_app/services/spreadsheet_service.dart';
import 'package:register_sale_app/widgets/loading_widget.dart';
import 'package:register_sale_app/widgets/no_connection_dialog.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ProductProvider productProvider = Provider.of<ProductProvider>(context);
    final String user = Provider.of<LoginProvider>(context, listen: false).selectedUser;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<LoginProvider>(context, listen: false).isSignIn = false;
              Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
            },
            icon: const Icon( Icons.logout_outlined )
          )
        ],
      ),

      body: productProvider.isLoadingProduct
        ? const LoadingWidget()
        : SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _MenuButton(
              title: 'Registrar Venta',
              icon: Icons.moving_outlined,
              onPressed: () async => navigateIfConnected(context, 'sale'),
            ),

            const SizedBox(height: 50,),

            if (user == 'Administrador') _MenuButton(
              title: 'Registrar Pedido',
              icon: Icons.cloud_upload_outlined,
              onPressed: () async => await navigateIfConnected(context, 'order'),
            ),

            const SizedBox(height: 50,),


            if (user == 'Administrador') _MenuButton(
              title: 'Ver Productos',
              icon: Icons.paste_rounded,
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
    required this.icon,
    this.onPressed
  }) : super(key: key);

  final String title;
  final IconData  icon;
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 10,),

            Icon( icon, color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.5), ),
            
            const SizedBox(width: 50,),

            Text(title, style: TextStyle(fontSize: 21, color: Theme.of(context).colorScheme.onSecondary,))
          ]
        ),
      ),
    );
  }
}