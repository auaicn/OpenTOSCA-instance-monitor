import 'package:flutter/material.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/enums/metric_type.dart';
import 'package:instance_monitor/providers/metrics_provider.dart';
import 'package:provider/provider.dart';

class SelectableMetricTypeCard extends StatelessWidget {
  final MetricType metricType;

  const SelectableMetricTypeCard({
    @required this.metricType,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MetricsProvider>(
      builder: (context, metricsProvider, child) {
        bool isSelected = metricType == metricsProvider.selectedMetricType;

        return GestureDetector(
          onTap: () => _onTappedMetricTypeButton(context),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: defaultHalfPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: bgColor,
              border: Border.all(color: isSelected ? metricType.color() : Colors.grey, width: 2),
            ),
            child: Text(
              '${metricType.label()}',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void _onTappedMetricTypeButton(BuildContext context) {
    MetricsProvider metricsProvider = context.read<MetricsProvider>();

    metricsProvider.updateSelectedMetricType(selectedMetricType: metricType);
  }
}
