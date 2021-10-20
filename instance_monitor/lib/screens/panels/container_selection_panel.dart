import 'package:flutter/material.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/providers/hierarchy_provider.dart';
import 'package:provider/provider.dart';

class ContainerSelectionPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HierarchyProvider>(
      builder: (context, hierarchy, child) {
        var containerIds = hierarchy.selectedService.containerIds;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Available Containers'),
            SizedBox(height: defaultHalfSpacing),
            ListView.separated(
              itemCount: containerIds.length,
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.black38, height: 4);
              },
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => _onTappedContainerId(context, index),
                  child: Text(
                    '- ${containerIds[index].substring(0, 12)}',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _onTappedContainerId(BuildContext context, int index) {
    HierarchyProvider hierarchyProvider = context.read<HierarchyProvider>();
    hierarchyProvider.updateSelectedContainerId(selectedContainerId: hierarchyProvider.selectedService.containerIds[index]);
  }
}
