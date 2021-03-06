import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/providers/hierarchy_provider.dart';
import 'package:instance_monitor/providers/metrics_provider.dart';
import 'package:instance_monitor/providers/topology_provider.dart';
import 'package:provider/provider.dart';

import 'screens/main_screen.dart';

void main() {
  const apiServerPort = String.fromEnvironment('API_SERVER_PORT', defaultValue: '9999'); 
  const apiServerUri = String.fromEnvironment('PUBLIC_HOSTNAME', defaultValue: '9999'); 

  print('apiServerPort: $apiServerPort');
  print('apiServerUri: $apiServerUri');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HierarchyProvider()),
        ChangeNotifierProvider(create: (_) => TopologyProvider()),
        ChangeNotifierProvider(create: (_) => MetricsProvider()),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'instance dash-board',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        canvasColor: secondaryColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: Colors.white,
        ),
      ),
      home: MainScreen(),
    );
  }
}
