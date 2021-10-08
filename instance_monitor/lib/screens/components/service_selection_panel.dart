import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/logger.dart';
import 'package:instance_monitor/providers/hierarchy_provider.dart';
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
              child: Text('Service\nTemplates'),
            ),
          ),
          Consumer<HierarchyProvider>(builder: (context, hierarchyProvider, child) {
            List<String> serviceTemplates = [...hierarchyProvider.hierarchy.keys];
            logger.i('$serviceTemplates');

            return ListView.separated(
              shrinkWrap: true,
              itemCount: serviceTemplates.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 16);
              },
              itemBuilder: (BuildContext context, int index) {
                String serviceTemplateName = serviceTemplates[index];

                return ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/menu_dashboard.svg',
                    color: Colors.white54,
                    height: 16,
                  ),
                  title: Text(
                    serviceTemplateName,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white54,
                    ),
                  ),
                  onTap: () {
                    hierarchyProvider.updateServiceTemplate(selectedServiceTemplate: serviceTemplateName);

                    logger.d('pressed $serviceTemplateName');
                  },
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
