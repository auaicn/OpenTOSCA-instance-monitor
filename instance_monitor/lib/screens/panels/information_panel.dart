import 'package:flutter/material.dart';
import 'package:instance_monitor/constants.dart';

class InformationPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      color: Colors.black12,
      width: double.infinity,
      child: Column(
        children: [
          Text('Detailed Informations'),

          // TODO - detailed information to be here.
        ],
      ),
    );
  }
}
