import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
          onPressed: () => Navigator.pop(context),
          child: const Text('cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Registrar')
        )
      ],
    );
  }
}