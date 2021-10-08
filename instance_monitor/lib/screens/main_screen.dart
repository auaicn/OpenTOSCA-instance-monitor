import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/models/node_with_label.dart';
import 'package:instance_monitor/screens/components/selection_panel.dart';

import 'components/node_template.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Map topology;
  Map hierarchy;

  final Graph graph = Graph();
  SugiyamaConfiguration builder = SugiyamaConfiguration();

  Map<String, NodeWithLabel> nodes = {};

  @override
  void initState() {
    super.initState();

    loadTolopogy();
    loadHierarchy();
    initializeBuilder();
    initializeTopology();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SelectionPanel(hierarchy: hierarchy),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(2 * defaultPadding),
              child: InteractiveViewer(
                constrained: false,
                boundaryMargin: EdgeInsets.all(100),
                minScale: 0.0001,
                maxScale: 10.6,
                child: GraphView(
                  graph: graph,
                  algorithm: SugiyamaAlgorithm(builder),
                  paint: Paint()
                    ..color = Colors.green
                    ..strokeWidth = 1
                    ..style = PaintingStyle.stroke,
                  builder: (Node node) {
                    // I can decide what widget should be shown here based on the id
                    String id = node.key.value;
                    String label = this.nodes[id].label;
                    return NodeTemplate(label: label);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  width: 200,
                  padding: EdgeInsets.all(defaultPadding),
                  child: TextFormField(
                    initialValue: builder.nodeSeparation.toString(),
                    decoration: InputDecoration(labelText: "Node Separation"),
                    onChanged: (text) {
                      builder.nodeSeparation = int.tryParse(text) ?? 60;
                      this.setState(() {});
                    },
                  ),
                ),
                Container(
                  width: 200,
                  padding: EdgeInsets.all(defaultPadding),
                  child: TextFormField(
                    initialValue: builder.levelSeparation.toString(),
                    decoration: InputDecoration(labelText: "Level Separation"),
                    onChanged: (text) {
                      builder.levelSeparation = int.tryParse(text) ?? 100;
                      this.setState(() {});
                    },
                  ),
                ),
                Container(
                  width: 200,
                  padding: EdgeInsets.all(defaultPadding),
                  child: TextFormField(
                    initialValue: builder.orientation.toString(),
                    decoration: InputDecoration(labelText: "Orientation"),
                    onChanged: (text) {
                      builder.orientation = int.tryParse(text) ?? 3;
                      this.setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void initializeBuilder() {
    builder
      ..nodeSeparation = (60)
      ..levelSeparation = (100)
      ..orientation = SugiyamaConfiguration.ORIENTATION_LEFT_RIGHT;
  }

  void initializeTopology() {
    var nodes = topology['nodes'];
    var edges = topology['edges'];

    nodes.forEach((node) {
      String id = node['id'].toString();
      String label = node['label'];
      this.nodes[id] = NodeWithLabel(
        node: Node.Id(id),
        label: label,
      );
    });

    edges.forEach((edge) {
      String idFrom = edge['from'].toString();
      String idTo = edge['to'].toString();
      graph.addEdge(
        this.nodes[idFrom].node,
        this.nodes[idTo].node,
        paint: Paint()..color = Colors.red,
      );
    });
  }

  void loadTolopogy() {
    topology = topologyExample;
  }

  void loadHierarchy() {
    hierarchy = hierarchyExample;
  }
}

var topologyExample = {
  "nodes": [
    {"id": 1, "label": 'circle'},
    {"id": 2, "label": 'ellipse'},
    {"id": 3, "label": 'database'},
    {"id": 4, "label": 'box'},
    {"id": 5, "label": 'diamond'},
    {"id": 6, "label": 'dot'},
    {"id": 7, "label": 'square'},
    {"id": 8, "label": 'triangle'},
  ],
  "edges": [
    {"from": 1, "to": 2},
    {"from": 2, "to": 3},
    {"from": 2, "to": 4},
    {"from": 2, "to": 5},
    {"from": 5, "to": 6},
    {"from": 5, "to": 7},
  ]
};

Map<String, List<int>> hierarchyExample = {
  'RealWorld-Application_Angular-Spring-w1': [49, 220],
  'd1_w1-wip1': [13, 144, 171]
};
