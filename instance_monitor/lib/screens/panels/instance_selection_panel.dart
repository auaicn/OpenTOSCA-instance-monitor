import 'package:flutter/material.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/logger.dart';
import 'package:instance_monitor/providers/hierarchy_provider.dart';
import 'package:provider/provider.dart';

/// for selected Service, show available instances
class InstanceSelectionPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: defaultPadding),
      child: Column(
        children: [
          DrawerHeader(
            child: Container(
              height: 400,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Instances', textAlign: TextAlign.center),
                  SizedBox(height: defaultHalfSpacing),
                  Text(
                    'scroll to browse',
                    style: Theme.of(context).textTheme.caption.apply(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Consumer<HierarchyProvider>(
            builder: (context, hierarchyProvider, child) {
              String selectedServiceTemplate = hierarchyProvider.selectedServiceTemplate;

              if (selectedServiceTemplate == null) {
                return Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 40),
                  child: Text('please select\n"service templates"\nfirst'),
                );
              }

              var hierarchy = hierarchyProvider.hierarchy;
              List<String> instanceIds = hierarchy[selectedServiceTemplate];

              return Expanded(
                child: ListView.separated(
                  shrinkWrap: false,
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  controller: ScrollController(),
                  itemCount: instanceIds.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    String instanceId = instanceIds[index];
                    logger.i('instance id: $instanceId');

                    return ListTile(
                      selected: instanceId == hierarchyProvider.selectedInstanceId,
                      selectedTileColor: Colors.white10,
                      leading: Image.asset(
                        'assets/icons/instance.png',
                        height: 16,
                        width: 16,
                      ),
                      title: Text(
                        '$instanceId',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white54,
                        ),
                      ),
                      onTap: () {
                        hierarchyProvider.updateInstanceId(selectedInstanceId: instanceId);
                        logger.d('pressed $instanceId');
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
