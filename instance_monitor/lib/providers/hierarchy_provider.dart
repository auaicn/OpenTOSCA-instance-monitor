import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:instance_monitor/screens/panels/information_panel.dart';
import 'package:instance_monitor/utilities/http_client.dart';

class HierarchyProvider extends ChangeNotifier {
  Map<String, List<String>> hierarchy = {};

  String selectedServiceTemplate;
  String selectedInstanceId;
  String selectedContainerId;

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

  void updateServiceTemplate({@required String selectedServiceTemplate}) {
    if (this.selectedServiceTemplate == selectedServiceTemplate) {
      return;
    }

    this.selectedServiceTemplate = selectedServiceTemplate;
    this.selectedInstanceId = null;
    this.selectedContainerId = null;

    notifyListeners();
  }

  void updateInstanceId({@required String selectedInstanceId}) async {
    if (this.selectedInstanceId == selectedInstanceId) {
      return;
    }

    this.selectedInstanceId = selectedInstanceId;
    this.selectedContainerId = null;
    await _loadContainerIds();

    notifyListeners();
  }

  void updateContainerId({@required String selectedInstanceId}) {
    if (this.selectedContainerId == selectedContainerId) {
      return;
    }

    this.selectedContainerId = selectedContainerId;

    notifyListeners();
  }

  void _loadContainerIds() async {
    String target = '${serverUrlUsingPort(port: 8000)}/$selectedServiceTemplate/instances/$selectedInstanceId';
    Uri uri = Uri.parse(target);
    var response = await loggerHttpClient.get(uri);
    List json = jsonDecode(utf8.decode(response.bodyBytes));

    containerIds.clear();
    json.forEach((containerId) {
      containerIds.add(containerId);
    });
  }

  void _loadSingleContainerMetrics() async {
    String target = '${serverUrlUsingPort(port: 2220)}/containers/$selectedContainerId/stats?stream=false';
    Uri uri = Uri.parse(target);
    var response = await loggerHttpClient.get(uri);
    Map json = jsonDecode(utf8.decode(response.bodyBytes));
  }

  bool isServiceTemplateSelected() {
    return (this.selectedServiceTemplate != null);
  }

  bool isInstanceIdSelected() {
    return (this.selectedInstanceId != null);
  }
}
