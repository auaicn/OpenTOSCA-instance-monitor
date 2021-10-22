import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instance_monitor/logger.dart';
import 'package:intl/intl.dart';

import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/enums/metric_type.dart';
import 'package:instance_monitor/models/container_status.dart';
import 'package:instance_monitor/providers/hierarchy_provider.dart';
import 'package:instance_monitor/providers/metrics_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class GraphPanel extends StatelessWidget {
  final int maxNumberOfPoints = 10;
  List<_SalesData> salesData = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer2<HierarchyProvider, MetricsProvider>(
      builder: (context, hierarchy, metrics, child) {
        MetricType selectedMetricType = metrics.selectedMetricType;
        String selectedContainerId = hierarchy.selectedContainerId;
        List<ContainerStatus> wholeContainerMetrics = metrics.metrics[selectedContainerId];
        if (wholeContainerMetrics == null) {
          return Center(child: CupertinoActivityIndicator());
        }

        List<ContainerStatus> recentContainerStatuses = wholeContainerMetrics.limitOnlyLastElements(to: maxNumberOfPoints);
        return Scaffold(
          body: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: AspectRatio(
                aspectRatio: 2,
                child: SfSparkLineChart.custom(
                  width: 2,
                  xValueMapper: (int index) => recentContainerStatuses[index].xValueMapper(),
                  yValueMapper: (int index) => recentContainerStatuses[index].yValueMapper(selectedMetricType: selectedMetricType),
                  dataCount: recentContainerStatuses.length,
                  dashArray: [2, 2],
                  highPointColor: Colors.red,
                  axisLineColor: Colors.white,
                  lowPointColor: Colors.blue,
                  labelDisplayMode: SparkChartLabelDisplayMode.all,
                  axisCrossesAt: 0,
                  color: selectedMetricType.color(),
                  marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
                  trackball: SparkChartTrackball(
                    borderWidth: 2,
                    borderColor: selectedMetricType.color(),
                    activationMode: SparkChartActivationMode.tap,
                    tooltipFormatter: handleTooltipFormatter,
                  ),
                ),
              )),
        );
      },
    );
  }

  String handleTooltipFormatter(TooltipFormatterDetails details) {
    return details.y.toStringAsFixed(0);
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

extension Mapper on ContainerStatus {
  String xValueMapper() {
    return this.containerInformation.read.toDateTime().toReadableString();
  }

  num yValueMapper({@required MetricType selectedMetricType}) {
    switch (selectedMetricType) {
      case MetricType.USED_MEMORY:
        return this.usedMemory;
      case MetricType.AVAILABLE_MEMORY:
        return this.availableMemory;
      case MetricType.CPU_DELTA:
        return this.cpuDelta;
      case MetricType.SYSTEM_CPU_DELTA:
        return this.systemCpuDelta;
      case MetricType.NUMBER_CPUS:
        return this.numberCpus;
      case MetricType.MEMORY_USAGE_IN_PERCETAGE:
        return this.memoryUsageInPercent;
      case MetricType.CPU_USAGE_IN_PERCETAGE:
        return this.cpuUsageInPercent;
      default:
        return 0;
    }
  }
}

extension DateTimes on String {
  DateTime toDateTime() {
    return DateFormat('yyyy-MM-ddThh:mm:ss').parse(this);
  }
}

extension ToString on DateTime {
  String toReadableString() {
    return DateFormat('yyyy-MM-dd\nhh:mm:ss').format(this);
  }
}

extension Limits on List<ContainerStatus> {
  List limitOnlyLastElements({@required int to}) {
    if (this.length <= to) {
      return this;
    } else {
      return this.sublist(this.length - to);
    }
  }
}
