import 'package:flutter/material.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/providers/hierarchy_provider.dart';
import 'package:provider/provider.dart';

class ContainerSelectionPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HierarchyProvider>(
      builder: (context, hierarchy, child) {
        final service = hierarchy.getSelectedService();
        final dockerContainerInformations = service.dockerContainerInformations;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Available Containers'),
            SizedBox(height: defaultHalfSpacing),
            ListView.separated(
              itemCount: dockerContainerInformations.length,
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.black38, height: 4);
              },
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => _onTappedContainerId(context, index),
                  child: Text(
                    '- ${dockerContainerInformations[index].topologyLabel}',
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

    final service = hierarchyProvider.getSelectedService();
    final dockerContainerInformations = service.dockerContainerInformations;

    hierarchyProvider.updateSelectedContainerId(selectedContainerId: dockerContainerInformations[index].containerId);
  }
}
