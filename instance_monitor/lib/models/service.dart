import 'package:flutter/material.dart';
import 'package:instance_monitor/dtos/request/containers_request_dto_v2.dart';

class Service {
  String serviceTemplate;
  String instanceId;
  List<NodeInformation> dockerContainerInformations;

  Service({@required this.serviceTemplate, @required this.instanceId});

  Future loadContainerInformations() async {
    ContainersRequestDtoV2 containersRequestDtoV2 = ContainersRequestDtoV2(
      serviceTemplateName: this.serviceTemplate,
      instanceId: this.instanceId,
    );

    await containersRequestDtoV2.request().then((containerNodeInformations) {
      this.dockerContainerInformations = containerNodeInformations;
    });
  }
}
