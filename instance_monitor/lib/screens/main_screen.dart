import 'package:flutter/material.dart';
import 'package:instance_monitor/screens/components/control_panel.dart';
import 'package:instance_monitor/screens/components/selection_panel.dart';
import 'components/graph_panel.dart';
import 'components/information_panel.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Map topology;

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
                Expanded(
                  flex: 3,
                  child: SelectionPanel(),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 8,
                  child: GraphPanel(),
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
