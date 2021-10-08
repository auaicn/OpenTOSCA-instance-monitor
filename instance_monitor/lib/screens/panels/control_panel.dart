import 'package:flutter/material.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/providers/hierarchy_provider.dart';
import 'package:instance_monitor/providers/topology_provider.dart';
import 'package:instance_monitor/screens/components/guide_text.dart';
import 'package:provider/provider.dart';

class ControlPanel extends StatefulWidget {
  @override
  State<ControlPanel> createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<HierarchyProvider, TopologyProvider>(
      builder: (context, hierarchyProvider, topologyProvider, child) {
        if (!hierarchyProvider.isInstanceIdSelected()) {
          return GuideText();
        }

        return Center(
          child: Column(
            children: [
              Container(
                width: 200,
                padding: EdgeInsets.all(defaultPadding),
                child: TextFormField(
                  initialValue: topologyProvider.builder.nodeSeparation.toString(),
                  decoration: InputDecoration(labelText: "Node Separation"),
                  onChanged: (text) {
                    int value = int.tryParse(text) ?? 60;

                    topologyProvider.updateNodeSeperation(newValue: value);
                  },
                ),
              ),
              Container(
                width: 200,
                padding: EdgeInsets.all(defaultPadding),
                child: TextFormField(
                  initialValue: topologyProvider.builder.levelSeparation.toString(),
                  decoration: InputDecoration(labelText: "Level Separation"),
                  onChanged: (text) {
                    int value = int.tryParse(text) ?? 100;

                    topologyProvider.updateLevelSeperation(newValue: value);
                  },
                ),
              ),
              Container(
                width: 200,
                padding: EdgeInsets.all(defaultPadding),
                child: TextFormField(
                  initialValue: topologyProvider.builder.orientation.toString(),
                  decoration: InputDecoration(labelText: "Orientation"),
                  onChanged: (text) {
                    int value = int.tryParse(text) ?? 3;

                    topologyProvider.updateOrientation(newValue: value);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
