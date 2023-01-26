import 'package:flutter/material.dart';

class NoConnectionDialog extends StatelessWidget {

  const NoConnectionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon( Icons.wifi_off_rounded),
      title: const Text('Verifica tu conección de internet'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Listo', style: TextStyle(color: Theme.of(context).colorScheme.secondary),)
        ),
      ],
    );
  }
}