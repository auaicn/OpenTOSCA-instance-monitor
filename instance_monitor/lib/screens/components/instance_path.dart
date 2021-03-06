import 'package:flutter/material.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/providers/hierarchy_provider.dart';
import 'package:provider/provider.dart';

class InstancePath extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HierarchyProvider>(
      builder: (context, hierarchyProvider, child) {
        return Container(
          padding: EdgeInsets.all(defaultHalfPadding),
          margin: EdgeInsets.all(defaultHalfPadding),
          color: bgColor,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: defaultHalfPadding),
              if (hierarchyProvider.isServiceTemplateSelected())
                Text(
                  '${hierarchyProvider.selectedServiceTemplate}',
                  style: Theme.of(context).textTheme.bodyText1.apply(color: Colors.blueAccent),
                ),
              SizedBox(width: defaultHalfPadding),
              if (hierarchyProvider.isInstanceIdSelected())
                Text(
                  '> ${hierarchyProvider.selectedInstanceId}',
                  style: Theme.of(context).textTheme.bodyText1.apply(color: Colors.blueGrey),
                ),
            ],
          ),
        );
      },
    );
  }
}
