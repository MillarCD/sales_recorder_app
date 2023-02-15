import 'package:flutter/material.dart';

class SnackBarContent extends StatelessWidget {

  final IconData icon;
  final String message;
  final Color iconColor;

  const SnackBarContent({
    Key? key,
    required this.icon,
    required this.message,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
    
          Icon(icon, color: iconColor),
    
          const SizedBox(width: 15,),
    
          Text(message),
    
        ],
    );
  }
}