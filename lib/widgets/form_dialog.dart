import 'package:flutter/material.dart';

class FormDialog extends StatelessWidget {
  const FormDialog({
    super.key,
    required this.title,
    required this.hintText, 
    required this.keyboardType,
    this.onChanged
  });

  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {

    
    
    return SimpleDialog(
      title: Text(title),
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,

            child: TextFormField(
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color:Theme.of(context).colorScheme.secondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
              ),
              validator: onChanged,
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('cancelar', style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
            ),

            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Aceptar', style: TextStyle(color: Theme.of(context).colorScheme.secondary))
            ),

            const SizedBox(width: 5,)
          ],
        ),
      ],
    );
  }
}