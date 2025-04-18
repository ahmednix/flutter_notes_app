import 'package:flutter/material.dart';

class SeasonWidget extends StatelessWidget {
  final String imagePath;
  final String imageText;

  const SeasonWidget({
    required this.imagePath,
    required this.imageText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(height: 150, width: 150, fit: BoxFit.fill, imagePath),

        Text(imageText, style: TextStyle(color: Colors.white, fontSize: 24)),
      ],
    );
  }
}
