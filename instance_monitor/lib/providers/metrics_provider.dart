import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instance_monitor/dtos/request/container_metric_request_dto.dart';
import 'package:instance_monitor/enums/metric_type.dart';
import 'package:instance_monitor/models/container_status.dart';
import 'package:instance_monitor/models/service.dart';

class MetricsProvider extends ChangeNotifier {
  final Duration fetchPeriod = Duration(seconds: 3);

  Map<String, List<ContainerStatus>> metrics = {};

  MetricType selectedMetricType = MetricType.values.first;

  void registerServiceForMonitoring({@required Service service}) {
    service.dockerContainerInformations.forEach((dockerContainerInformation) {
      Timer.periodic(fetchPeriod, (Timer t) => _fetchSingleContainerMetricSnapshot(containerId: dockerContainerInformation.containerId));
    });
  }

  void _fetchSingleContainerMetricSnapshot({@required String containerId}) {
    ContainerMetricRequestDto containerMetricRequestDto = ContainerMetricRequestDto(containerId: containerId);

    containerMetricRequestDto.request().then((containerStatusSnapshot) {
      add(containerId: containerId, metricSnapshot: containerStatusSnapshot);
    });
  }

  void add({@required String containerId, @required ContainerStatus metricSnapshot}) {
    if (metrics[containerId] == null) {
      metrics[containerId] = [];
    }
    metrics[containerId].add(metricSnapshot);
    notifyListeners();
  }

  void updateSelectedMetricType({@required MetricType selectedMetricType}) {
    if (this.selectedMetricType == selectedMetricType) {
      return;
    }

    this.selectedMetricType = selectedMetricType;
    notifyListeners();
  }
}
