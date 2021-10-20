import 'package:flutter/material.dart';
import 'package:instance_monitor/enums/metric_type.dart';
import 'package:instance_monitor/providers/metrics_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class GraphPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MetricsProvider>(
      builder: (context, metricsProvider, child) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: SfSparkLineChart(
            data: [1, 2, 100, 54, 64, 37, 86],
            dashArray: [2, 2],
            color: metricsProvider.selectedMetricType.color(),
            trackball: SparkChartTrackball(
              borderWidth: 2,
              borderColor: metricsProvider.selectedMetricType.color(),
              activationMode: SparkChartActivationMode.doubleTap,
            ),
          ),
        );
      },
    );
  }
}
