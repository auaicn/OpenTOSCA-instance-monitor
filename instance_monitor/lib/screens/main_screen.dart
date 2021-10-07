import 'package:flutter/material.dart';
import 'package:instance_monitor/screens/components/layered_graph.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayeredGraph(topology: example, hierarchy: hierarchy),
    );
  }
}

var example = {
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

Map<String, List<int>> hierarchy = {
  'RealWorld-Application_Angular-Spring-w1': [49, 220],
  'd1_w1-wip1': [13, 144, 171]
};
