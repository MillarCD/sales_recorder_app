import 'package:flutter/material.dart';

class AddProductButton extends StatelessWidget {
  const AddProductButton({
    Key? key,
    required this.size,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  final Size size;
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: size.height * .1,
      child: MaterialButton(
        color: Theme.of(context).colorScheme.primary,
        textColor: Theme.of(context).colorScheme.secondaryContainer,
        onPressed: onPressed,
        child: Text(title, style: const TextStyle(fontSize: 17)),
      ),
    );
  }
}