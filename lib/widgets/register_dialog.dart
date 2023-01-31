import 'package:flutter/material.dart';

class RegisterDialog extends StatelessWidget {

  final int total;

  const RegisterDialog({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('¿Registrar venta?'),
      content: Text('Total: \$$total'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('cancelar', style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('Registrar', style: TextStyle(color: Theme.of(context).colorScheme.secondary))
        )
      ],
    );
  }
}