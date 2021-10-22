import 'package:flutter/material.dart';
import 'package:instance_monitor/providers/hierarchy_provider.dart';
import 'package:instance_monitor/screens/components/metrics_selection_list.dart';
import 'package:instance_monitor/screens/panels/graph_panel.dart';
import 'package:provider/provider.dart';

class MetricsPanel extends StatefulWidget {
  @override
  State<MetricsPanel> createState() => _MetricsPanelState();
}

class _MetricsPanelState extends State<MetricsPanel> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HierarchyProvider>(
      builder: (context, hierarchy, child) {
        if (hierarchy.selectedContainerId == null) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              '< please select docker container id.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption.apply(color: Colors.grey),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MetricsSelectionList(),
            Expanded(
              child: GraphPanel(),
            ),
          ],
        );
      },
    );
  }
}
