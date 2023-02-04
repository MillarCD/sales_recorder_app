import 'package:flutter/material.dart';

class RegisterDialog extends StatelessWidget {

  final String title;
  final String content;

  const RegisterDialog({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
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