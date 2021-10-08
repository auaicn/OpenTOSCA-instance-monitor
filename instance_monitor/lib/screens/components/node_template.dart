import 'package:flutter/material.dart';

class NodeTemplate extends StatefulWidget {
  final String label;

  const NodeTemplate({this.label});

  @override
  State<NodeTemplate> createState() => _NodeTemplateState();
}

class _NodeTemplateState extends State<NodeTemplate> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      clipBehavior: Clip.none,
      alignment: Alignment.topLeft,
      children: [
        GestureDetector(
          onTap: onTappedItem,
          child: Container(
            padding: EdgeInsets.all(8),
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
              "${widget.label}",
              style: TextStyle(color: Color(0xFFD9E6FD)),
            ),
          ),
        ),
        Visibility(
          visible: _isExpanded,
          child: Positioned(
            top: 60,
            child: GestureDetector(
              onTap: onTappedItem,
              child: Container(
                height: 100,
                width: 100,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onTappedItem() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}
