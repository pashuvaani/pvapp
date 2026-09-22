import 'package:flutter/material.dart';

class AnimalAvatar extends StatelessWidget {
  final String? species;
  final double radius;
  final bool isSelected;
  
  const AnimalAvatar({
    super.key,
    this.species,
    this.radius = 24.0,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: isSelected ? Colors.green : Colors.grey[200],
      child: const Icon(Icons.pets),
    );
  }
}
