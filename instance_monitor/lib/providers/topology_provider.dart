import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:instance_monitor/dtos/request/topology_request_dto.dart';
import 'package:instance_monitor/models/node_with_label.dart';

class TopologyProvider extends ChangeNotifier {
  SugiyamaConfiguration builder = SugiyamaConfiguration();
  Map<String, NodeWithLabel> nodeById = {};

  Graph currentGraph;

  TopologyProvider() {
    _initializeBuilder();
  }

  void loadSelectedTopology({@required String serviceTemplateName}) {
    TopologyRequestDto(serviceTemplateName: serviceTemplateName).request().then((topology) {
      _drawGraph(topology);
    });
  }

  void _drawGraph(Map<String, List> topology) {
    currentGraph = _graphFromJson(topology);
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

  void _initializeBuilder() {
    builder
      ..nodeSeparation = (60)
      ..levelSeparation = (100)
      ..orientation = SugiyamaConfiguration.ORIENTATION_LEFT_RIGHT;
  }

  Graph _graphFromJson(Map<String, List> topologyInJson) {
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
