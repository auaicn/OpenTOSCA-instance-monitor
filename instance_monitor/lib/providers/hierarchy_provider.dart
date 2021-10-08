import 'package:flutter/material.dart';

class HierarchyProvider extends ChangeNotifier {
  Map<String, List<String>> hierarchy = {};

  String selectedServiceTemplate;
  String selectedInstanceId;

  HierarchyProvider() {
    fetchData();
  }

  void fetchData() {
    hierarchy.clear();

    hierarchyExample.keys.forEach((serviceTemplateKey) {
      List<int> instanceIds = hierarchyExample[serviceTemplateKey];

      // convert id into string for ease of use
      hierarchy[serviceTemplateKey] = [...instanceIds.map((instanceId) => instanceId.toString())];
    });

    selectedServiceTemplate = null;
    selectedInstanceId = null;
  }

  void updateServiceTemplate({@required String selectedServiceTemplate}) {
    if (this.selectedServiceTemplate == selectedServiceTemplate) {
      // do nothing

      return;
    }

    this.selectedServiceTemplate = selectedServiceTemplate;
    this.selectedInstanceId = null;

    notifyListeners();
  }

  void updateInstanceId({@required String selectedInstanceId}) {
    if (this.selectedInstanceId == selectedInstanceId) {
      // do nothing

      return;
    }

    this.selectedInstanceId = selectedInstanceId;

    notifyListeners();
  }

  bool isServiceTemplateSelected() {
    return (this.selectedServiceTemplate != null);
  }

  bool isInstanceIdSelected() {
    return (this.selectedInstanceId != null);
  }
}

Map<String, List<int>> hierarchyExample = {
  'RealWorld-Application_Angular-Spring-w1': [49, 220],
  'd1_w1-wip1': [13, 144, 171]
};
