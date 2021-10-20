import 'package:flutter/material.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/enums/metric_type.dart';
import 'package:instance_monitor/screens/components/selectable_metric_type.dart';

class MetricsSelectionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 32),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('available metrics >', style: TextStyle(color: Colors.white)),
          SizedBox(width: defaultSpacing),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: MetricType.values.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: defaultHalfSpacing);
              },
              itemBuilder: (BuildContext context, int index) {
                MetricType metricType = MetricType.values[index];

                return SelectableMetricTypeCard(metricType: metricType);
              },
            ),
          ),
        ],
      ),
    );
  }
}
