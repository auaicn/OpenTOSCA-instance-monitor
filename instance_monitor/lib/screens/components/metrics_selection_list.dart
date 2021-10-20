import 'package:flutter/material.dart';
import 'package:instance_monitor/constants.dart';
import 'package:instance_monitor/enums/metric_type.dart';
import 'package:instance_monitor/providers/hierarchy_provider.dart';
import 'package:instance_monitor/screens/components/selectable_metric_type.dart';
import 'package:provider/provider.dart';

class MetricsSelectionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 32),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton.icon(
            onPressed: () => _onPressedRefreshButton(context),
            label: Text('click to refresh', style: TextStyle(color: Colors.white)),
            icon: Icon(Icons.refresh),
          ),
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

  void _onPressedRefreshButton(BuildContext context) {
    HierarchyProvider hierarchyProvider = context.read<HierarchyProvider>();

    String selectedContainerId = hierarchyProvider.selectedContainerId;
    hierarchyProvider.loadSingleContainerMetrics(containerId: selectedContainerId);
  }
}
