import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:instance_monitor/models/node_with_label.dart';

class TopologyProvider extends ChangeNotifier {
  Map topology;

  SugiyamaConfiguration builder = SugiyamaConfiguration();
  Map<String, NodeWithLabel> nodeById = {};

  Graph currentGraph;

  TopologyProvider() {
    initializeBuilder();

    fetchData();
  }

  void fetchData() {
    topology = topologyExample;

    currentGraph = graphFromJson(topology);
  }

  void fetch({@required String serviceTemplateName}) {
    /*
    TODO using get request, fetch TOSCA topology file with given ServiceTemplate

    set topology 
    */

    topology = topologyExample;

    currentGraph = graphFromJson(topology);
  }

  void updateNodeSeperation({@required int newValue}) {
    builder.nodeSeparation = newValue;

    notifyListeners();
  }

  void updateLevelSeperation({@required int newValue}) {
    builder.levelSeparation = newValue;

    notifyListeners();
  }

  void updateOrientation({@required int newValue}) {
    builder.orientation = newValue;

    notifyListeners();
  }

  void initializeBuilder() {
    builder
      ..nodeSeparation = (60)
      ..levelSeparation = (100)
      ..orientation = SugiyamaConfiguration.ORIENTATION_LEFT_RIGHT;
  }

  Graph graphFromJson(Map topologyInJson) {
    Graph graph = Graph();

    var nodes = topologyInJson['nodes'];
    var edges = topologyInJson['edges'];

    nodeById = {};
    nodes.forEach((node) {
      String id = node['id'].toString();
      String label = node['label'];
      nodeById[id] = NodeWithLabel(
        node: Node.Id(id),
        label: label,
      );
    });

    edges.forEach((edge) {
      String idFrom = edge['from'].toString();
      String idTo = edge['to'].toString();
      graph.addEdge(
        nodeById[idFrom].node,
        nodeById[idTo].node,
        paint: Paint()..color = Colors.red,
      );
    });

    return graph;
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
