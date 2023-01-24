import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _MenuButton(
              title: 'Registrar Venta',
              onPressed: () => Navigator.pushNamed(context, 'sale'),
            ),

            const SizedBox(height: 50,),

            const _MenuButton(
              title: 'Registrar Pedido'
            ),

            const SizedBox(height: 50,),


            _MenuButton(
              title: 'Ver Productos',
              onPressed: () => Navigator.pushNamed(context, 'products'),
            )
          ],
        ),
      )
    );
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