import 'package:flutter/material.dart';
import 'package:instance_monitor/providers/hierarchy_provider.dart';
import 'package:instance_monitor/screens/components/instance_selection_panel.dart';
import 'package:instance_monitor/screens/components/service_selection_panel.dart';
import 'package:provider/provider.dart';

class SelectionPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HierarchyProvider>(
      builder: (context, hierarchyProvider, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: ServiceSelectionPanel(),
            ),
            if (hierarchyProvider.isServiceTemplateSelected())
              Expanded(
                flex: 1,
                child: InstanceSelectionPanel(),
              ),
          ],
        );
      },
    );
  }
}
