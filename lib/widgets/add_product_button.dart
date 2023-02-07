import 'package:flutter/material.dart';

class AddProductButton extends StatelessWidget {
  const AddProductButton({
    Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: MaterialButton(
        color: Theme.of(context).colorScheme.primary,
        textColor: Theme.of(context).colorScheme.secondaryContainer,
        onPressed: onPressed,
        child: Text(title, style: const TextStyle(fontSize: 17)),
      ),
    );
  }
}