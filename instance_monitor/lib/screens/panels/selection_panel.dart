import 'package:flutter/material.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/providers/hierarchy_provider.dart';
import 'package:instance_monitor/screens/panels/instance_selection_panel.dart';
import 'package:instance_monitor/screens/panels/service_selection_panel.dart';
import 'package:provider/provider.dart';

class SelectionPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HierarchyProvider>(
      builder: (context, hierarchyProvider, child) {
        Size screenSize = MediaQuery.of(context).size;
        double screenWith = screenSize.width;
        bool hided = hierarchyProvider.hideInstanceSelectionPanel;

        return Row(
          children: [
            if (hided) Container(width: defaultSpacing),
            if (!hided)
              Container(
                width: screenWith * 0.3,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ServiceSelectionPanel(),
                    ),
                    if (hierarchyProvider.isServiceTemplateSelected())
                      Expanded(
                        flex: 2,
                        child: InstanceSelectionPanel(),
                      ),
                  ],
                ),
              ),
            GestureDetector(
              onTap: () => _onPressedHideSelectionPanel(context),
              child: Icon(
                hided ? Icons.chevron_right : Icons.chevron_left,
                size: 32,
              ),
            ),
          ],
        );
      },
    );
  }

  void _onPressedHideSelectionPanel(BuildContext context) {
    HierarchyProvider hierarchyProvider = context.read<HierarchyProvider>();

    hierarchyProvider.flipHideInstanceSelectionPanel();
  }
}
