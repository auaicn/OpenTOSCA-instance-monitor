import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:instance_monitor/models/node_with_label.dart';
import 'package:instance_monitor/screens/panels/information_panel.dart';
import 'package:instance_monitor/utilities/http_client.dart';

class TopologyProvider extends ChangeNotifier {
  SugiyamaConfiguration builder = SugiyamaConfiguration();
  Map<String, NodeWithLabel> nodeById = {};

  Graph currentGraph;

  TopologyProvider() {
    _initializeBuilder();
  }

  void loadSelectedTopology({@required String serviceTemplateName}) {
    _loadTopology(serviceTemplateName).then((topology) {
      _drawGraph(topology);
    });
  }

  Future<Map<String, List>> _loadTopology(String serviceTemplateName) async {
    String target = '${serverUrlUsingPort(port: 8000)}/$serviceTemplateName/topology';
    Uri uri = Uri.parse(target);
    var response = await loggerHttpClient.get(uri);
    Map json = jsonDecode(utf8.decode(response.bodyBytes));

    Map<String, List> topology = {};
    if (json['nodes'] != null) {
      List nodes = json['nodes'];
      topology['nodes'] = nodes;
    }
    if (json['edges'] != null) {
      List edges = json['edges'];
      topology['edges'] = edges;
    }

    return topology;
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
