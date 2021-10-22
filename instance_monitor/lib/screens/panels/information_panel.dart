import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/providers/hierarchy_provider.dart';
import 'package:instance_monitor/screens/panels/container_selection_panel.dart';
import 'package:instance_monitor/screens/panels/metrics_panel.dart';
import 'package:provider/provider.dart';

class InformationPanel extends StatefulWidget {
  @override
  State<InformationPanel> createState() => _InformationPanelState();
}

class _InformationPanelState extends State<InformationPanel> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HierarchyProvider>(
      builder: (context, hierarchy, child) {
        return Container(
          padding: EdgeInsets.all(defaultPadding),
          color: Colors.black12,
          width: double.infinity,
          child: Visibility(
            visible: hierarchy.selectedInstanceId != null,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ContainerSelectionPanel(),
                ),
                Expanded(
                  flex: 8,
                  child: MetricsPanel(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
