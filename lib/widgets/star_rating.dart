import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int stars;
  final double size;

  const StarRating({
    Key? key,
    required this.stars,
    this.size = 32,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        3,
        (index) => Icon(
          index < stars ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: size,
        ),
      ),
    );
  }
}
