import 'package:flutter/material.dart';
import 'package:instance_monitor/screens/panels/control_panel.dart';
import 'package:instance_monitor/screens/panels/selection_panel.dart';
import 'panels/topology_panel.dart';
import 'panels/information_panel.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectionPanel(),
                VerticalDivider(),
                Expanded(
                  flex: 8,
                  child: TopologyPanel(),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: ControlPanel(),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            flex: 2,
            child: InformationPanel(),
          ),
        ],
      ),
    );
  }
}
