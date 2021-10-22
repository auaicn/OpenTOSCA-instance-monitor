import 'package:flutter/material.dart';
import 'package:instance_monitor/dtos/request/instances_request_dto.dart';
import 'package:instance_monitor/dtos/request/serviceTemplates_request_dto.dart';
import 'package:instance_monitor/models/service.dart';

class HierarchyProvider extends ChangeNotifier {
  Map<String, List<String>> hierarchy = {};
  List<Service> services = [];

  String selectedServiceTemplate;
  String selectedInstanceId;
  String selectedContainerId;

  bool hideInstanceSelectionPanel = false;

  Future<HierarchyProvider> loadServices() async {
    this.selectedServiceTemplate = null;
    this.selectedInstanceId = null;

    this.hierarchy.clear();
    this.services.clear();
    await ServiceTemplatesRequestDto().request().then((serviceTemplates) async {
      await Future.forEach(serviceTemplates, (serviceTemplateName) async {
        if (hierarchy[serviceTemplateName] == null) {
          hierarchy[serviceTemplateName] = [];
        }

        await InstancesRequestDto(serviceTemplateName: (serviceTemplateName as String)).request().then((intanceIds) async {
          await Future.forEach(intanceIds, (instanceId) async {
            this.services.add(Service(serviceTemplate: serviceTemplateName, instanceId: instanceId.toString()));
          });
        });
      });
    }).then((_) => _buildHierarchy());

    return this;
  }

  void _buildHierarchy() {
    hierarchy.clear();
    services.forEach((service) {
      if (hierarchy[service.serviceTemplate] == null) {
        hierarchy[service.serviceTemplate] = [];
      }
      hierarchy[service.serviceTemplate].add(service.instanceId);
    });
  }

  void updateSelectedServiceTemplate({@required String selectedServiceTemplate}) {
    if (this.selectedServiceTemplate == selectedServiceTemplate) {
      return;
    }

    this.selectedServiceTemplate = selectedServiceTemplate;
    this.selectedInstanceId = null;

    notifyListeners();
  }

  void updateSelectedInstanceId({@required String selectedInstanceId}) {
    if (this.selectedInstanceId == selectedInstanceId) {
      return;
    }

    this.selectedInstanceId = selectedInstanceId;
    this.selectedContainerId = null;

    notifyListeners();
  }

  void updateSelectedContainerId({@required String selectedContainerId}) {
    if (this.selectedContainerId == selectedContainerId) {
      return;
    }

    this.selectedContainerId = selectedContainerId;

    notifyListeners();
  }

  Service getSelectedService() {
    Service selectedService;
    services.forEach((service) {
      if (service.serviceTemplate == selectedServiceTemplate && service.instanceId == selectedInstanceId) {
        selectedService = service;
      }
    });
    return selectedService;
  }

  ///
  /// below utilities
  ///
  bool isServiceTemplateSelected() {
    return (this.selectedServiceTemplate != null);
  }

  bool isInstanceIdSelected() {
    return (this.selectedInstanceId != null);
  }

  void flipHideInstanceSelectionPanel() {
    hideInstanceSelectionPanel = !hideInstanceSelectionPanel;
    notifyListeners();
  }
}
