
import 'package:flutter/material.dart';

class FormDialog extends StatelessWidget {
  const FormDialog({super.key, required this.title, required this.hintText});

  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    String value = '';
    return SimpleDialog(
      title: Text(title),
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color:Theme.of(context).colorScheme.secondary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
          ),
          onChanged: (v) => value = v,
        )
      ],
    );
  }
}