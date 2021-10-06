import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/models/node_with_label.dart';

import 'node_template.dart';

class LayeredGraph extends StatefulWidget {
  final Map topology;

  const LayeredGraph({
    @required this.topology,
  });

  @override
  _LayeredGraphState createState() => _LayeredGraphState();
}

class _LayeredGraphState extends State<LayeredGraph> {
  final Graph graph = Graph();
  SugiyamaConfiguration builder = SugiyamaConfiguration();

  Map<String, NodeWithLabel> nodes = {};

  @override
  void initState() {
    super.initState();

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
                  )),
            ),
          ),
          Column(
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
    var nodes = widget.topology['nodes'];
    var edges = widget.topology['edges'];

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
}
