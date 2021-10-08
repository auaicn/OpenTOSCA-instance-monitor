import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/providers/hierarchy_provider.dart';
import 'package:instance_monitor/providers/topology_provider.dart';
import 'package:instance_monitor/screens/components/node_template.dart';
import 'package:provider/provider.dart';

class GraphPanel extends StatefulWidget {
  @override
  State<GraphPanel> createState() => _GraphPanelState();
}

class _GraphPanelState extends State<GraphPanel> with TickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    initializeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TopologyProvider, HierarchyProvider>(
      builder: (context, topologyProvider, hierarchyProvider, child) {
        controller.value = 0;
        controller.forward();

        bool isInstanceSelected = (hierarchyProvider.isServiceTemplateSelected() && hierarchyProvider.isInstanceIdSelected());

        if (!isInstanceSelected) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              'please select \n1. service templates\n2. instances\n to show topologies',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6.apply(
                    color: Colors.white,
                  ),
            ),
          );
        }

        return FadeTransition(
          opacity: animation,
          child: Container(
            color: Colors.white10,
            padding: const EdgeInsets.all(2 * defaultPadding),
            child: InteractiveViewer(
              constrained: false,
              boundaryMargin: EdgeInsets.all(100),
              minScale: 0.0001,
              maxScale: 10.6,
              child: GraphView(
                graph: topologyProvider.currentGraph,
                algorithm: SugiyamaAlgorithm(topologyProvider.builder),
                paint: Paint()
                  ..color = Colors.green
                  ..strokeWidth = 1
                  ..style = PaintingStyle.stroke,
                builder: (Node node) {
                  // I can decide what widget should be shown here based on the id
                  String id = node.key.value;
                  String label = topologyProvider.nodeById[id].label;
                  return NodeTemplate(label: label);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void initializeAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(controller);
  }
}
