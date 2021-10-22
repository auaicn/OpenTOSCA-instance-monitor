import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/providers/hierarchy_provider.dart';
import 'package:instance_monitor/providers/topology_provider.dart';
import 'package:provider/provider.dart';

class ServiceSelectionPanel extends StatelessWidget {
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
                  Text('Service\nTemplates', textAlign: TextAlign.center),
                  SizedBox(height: defaultHalfSpacing),
                  Text(
                    'scroll ↓ to see more',
                    style: Theme.of(context).textTheme.caption.apply(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Consumer2<HierarchyProvider, TopologyProvider>(
            builder: (context, hierarchyProvider, topology, child) {
              List<String> serviceTemplates = [...hierarchyProvider.hierarchy.keys];

              return Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: serviceTemplates.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    String serviceTemplateName = serviceTemplates[index];

                    return ListTile(
                      selected: serviceTemplateName == hierarchyProvider.selectedServiceTemplate,
                      selectedTileColor: Colors.white10,
                      leading: hierarchyProvider.isServiceTemplateSelected()
                          ? null
                          : SvgPicture.asset(
                              'assets/icons/menu_dashboard.svg',
                              color: Colors.white54,
                              height: 16,
                            ),
                      title: Text(
                        serviceTemplateName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption.apply(color: Colors.white54),
                      ),
                      onTap: () {
                        hierarchyProvider.updateSelectedServiceTemplate(selectedServiceTemplate: serviceTemplateName);
                        topology.loadSelectedTopology(serviceTemplateName: hierarchyProvider.selectedServiceTemplate);
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
