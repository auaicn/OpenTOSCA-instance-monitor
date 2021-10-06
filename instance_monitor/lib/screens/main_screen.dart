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
      body: LayeredGraph(topology: example),
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
