import 'package:flutter/material.dart';

class Guide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'please select \n1. service templates\n2. instances\n to show topologies',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.caption.apply(color: Colors.grey),
      ),
    );
  }
}
