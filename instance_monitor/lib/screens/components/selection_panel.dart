import 'package:flutter/material.dart';
import 'package:instance_monitor/screens/components/instance_selection_panel.dart';
import 'package:instance_monitor/screens/components/service_selection_panel.dart';

class SelectionPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: ServiceSelectionPanel()),
        VerticalDivider(),
        Expanded(child: InstanceSelectionPanel()),
      ],
    );
  }
}
