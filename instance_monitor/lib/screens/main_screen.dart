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
      body: LayeredGraph(),
    );
  }
}
