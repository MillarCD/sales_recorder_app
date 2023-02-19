import 'package:flutter/material.dart';

class FormDialog extends StatelessWidget {
  const FormDialog({
    super.key,
    required this.title,
    required this.children,
    this.ifIsValidForm,
  });

  final String title;
  final List<Widget> children;
  final void Function()? ifIsValidForm;

  @override
  Widget build(BuildContext context) {

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return SimpleDialog(
      title: Text(title),
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: Form(
            key: formKey,

            child: Column(
              children: children,
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('cancelar', style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
            ),

            TextButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  if (ifIsValidForm == null) return;
                  ifIsValidForm!();
                }
              },
              child: Text('Aceptar', style: TextStyle(color: Theme.of(context).colorScheme.secondary))
            ),

            const SizedBox(width: 5,)
          ],
        ),
      ],
    );
  }
}