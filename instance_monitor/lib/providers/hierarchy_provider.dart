import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:instance_monitor/enums/metric_type.dart';
import 'package:instance_monitor/models/container_status.dart';
import 'package:instance_monitor/screens/panels/information_panel.dart';
import 'package:instance_monitor/utilities/http_client.dart';

class HierarchyProvider extends ChangeNotifier {
  Map<String, List<String>> hierarchy = {};

  String selectedServiceTemplate;
  String selectedInstanceId;
  String selectedContainerId;
  MetricType selectedMetricType;

  bool hideInstanceSelectionPanel = false;

  List<String> containerIds = [];

  HierarchyProvider() {
    fetchData();
  }

  void fetchData() async {
    selectedServiceTemplate = null;
    selectedInstanceId = null;

    loadServiceTemplates().then((names) => loadInstances(names));
  }

  Future loadServiceTemplates() async {
    String target = serverUrlUsingPort(port: 8000) + '/';
    Uri uri = Uri.parse(target);
    var response = await loggerHttpClient.get(uri);
    List json = jsonDecode(utf8.decode(response.bodyBytes));
    return json;
  }

  void loadInstances(List names) async {
    hierarchy.clear();
    names.forEach((name) async {
      loadInstance(name: name);
    });
  }

  void loadInstance({String name}) async {
    String target = serverUrlUsingPort(port: 8000) + '/$name' + '/instances';
    Uri uri = Uri.parse(target);
    var response = await loggerHttpClient.get(uri);
    List json = jsonDecode(utf8.decode(response.bodyBytes));

    hierarchy[name] = [];
    json.forEach((id) {
      hierarchy[name].add(id.toString());
    });
    notifyListeners();
  }

  void updateSelectedServiceTemplate({@required String selectedServiceTemplate}) {
    if (this.selectedServiceTemplate == selectedServiceTemplate) {
      return;
    }

    this.selectedServiceTemplate = selectedServiceTemplate;
    this.selectedInstanceId = null;
    this.selectedContainerId = null;

    notifyListeners();
  }

  void updateSelectedInstanceId({@required String selectedInstanceId}) {
    if (this.selectedInstanceId == selectedInstanceId) {
      return;
    }

    this.selectedInstanceId = selectedInstanceId;
    this.selectedContainerId = null;

    // TODO - make it initially invoked
    _loadContainerIds().then((_) => notifyListeners());
  }

  void updateSelectedContainerId({@required String selectedContainerId}) {
    if (this.selectedContainerId == selectedContainerId) {
      return;
    }

    this.selectedContainerId = selectedContainerId;

    notifyListeners();
  }

  void updateSelectedMetricType({@required MetricType selectedMetricType}) {
    if (this.selectedMetricType == selectedMetricType) {
      return;
    }

    this.selectedMetricType = selectedMetricType;
    notifyListeners();
  }

  void flipHideInstanceSelectionPanel() {
    hideInstanceSelectionPanel = !hideInstanceSelectionPanel;
    notifyListeners();
  }

  Future _loadContainerIds() async {
    String target = '${serverUrlUsingPort(port: 8000)}/$selectedServiceTemplate/instances/$selectedInstanceId';
    Uri uri = Uri.parse(target);
    var response = await loggerHttpClient.get(uri);
    List json = jsonDecode(utf8.decode(response.bodyBytes));

    containerIds.clear();
    json.forEach((containerId) {
      containerIds.add(containerId);
    });
    return;
  }

  // TODO - make this periodically invoked and saved.
  Future<ContainerStatus> loadSingleContainerMetrics({@required String containerId}) async {
    String target = '${serverUrlUsingPort(port: 2220)}/containers/$selectedContainerId/stats?stream=false';
    Uri uri = Uri.parse(target);
    var response = await loggerHttpClient.get(uri);
    Map json = jsonDecode(utf8.decode(response.bodyBytes));

    return ContainerStatus.fromJson(json);
  }

  bool isServiceTemplateSelected() {
    return (this.selectedServiceTemplate != null);
  }

  bool isInstanceIdSelected() {
    return (this.selectedInstanceId != null);
  }
}
