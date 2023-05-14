import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({super.key, required this.options, required this.color,});
  final String options;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: ListTile(
        title: Text(options,
        style: const TextStyle(fontSize: 25),
        textAlign: TextAlign.center,)
      ),
    
    );
  }
}