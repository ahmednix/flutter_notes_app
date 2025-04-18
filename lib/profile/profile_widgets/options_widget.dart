import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  final IconData icon;
  final String text; 
  final Color? color; 
  final VoidCallback onPressed;

  const Options({required this.onPressed, required this.text, required this.icon, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(onPressed: onPressed, icon: Icon(icon, size: 32), color: color),
        Text(text, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
