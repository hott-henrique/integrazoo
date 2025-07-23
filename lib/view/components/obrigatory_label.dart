import 'package:flutter/material.dart';

class ObrigatoryLabel extends StatelessWidget {
  final String field;
  final double size;

  const ObrigatoryLabel({ super.key, required this.field, this.size = 16.0 });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "$field ",
        style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: "*",
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
