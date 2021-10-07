import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/logger.dart';
import 'package:instance_monitor/providers/service_provider.dart';
import 'package:provider/src/provider.dart';

class SelectionPanel extends StatelessWidget {
  final Map<String, List<int>> hierarchy;

  const SelectionPanel({
    @required this.hierarchy,
  });

  @override
  Widget build(BuildContext context) {
    List<String> serviceTemplates = [...hierarchy.keys];

    logger.i('#serviceTemplates: ${serviceTemplates.length}');
    logger.i('$serviceTemplates');

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
          ListView.separated(
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
                  final serviceProvider = context.read<ServiceProvider>();

                  serviceProvider.updateServiceTemplate(selectedServiceTemplate: serviceTemplateName);

                  logger.d('pressed $serviceTemplateName');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
