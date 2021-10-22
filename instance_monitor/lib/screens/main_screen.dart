import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instance_monitor/logger.dart';
import 'package:instance_monitor/providers/hierarchy_provider.dart';
import 'package:instance_monitor/providers/metrics_provider.dart';
import 'package:instance_monitor/screens/panels/control_panel.dart';
import 'package:instance_monitor/screens/panels/selection_panel.dart';
import 'package:provider/provider.dart';
import 'panels/topology_panel.dart';
import 'panels/information_panel.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ApplicationState applicationState = ApplicationState.HOT;

  @override
  Widget build(BuildContext context) {
    _initialize(context);

    if (applicationState != ApplicationState.READY) {
      return Center(child: CupertinoActivityIndicator());
    } else
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectionPanel(),
                  VerticalDivider(),
                  Expanded(
                    flex: 8,
                    child: TopologyPanel(),
                  ),
                  VerticalDivider(),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: ControlPanel(),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              flex: 2,
              child: InformationPanel(),
            ),
          ],
        ),
      );
  }

  void _initialize(BuildContext context) async {
    switch (applicationState) {
      case ApplicationState.HOT:
        logger.i('Initializing Service...');
        applicationState = ApplicationState.INITIALIZING;
        break;
      case ApplicationState.INITIALIZING:
        logger.i('Build While Initializing');
        return;
      case ApplicationState.READY:
        return;
    }

    HierarchyProvider hierarchyProvider = context.read<HierarchyProvider>();
    await hierarchyProvider.loadServices().then((initializedHierarchyProvider) async {
      MetricsProvider metricsProvider = context.read<MetricsProvider>();
      await Future.forEach(initializedHierarchyProvider.services, (service) async {
        await service.loadContainerInformations().then((_) async {
          metricsProvider.registerServiceForMonitoring(service: service);
        });
      });

      setState(() {
        applicationState = ApplicationState.READY;
      });
    });
  }
}

enum ApplicationState {
  HOT,
  INITIALIZING,
  READY,
}
