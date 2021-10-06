import 'package:flutter/material.dart';

class NodeTemplate extends StatelessWidget {
  final String label;

  const NodeTemplate({this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2B2C3D),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 4,
          color: Color(0xFF4A5870),
        ),
        boxShadow: [
          BoxShadow(color: Colors.blue[100], spreadRadius: 1),
        ],
      ),
      child: Text(
        "$label",
        style: TextStyle(color: Color(0xFFD9E6FD)),
      ),
    );
  }
}
